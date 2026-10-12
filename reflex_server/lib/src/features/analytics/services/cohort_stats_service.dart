import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Aggregates learning performance, topic mastery, and question difficulty insights.
class CohortStatsService {
  final ILearnerRepository learnerRepo;
  final IQuestionRepository questionRepo;
  final IAttemptRepository attemptRepo;
  final IReviewStateRepository reviewStateRepo;
  final Clock clock;

  CohortStatsService({
    required this.learnerRepo,
    required this.questionRepo,
    required this.attemptRepo,
    required this.reviewStateRepo,
    this.clock = const SystemClock(),
  });

  /// Computes full cohort analytics for a teacher dashboard.
  Future<CohortSummary> getCohortSummary({required int courseId}) async {
    final questions = await questionRepo.findByCourseId(courseId);
    if (questions.isEmpty) {
      return CohortSummary(
        mastery: [],
        questions: [],
        students: [],
      );
    }

    final attempts = await attemptRepo.listAttemptsForCourse(courseId);
    final allLearners = await learnerRepo.listAll();
    final students = allLearners.where((l) => l.role == Role.student).toList();

    // 1. Question Insights
    final questionInsights = <QuestionInsight>[];
    for (final q in questions) {
      final qAttempts = attempts.where((a) => a.questionId == q.id).toList();
      final avgLatency = qAttempts.isEmpty
          ? 0.0
          : qAttempts.map((a) => a.responseMs).reduce((a, b) => a + b) / qAttempts.length;

      final firstTryRate = q.attemptCount > 0
          ? (q.firstTrySolveCount / q.attemptCount) * 100.0
          : 0.0;
      final cleanRate = q.attemptCount > 0
          ? (q.cleanSolveCount / q.attemptCount) * 100.0
          : 0.0;

      questionInsights.add(QuestionInsight(
        questionId: q.id!,
        prompt: q.prompt,
        topic: q.topic,
        questionType: q.questionType,
        attemptCount: q.attemptCount,
        solvedStudentCount: q.solvedStudentCount,
        firstTrySolveCount: q.firstTrySolveCount,
        underTimeSolveCount: q.underTimeSolveCount,
        cleanSolveCount: q.cleanSolveCount,
        firstTryRate: double.parse(firstTryRate.toStringAsFixed(1)),
        cleanRate: double.parse(cleanRate.toStringAsFixed(1)),
        avgResponseMs: double.parse(avgLatency.toStringAsFixed(1)),
      ));
    }

    // 2. Student Progress
    final studentProgressList = <StudentProgress>[];
    for (final student in students) {
      final sAttempts = attempts.where((a) => a.learnerId == student.id).toList();
      if (sAttempts.isEmpty) continue;

      final solvedQuestionIds = sAttempts
          .where((a) => a.status == AttemptStatus.valid)
          .map((a) => a.questionId)
          .toSet();

      final cleanFirstTryCount = sAttempts
          .where((a) => a.isClean && a.isFirstAttempt)
          .map((a) => a.questionId)
          .toSet()
          .length;

      final avgLatency = sAttempts.isEmpty
          ? 0.0
          : sAttempts.map((a) => a.responseMs).reduce((a, b) => a + b) / sAttempts.length;

      final streak = _calculateStreakDays(sAttempts, clock.now());

      studentProgressList.add(StudentProgress(
        learnerId: student.id!,
        displayName: student.displayName,
        solvedCount: solvedQuestionIds.length,
        cleanFirstTryCount: cleanFirstTryCount,
        avgResponseMs: double.parse(avgLatency.toStringAsFixed(1)),
        studyStreakDays: streak,
      ));
    }

    // 3. Topic Mastery
    final topics = questions.map((q) => q.topic).toSet();
    final topicMasteryList = <TopicMastery>[];
    final totalStudentsCount = students.isEmpty ? 1 : students.length;

    for (final topic in topics) {
      final topicQuestions = questions.where((q) => q.topic == topic).toList();
      final totalSolvedStudentsInTopic = topicQuestions
          .map((q) => q.solvedStudentCount)
          .fold<int>(0, (prev, count) => prev + count);

      final totalPossibleSolves = topicQuestions.length * totalStudentsCount;
      final masteryRate = totalPossibleSolves > 0
          ? (totalSolvedStudentsInTopic / totalPossibleSolves) * 100.0
          : 0.0;

      topicMasteryList.add(TopicMastery(
        topic: topic,
        masteryRate: double.parse(masteryRate.toStringAsFixed(1)),
      ));
    }

    return CohortSummary(
      mastery: topicMasteryList,
      questions: questionInsights,
      students: studentProgressList,
    );
  }

  /// Computes progress for an individual student in a course.
  Future<StudentProgress> getStudentProgress({
    required int learnerId,
    required int courseId,
  }) async {
    final learner = await learnerRepo.findById(learnerId);
    final attempts = await attemptRepo.listAttemptsByLearner(learnerId);
    final courseQuestions = await questionRepo.findByCourseId(courseId);
    final courseQIds = courseQuestions.map((q) => q.id!).toSet();

    final courseAttempts = attempts.where((a) => courseQIds.contains(a.questionId)).toList();

    final solvedQuestionIds = courseAttempts
        .where((a) => a.status == AttemptStatus.valid)
        .map((a) => a.questionId)
        .toSet();

    final cleanFirstTryCount = courseAttempts
        .where((a) => a.isClean && a.isFirstAttempt)
        .map((a) => a.questionId)
        .toSet()
        .length;

    final avgLatency = courseAttempts.isEmpty
        ? 0.0
        : courseAttempts.map((a) => a.responseMs).reduce((a, b) => a + b) / courseAttempts.length;

    final streak = _calculateStreakDays(attempts, clock.now());

    return StudentProgress(
      learnerId: learnerId,
      displayName: learner?.displayName ?? 'Student',
      solvedCount: solvedQuestionIds.length,
      cleanFirstTryCount: cleanFirstTryCount,
      avgResponseMs: double.parse(avgLatency.toStringAsFixed(1)),
      studyStreakDays: streak,
    );
  }

  /// Calculates consecutive calendar day study streak up to [referenceNow].
  int _calculateStreakDays(List<Attempt> attempts, DateTime referenceNow) {
    if (attempts.isEmpty) return 0;

    final dates = attempts
        .map((a) => DateTime.utc(a.createdAt.year, a.createdAt.month, a.createdAt.day))
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    final today = DateTime.utc(referenceNow.year, referenceNow.month, referenceNow.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final mostRecent = dates.first;
    if (mostRecent.isBefore(yesterday)) {
      return 0;
    }

    var streak = 0;
    var expectedDate = mostRecent;

    for (final date in dates) {
      if (date == expectedDate) {
        streak++;
        expectedDate = expectedDate.subtract(const Duration(days: 1));
      } else if (date.isBefore(expectedDate)) {
        break;
      }
    }

    return streak;
  }
}
