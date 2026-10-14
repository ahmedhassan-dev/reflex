import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/features/practice/domain/card_selector.dart';
import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/features/practice/domain/grader.dart';
import 'package:reflex_server/src/features/practice/domain/score_calculator.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Core practice orchestrator for student flashcard sessions.
class PracticeService {
  final IQuestionRepository questionRepo;
  final IQuestionOptionRepository optionRepo;
  final IAcceptedAnswerRepository acceptedAnswerRepo;
  final IAttemptRepository attemptRepo;
  final IReviewStateRepository reviewStateRepo;
  final ICourseRepository? courseRepo;
  final ICourseSubscriptionRepository? subscriptionRepo;
  final Clock clock;
  final CardSelector cardSelector;

  PracticeService({
    required this.questionRepo,
    required this.optionRepo,
    required this.acceptedAnswerRepo,
    required this.attemptRepo,
    required this.reviewStateRepo,
    required this.clock,
    this.courseRepo,
    this.subscriptionRepo,
    CardSelector? cardSelector,
  }) : cardSelector = cardSelector ??
            CardSelector(
              questionRepository: questionRepo,
              reviewStateRepository: reviewStateRepo,
            );

  /// Serves the next card due for review or unattempted in the course deck.
  /// Stamps `lastServedAt` and clears `helpUsed` on the card's [ReviewState].
  Future<PracticeItem?> serveNextCard({
    required int profileId,
    required int courseId,
  }) async {
    if (courseRepo != null && subscriptionRepo != null) {
      final course = await courseRepo!.findById(courseId);
      if (course != null && course.isPublic == false) {
        final sub = await subscriptionRepo!.findByCourseAndStudent(courseId, profileId);
        if (sub?.status != SubscriptionStatus.accepted) {
          throw const CourseAccessDeniedException(
            'This course is private. You must be accepted by the teacher to practice.',
          );
        }
      }
    }

    final now = clock.now();

    final selection = await cardSelector.selectNextCard(
      profileId: profileId,
      courseId: courseId,
      now: now,
    );

    if (selection == null) return null;

    final question = selection.question;

    // Stamp ReviewState as served now
    final existingReview = await reviewStateRepo.get(profileId, question.id!);
    final stateToSave = (existingReview ??
            ReviewState(
              profileId: profileId,
              questionId: question.id!,
              dueAt: now,
              intervalDays: 0,
              lapses: 0,
              helpUsed: false,
            ))
        .copyWith(lastServedAt: now, helpUsed: false);
    await reviewStateRepo.upsert(stateToSave);

    // Fetch options for multiple choice
    List<QuestionOptionView>? optionViews;
    if (question.questionType == QuestionType.multipleChoice) {
      final options = await optionRepo.getOptionsForQuestion(question.id!);
      optionViews = options.map((o) => QuestionOptionView(id: o.id!, text: o.text)).toList();
    }

    // Build QuestionView without secret answers or topicNote
    final questionView = QuestionView(
      id: question.id!,
      prompt: question.prompt,
      topic: question.topic,
      questionType: question.questionType,
      options: optionViews,
      points: question.points,
      expectedSeconds: question.expectedSeconds,
      hasHelpHint: question.helpHint != null && question.helpHint!.trim().isNotEmpty,
    );

    final totalScore = await ScoreCalculator.calculateTotalScore(
      attemptRepo: attemptRepo,
      questionRepo: questionRepo,
      profileId: profileId,
      courseId: courseId,
    );
    return PracticeItem(question: questionView, kind: selection.kind, totalScore: totalScore);
  }

  /// Requests a help hint for the currently served card.
  /// Flags the card as having used help.
  Future<HelpResult> requestHelp({
    required int profileId,
    required int questionId,
  }) async {
    final state = await reviewStateRepo.get(profileId, questionId);
    if (state == null || state.lastServedAt == null) {
      throw NoActiveCardException();
    }

    // Mark helpUsed
    await reviewStateRepo.upsert(state.copyWith(helpUsed: true));

    final question = await questionRepo.findById(questionId);
    if (question == null) {
      throw QuestionNotFoundException(questionId);
    }

    return HelpResult(
      helpHint: question.helpHint ?? 'Think carefully about the core concept.',
    );
  }

  /// Submits an answer (MCQ option ID or text).
  ///
  /// Enforces idempotency via `lastServedAt` verification, calculates latency,
  /// grades, updates spaced repetition interval, applies atomic counter SQL,
  /// and returns [SubmitResult] with explanations and teacher topic note.
  Future<SubmitResult> submitAnswer({
    required int profileId,
    required int questionId,
    String? textAnswer,
    int? optionId,
  }) async {
    final state = await reviewStateRepo.get(profileId, questionId);
    if (state == null || state.lastServedAt == null) {
      throw CardAlreadyAnsweredException();
    }

    final now = clock.now();
    final responseMs = now.difference(state.lastServedAt!).inMilliseconds;

    final question = await questionRepo.findById(questionId);
    if (question == null) {
      throw QuestionNotFoundException(questionId);
    }

    // Grade answer
    late final AttemptStatus status;
    List<OptionExplanationView>? optionExplanations;
    String? selectedOptionExplanation;

    if (optionId != null) {
      final options = await optionRepo.getOptionsForQuestion(questionId);
      status = Grader.gradeOptionById(optionId, options);

      final selectedOpt = options.where((o) => o.id == optionId).firstOrNull;
      selectedOptionExplanation = selectedOpt?.explanation;

      optionExplanations = options
          .map((o) => OptionExplanationView(
                optionId: o.id!, text: o.text, isCorrect: o.isCorrect, explanation: o.explanation))
          .toList();
    } else {
      final accepted = await acceptedAnswerRepo.getByQuestionId(questionId);
      status = Grader.grade(
        studentAnswer: textAnswer ?? '',
        acceptedAnswers: accepted.map((a) => a.normalizedText).toList(),
      );
    }

    // Determine prior profile history on this question
    final hasPriorAttempt = await attemptRepo.hasPriorAttempt(profileId, questionId);
    final hasLearnerSolvedBefore = await attemptRepo.hasProfileSolvedQuestion(profileId, questionId);

    // Calculate outcome metrics and counter deltas
    final outcome = AttemptOutcomeCalculator.calculate(
      status: status,
      usedHelp: state.helpUsed,
      responseMs: responseMs,
      expectedSeconds: question.expectedSeconds,
      isFirstAttempt: !hasPriorAttempt,
      isFirstSolveByStudent: !hasLearnerSolvedBefore,
    );

    // Persist attempt
    final attempt = Attempt(
      profileId: profileId,
      questionId: questionId,
      selectedOptionId: optionId,
      answerText: textAnswer,
      status: outcome.status,
      responseMs: responseMs,
      usedHelp: state.helpUsed,
      isFirstAttempt: !hasPriorAttempt,
      underExpectedTime: outcome.underExpectedTime,
      isClean: outcome.isClean,
      reflexTier: outcome.reflexTier,
      createdAt: now,
    );
    await attemptRepo.insert(attempt);

    // Clear lastServedAt to enforce idempotency and schedule next review
    final nextDueAt = now.add(Duration(days: outcome.intervalDays));
    final updatedState = state.copyWith(
      dueAt: nextDueAt,
      intervalDays: outcome.intervalDays,
      lapses: state.lapses + outcome.lapsesDelta,
      lastServedAt: null,
      lastResult: outcome.status,
      helpUsed: false,
    );
    await reviewStateRepo.upsert(updatedState);

    // Atomically increment question counters
    await questionRepo.applyCounterDeltas(questionId, outcome.counterDeltas);

    final awardedPoints = ScoreCalculator.calculateAwardedPoints(
      status: outcome.status,
      hasLearnerSolvedBefore: hasLearnerSolvedBefore,
      questionPoints: question.points,
    );
    final totalScore = await ScoreCalculator.calculateTotalScore(
      attemptRepo: attemptRepo,
      questionRepo: questionRepo,
      profileId: profileId,
      courseId: question.courseId,
    );

    return SubmitResult(
      verdict: outcome.status,
      reason: outcome.reason,
      reflexTier: outcome.reflexTier,
      points: awardedPoints,
      totalScore: totalScore,
      responseMs: responseMs,
      nextDueAt: nextDueAt,
      topicNote: question.topicNote,
      selectedOptionExplanation: selectedOptionExplanation,
      optionExplanations: optionExplanations,
    );
  }

  /// Requests subscription to a private course.
  Future<CourseSubscription> requestSubscription({
    required int profileId,
    required int courseId,
  }) async {
    if (courseRepo != null) {
      final course = await courseRepo!.findById(courseId);
      if (course == null) throw CourseNotFoundException(courseId);
    }
    if (subscriptionRepo == null) {
      throw const ValidationException('Subscription repository is not configured.');
    }

    final existing = await subscriptionRepo!.findByCourseAndStudent(courseId, profileId);
    if (existing != null) {
      if (existing.status == SubscriptionStatus.accepted) return existing;
      final updated = existing.copyWith(
        status: SubscriptionStatus.pending,
        requestedAt: clock.now(),
        decidedAt: null,
      );
      return subscriptionRepo!.save(updated);
    }

    final newSub = CourseSubscription(
      courseId: courseId,
      studentId: profileId,
      status: SubscriptionStatus.pending,
      requestedAt: clock.now(),
    );
    return subscriptionRepo!.save(newSub);
  }

  /// Checks the subscription status of a student for a course.
  Future<SubscriptionStatus?> getSubscriptionStatus({
    required int profileId,
    required int courseId,
  }) async {
    if (subscriptionRepo == null) return null;
    final sub = await subscriptionRepo!.findByCourseAndStudent(courseId, profileId);
    return sub?.status;
  }
}
