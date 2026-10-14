import 'package:test/test.dart';
import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/features/practice/services/practice_service.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-019: PracticeService Implementation & Idempotency (TDD)', () {
    late FakeCourseRepository courseRepo;
    late FakeQuestionRepository questionRepo;
    late FakeQuestionOptionRepository optionRepo;
    late FakeAcceptedAnswerRepository acceptedAnswerRepo;
    late FakeAttemptRepository attemptRepo;
    late FakeReviewStateRepository reviewStateRepo;
    late FakeClock clock;
    late PracticeService service;

    late Question sampleQuestion;
    late List<QuestionOption> sampleOptions;

    setUp(() async {
      courseRepo = FakeCourseRepository();
      questionRepo = FakeQuestionRepository();
      optionRepo = FakeQuestionOptionRepository();
      acceptedAnswerRepo = FakeAcceptedAnswerRepository();
      attemptRepo = FakeAttemptRepository();
      reviewStateRepo = FakeReviewStateRepository();
      clock = FakeClock(DateTime.utc(2026, 10, 10, 10, 0, 0));

      service = PracticeService(
        questionRepo: questionRepo,
        optionRepo: optionRepo,
        acceptedAnswerRepo: acceptedAnswerRepo,
        attemptRepo: attemptRepo,
        reviewStateRepo: reviewStateRepo,
        clock: clock,
      );

      await courseRepo.save(Course(id: 1, title: 'Flutter Basics', subject: 'Computer Science'));

      sampleQuestion = await questionRepo.save(Question(
        id: 1,
        courseId: 1,
        position: 1,
        prompt: 'What widget is used for immutable layout?',
        topic: 'Flutter Widgets',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 15,
        topicNote: 'StatelessWidget does not store mutable state across frames.',
        helpHint: 'Think about state immutability.',
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));

      sampleOptions = [
        QuestionOption(id: 101, questionId: 1, position: 1, text: 'StatelessWidget', isCorrect: true, explanation: 'Correct! Immutable widget.'),
        QuestionOption(id: 102, questionId: 1, position: 2, text: 'StatefulWidget', isCorrect: false, explanation: 'Incorrect. StatefulWidget is mutable.'),
        QuestionOption(id: 103, questionId: 1, position: 3, text: 'InheritedWidget', isCorrect: false, explanation: 'Incorrect. Used for ambient data propagation.'),
      ];
      await optionRepo.saveAll(sampleOptions);
    });

    test('serveNextCard stamps lastServedAt and resets helpUsed to false', () async {
      final item = await service.serveNextCard(profileId: 42, courseId: 1);
      expect(item, isNotNull);
      expect(item!.question.id, equals(1));
      expect(item.question.prompt, equals(sampleQuestion.prompt));
      expect(item.question.options?.length, equals(3));
      expect(item.question.topic, equals('Flutter Widgets'));
      expect(item.question.hasHelpHint, isTrue);

      final reviewState = await reviewStateRepo.get(42, 1);
      expect(reviewState, isNotNull);
      expect(reviewState!.lastServedAt, equals(clock.now()));
      expect(reviewState.helpUsed, isFalse);
    });

    test('requestHelp throws NoActiveCardException if no card currently served', () async {
      expect(
        () => service.requestHelp(profileId: 42, questionId: 1),
        throwsA(isA<NoActiveCardException>()),
      );
    });

    test('requestHelp flags card as helpUsed and returns hint', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);

      final help = await service.requestHelp(profileId: 42, questionId: 1);
      expect(help.helpHint, equals('Think about state immutability.'));

      final reviewState = await reviewStateRepo.get(42, 1);
      expect(reviewState!.helpUsed, isTrue);
    });

    test('submitAnswer throws CardAlreadyAnsweredException if card was already submitted (idempotency)', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);

      // Submit once
      await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);

      // Second submit must fail idempotency check
      expect(
        () => service.submitAnswer(profileId: 42, questionId: 1, optionId: 101),
        throwsA(isA<CardAlreadyAnsweredException>()),
      );
    });

    test('submitAnswer calculates latency from lastServedAt to now', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);
      clock.advance(const Duration(seconds: 4));

      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(result.responseMs, equals(4000));
    });

    test('submitAnswer persists Attempt, updates ReviewState, updates Question counters, and clears lastServedAt', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);
      clock.advance(const Duration(seconds: 5));

      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(result.verdict, equals(AttemptStatus.valid));
      expect(result.reflexTier, equals(ReflexTier.greenMastered));
      expect(result.reason, equals(ResultReason.correctClean));

      // Idempotency: lastServedAt is cleared
      final state = await reviewStateRepo.get(42, 1);
      expect(state!.lastServedAt, isNull);
      expect(state.intervalDays, equals(30)); // Clean solve schedules 30 days out

      // Attempt logged
      final attempts = await attemptRepo.listAttemptsByProfile(42);
      expect(attempts.length, equals(1));
      expect(attempts.first.isClean, isTrue);
      expect(attempts.first.underExpectedTime, isTrue);

      // Question counters updated
      final updatedQ = await questionRepo.findById(1);
      expect(updatedQ!.attemptCount, equals(1));
      expect(updatedQ.solvedStudentCount, equals(1));
      expect(updatedQ.cleanSolveCount, equals(1));
      expect(updatedQ.firstTrySolveCount, equals(1));
      expect(updatedQ.underTimeSolveCount, equals(1));
    });

    test('submitAnswer returns SubmitResult containing topicNote, explanations, and reason', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);

      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(result.topicNote, equals('StatelessWidget does not store mutable state across frames.'));
      expect(result.optionExplanations?.length, equals(3));
      expect(result.optionExplanations?.first.isCorrect, isTrue);
      expect(result.optionExplanations?.first.explanation, contains('Immutable widget'));
    });

    test('submitAnswer returns ReflexTier.redNeedsWork on incorrect answer', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);

      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 102);
      expect(result.verdict, equals(AttemptStatus.wrong));
      expect(result.reflexTier, equals(ReflexTier.redNeedsWork));
      expect(result.reason, equals(ResultReason.wrong));

      final state = await reviewStateRepo.get(42, 1);
      expect(state!.intervalDays, equals(1));
      expect(state.lapses, equals(1));
    });

    test('submitAnswer returns ReflexTier.yellowDeveloping on slow or helped answer', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);
      // Take longer than expected 15s
      clock.advance(const Duration(seconds: 20));

      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(result.verdict, equals(AttemptStatus.valid));
      expect(result.reflexTier, equals(ReflexTier.yellowDeveloping));
      expect(result.reason, equals(ResultReason.correctSlow));

      final state = await reviewStateRepo.get(42, 1);
      expect(state!.intervalDays, equals(2));
    });

    test('submitAnswer awards 0 points on wrong answer and does not increment totalScore', () async {
      await service.serveNextCard(profileId: 42, courseId: 1);
      final result = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 102);

      expect(result.verdict, equals(AttemptStatus.wrong));
      expect(result.points, equals(0));
      expect(result.totalScore, equals(0));
    });

    test('submitAnswer awards points on 2nd attempt when right after wrong first attempt, but only once', () async {
      // 1st attempt: wrong -> 0 points
      await service.serveNextCard(profileId: 42, courseId: 1);
      final wrongRes = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 102);
      expect(wrongRes.points, equals(0));
      expect(wrongRes.totalScore, equals(0));

      // 2nd attempt: right -> awards 10 points
      clock.advance(const Duration(days: 1));
      await service.serveNextCard(profileId: 42, courseId: 1);
      final rightRes = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(rightRes.points, equals(10));
      expect(rightRes.totalScore, equals(10));

      // 3rd attempt: right again -> 0 points, totalScore still 10
      clock.advance(const Duration(days: 30));
      await service.serveNextCard(profileId: 42, courseId: 1);
      final rightAgainRes = await service.submitAnswer(profileId: 42, questionId: 1, optionId: 101);
      expect(rightAgainRes.points, equals(0));
      expect(rightAgainRes.totalScore, equals(10));
    });
  });
}

