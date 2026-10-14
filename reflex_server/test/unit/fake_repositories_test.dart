import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-016: Fake Repositories Verification', () {
    test('FakeLearnerRepository supports CRUD and lookup by authUserId', () async {
      final repo = FakeLearnerRepository();
      final authId = UuidValue.fromString('00000000-0000-4000-8000-000000000001');

      final learner = Learner(
        authUserId: authId,
        displayName: 'Amina',
        role: Role.student,
      );

      final saved = await repo.save(learner);
      expect(saved.id, equals(1));
      expect(saved.displayName, equals('Amina'));

      final byId = await repo.findById(1);
      expect(byId?.displayName, equals('Amina'));

      final byAuth = await repo.findByAuthUserId(authId);
      expect(byAuth?.id, equals(1));

      final all = await repo.listAll();
      expect(all.length, equals(1));
    });

    test('FakeQuestionRepository supports course lookup and atomic counter deltas', () async {
      final repo = FakeQuestionRepository();

      final question = Question(
        courseId: 10,
        position: 1,
        prompt: 'What is 1 + 1?',
        topic: 'Math',
        questionType: QuestionType.multipleChoice,
        points: 5,
        expectedSeconds: 10,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      );

      final saved = await repo.save(question);
      expect(saved.id, equals(1));

      await repo.applyCounterDeltas(
        1,
        const QuestionCounterDeltas(
          attemptCountDelta: 1,
          attemptedStudentCountDelta: 1,
          solvedStudentCountDelta: 1,
          firstTrySolveCountDelta: 1,
          underTimeSolveCountDelta: 1,
          cleanSolveCountDelta: 1,
        ),
      );

      final updated = await repo.findById(1);
      expect(updated?.attemptCount, equals(1));
      expect(updated?.attemptedStudentCount, equals(1));
      expect(updated?.cleanSolveCount, equals(1));
    });

    test('FakeAttemptRepository tracks prior attempts and prior solves', () async {
      final repo = FakeAttemptRepository();
      final now = DateTime.now();

      expect(await repo.hasPriorAttempt(1, 100), isFalse);
      expect(await repo.hasLearnerSolvedQuestion(1, 100), isFalse);

      await repo.insert(Attempt(
        learnerId: 1,
        questionId: 100,
        status: AttemptStatus.wrong,
        responseMs: 5000,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.redNeedsWork,
        createdAt: now,
      ));

      expect(await repo.hasPriorAttempt(1, 100), isTrue);
      expect(await repo.hasLearnerSolvedQuestion(1, 100), isFalse);

      await repo.insert(Attempt(
        learnerId: 1,
        questionId: 100,
        status: AttemptStatus.valid,
        responseMs: 4000,
        usedHelp: false,
        isFirstAttempt: false,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.greenMastered,
        createdAt: now,
      ));

      expect(await repo.hasLearnerSolvedQuestion(1, 100), isTrue);
    });

    test('FakeReviewStateRepository supports upsert, due query, and markServed', () async {
      final repo = FakeReviewStateRepository();
      final now = DateTime.utc(2026, 10, 9, 12, 0, 0);

      final state = ReviewState(
        learnerId: 1,
        questionId: 5,
        dueAt: now.subtract(const Duration(hours: 1)),
        intervalDays: 1,
        lapses: 0,
        helpUsed: false,
      );

      await repo.upsert(state);

      final due = await repo.findDueReviews(learnerId: 1, courseId: 1, now: now);
      expect(due.length, equals(1));
      expect(due.first.questionId, equals(5));

      await repo.markServed(1, 5, now);
      final fetched = await repo.get(1, 5);
      expect(fetched?.lastServedAt, equals(now));
    });

    test('Fake repositories support deletion and unassignment for account removal', () async {
      final learnerRepo = FakeLearnerRepository();
      final courseRepo = FakeCourseRepository();
      final subRepo = FakeCourseSubscriptionRepository();
      final attemptRepo = FakeAttemptRepository();
      final reviewRepo = FakeReviewStateRepository();

      final learner = await learnerRepo.save(Learner(
        authUserId: UuidValue.fromString('00000000-0000-4000-8000-000000000099'),
        displayName: 'DeleteMe',
        role: Role.student,
      ));
      final learnerId = learner.id!;

      final course = await courseRepo.save(Course(
        title: 'Owned Course',
        subject: 'Math',
        teacherId: learnerId,
      ));
      await subRepo.save(CourseSubscription(
        courseId: course.id!,
        studentId: learnerId,
        status: SubscriptionStatus.accepted,
        requestedAt: DateTime.utc(2026, 10, 10),
      ));
      await attemptRepo.insert(Attempt(
        learnerId: learnerId,
        questionId: 1,
        status: AttemptStatus.valid,
        responseMs: 1000,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: true,
        reflexTier: ReflexTier.greenMastered,
        createdAt: DateTime.utc(2026, 10, 10),
      ));
      await reviewRepo.upsert(ReviewState(
        learnerId: learnerId,
        questionId: 1,
        dueAt: DateTime.utc(2026, 10, 10),
        intervalDays: 1,
        lapses: 0,
        helpUsed: false,
      ));

      // Execute cleanups
      await attemptRepo.deleteByLearnerId(learnerId);
      await reviewRepo.deleteByLearnerId(learnerId);
      await subRepo.deleteByStudentId(learnerId);
      await courseRepo.unassignTeacher(learnerId);
      await learnerRepo.delete(learner);

      expect(await attemptRepo.listAttemptsByLearner(learnerId), isEmpty);
      expect(await reviewRepo.listByLearner(learnerId), isEmpty);
      expect(await subRepo.listByStudent(learnerId), isEmpty);
      final updatedCourse = await courseRepo.findById(course.id!);
      expect(updatedCourse?.teacherId, isNull);
      expect(await learnerRepo.findById(learnerId), isNull);
    });

    test('FakeDemoClockRepository sets and retrieves offsetDays', () async {
      final repo = FakeDemoClockRepository();
      expect(await repo.getOffsetDays(), equals(0));

      await repo.setOffsetDays(14);
      expect(await repo.getOffsetDays(), equals(14));
    });
  });
}
