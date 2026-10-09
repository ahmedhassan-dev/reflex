import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/features/analytics/services/cohort_stats_service.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-020: CohortStatsService & Insights Aggregator (TDD)', () {
    late FakeLearnerRepository learnerRepo;
    late FakeQuestionRepository questionRepo;
    late FakeAttemptRepository attemptRepo;
    late FakeReviewStateRepository reviewStateRepo;
    late CohortStatsService service;

    setUp(() async {
      learnerRepo = FakeLearnerRepository();
      questionRepo = FakeQuestionRepository();
      attemptRepo = FakeAttemptRepository();
      reviewStateRepo = FakeReviewStateRepository();

      service = CohortStatsService(
        learnerRepo: learnerRepo,
        questionRepo: questionRepo,
        attemptRepo: attemptRepo,
        reviewStateRepo: reviewStateRepo,
      );

      // Learners
      await learnerRepo.save(Learner(
        id: 1,
        authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000001'),
        displayName: 'Alice Student',
        role: Role.student,
      ));
      await learnerRepo.save(Learner(
        id: 2,
        authUserId: UuidValue.fromString('00000000-0000-0000-0000-000000000002'),
        displayName: 'Bob Student',
        role: Role.student,
      ));

      // Questions for Course 1
      await questionRepo.save(Question(
        id: 1,
        courseId: 1,
        position: 1,
        prompt: 'Widget immutability in Flutter',
        topic: 'Widgets',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 15,
        attemptCount: 4,
        attemptedStudentCount: 2,
        solvedStudentCount: 2,
        firstTrySolveCount: 2,
        underTimeSolveCount: 2,
        cleanSolveCount: 2,
      ));

      await questionRepo.save(Question(
        id: 2,
        courseId: 1,
        position: 2,
        prompt: 'Async Streams in Dart',
        topic: 'Dart',
        questionType: QuestionType.textInput,
        points: 10,
        expectedSeconds: 20,
        attemptCount: 2,
        attemptedStudentCount: 2,
        solvedStudentCount: 1,
        firstTrySolveCount: 0,
        underTimeSolveCount: 1,
        cleanSolveCount: 0,
      ));

      // Attempts for Course 1
      final now = DateTime.utc(2026, 10, 10);
      await attemptRepo.insert(Attempt(
        learnerId: 1,
        questionId: 1,
        status: AttemptStatus.valid,
        responseMs: 5000,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: true,
        reflexTier: ReflexTier.greenMastered,
        createdAt: now,
      ));
      await attemptRepo.insert(Attempt(
        learnerId: 1,
        questionId: 2,
        status: AttemptStatus.valid,
        responseMs: 15000,
        usedHelp: false,
        isFirstAttempt: false,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.yellowDeveloping,
        createdAt: now,
      ));

      await attemptRepo.insert(Attempt(
        learnerId: 2,
        questionId: 1,
        status: AttemptStatus.valid,
        responseMs: 7000,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: true,
        reflexTier: ReflexTier.greenMastered,
        createdAt: now,
      ));
      await attemptRepo.insert(Attempt(
        learnerId: 2,
        questionId: 2,
        status: AttemptStatus.wrong,
        responseMs: 25000,
        usedHelp: true,
        isFirstAttempt: true,
        underExpectedTime: false,
        isClean: false,
        reflexTier: ReflexTier.redNeedsWork,
        createdAt: now,
      ));
    });

    test('calculates question insights correctly from Question entity counters and attempts', () async {
      final summary = await service.getCohortSummary(courseId: 1);

      expect(summary.questions.length, equals(2));
      final q1 = summary.questions.firstWhere((q) => q.questionId == 1);
      expect(q1.prompt, equals('Widget immutability in Flutter'));
      expect(q1.attemptCount, equals(4));
      expect(q1.solvedStudentCount, equals(2));
      expect(q1.cleanSolveCount, equals(2));
      expect(q1.firstTryRate, equals(50.0)); // 2/4 = 50%
      expect(q1.cleanRate, equals(50.0)); // 2/4 = 50%
      expect(q1.avgResponseMs, equals(6000.0)); // (5000 + 7000) / 2 = 6000
    });

    test('calculates studentProgress including solvedCount, cleanFirstTryCount, and avgResponseMs', () async {
      final summary = await service.getCohortSummary(courseId: 1);

      expect(summary.students.length, equals(2));
      final alice = summary.students.firstWhere((s) => s.learnerId == 1);
      expect(alice.displayName, equals('Alice Student'));
      expect(alice.solvedCount, equals(2));
      expect(alice.cleanFirstTryCount, equals(1));
      expect(alice.avgResponseMs, equals(10000.0)); // (5000 + 15000) / 2 = 10000

      final bob = summary.students.firstWhere((s) => s.learnerId == 2);
      expect(bob.displayName, equals('Bob Student'));
      expect(bob.solvedCount, equals(1));
      expect(bob.cleanFirstTryCount, equals(1));
      expect(bob.avgResponseMs, equals(16000.0)); // (7000 + 25000) / 2 = 16000
    });

    test('calculates topicMastery rate per topic across the cohort', () async {
      final summary = await service.getCohortSummary(courseId: 1);

      expect(summary.mastery.length, equals(2));
      final widgetsTopic = summary.mastery.firstWhere((t) => t.topic == 'Widgets');
      // 2 students solved out of 2 students enrolled = 100%
      expect(widgetsTopic.masteryRate, equals(100.0));

      final dartTopic = summary.mastery.firstWhere((t) => t.topic == 'Dart');
      // 1 student solved out of 2 students enrolled = 50%
      expect(dartTopic.masteryRate, equals(50.0));
    });

    test('returns empty summary gracefully when course has no questions', () async {
      final summary = await service.getCohortSummary(courseId: 99);
      expect(summary.questions, isEmpty);
      expect(summary.students, isEmpty);
      expect(summary.mastery, isEmpty);
    });
  });
}
