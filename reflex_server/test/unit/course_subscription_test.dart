import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/features/practice/services/practice_service.dart';
import 'package:reflex_server/src/features/questions/services/question_admin_service.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-026: Course Teacher Association, Visibility, and Subscriptions', () {
    late FakeCourseRepository courseRepo;
    late FakeCourseSubscriptionRepository subscriptionRepo;
    late FakeQuestionRepository questionRepo;
    late FakeQuestionOptionRepository optionRepo;
    late FakeAcceptedAnswerRepository acceptedAnswerRepo;
    late FakeAttemptRepository attemptRepo;
    late FakeReviewStateRepository reviewStateRepo;
    late FakeLearnerRepository learnerRepo;
    late PracticeService practiceService;
    late QuestionAdminService adminService;
    final fixedTime = DateTime.utc(2026, 10, 11, 10, 0, 0);

    setUp(() async {
      courseRepo = FakeCourseRepository();
      subscriptionRepo = FakeCourseSubscriptionRepository();
      questionRepo = FakeQuestionRepository();
      optionRepo = FakeQuestionOptionRepository();
      acceptedAnswerRepo = FakeAcceptedAnswerRepository();
      attemptRepo = FakeAttemptRepository();
      reviewStateRepo = FakeReviewStateRepository();
      learnerRepo = FakeLearnerRepository();

      practiceService = PracticeService(
        questionRepo: questionRepo,
        optionRepo: optionRepo,
        acceptedAnswerRepo: acceptedAnswerRepo,
        attemptRepo: attemptRepo,
        reviewStateRepo: reviewStateRepo,
        courseRepo: courseRepo,
        subscriptionRepo: subscriptionRepo,
        clock: FakeClock(fixedTime),
      );

      adminService = QuestionAdminService(
        questionRepo: questionRepo,
        courseRepo: courseRepo,
        optionRepo: optionRepo,
        acceptedAnswerRepo: acceptedAnswerRepo,
        subscriptionRepo: subscriptionRepo,
        learnerRepo: learnerRepo,
      );
    });

    test('Teacher can create course with teacherId, teacherName, and choose visibility', () async {
      final course = await adminService.createCourse(
        title: 'Advanced Flutter Architecture',
        subject: 'Mobile Engineering',
        topics: ['State Management', 'Clean Architecture'],
        teacherId: 1,
        teacherName: 'Mr. Hassan',
        isPublic: false,
      );

      expect(course.id, isNotNull);
      expect(course.teacherId, equals(1));
      expect(course.teacherName, equals('Mr. Hassan'));
      expect(course.isPublic, isFalse);
    });

    test('Teacher can toggle course visibility between public and private', () async {
      final course = await adminService.createCourse(
        title: 'Dart 101',
        subject: 'Programming',
        isPublic: true,
      );

      expect(course.isPublic, isTrue);

      final updated = await adminService.updateCourseVisibility(
        courseId: course.id!,
        isPublic: false,
      );
      expect(updated.isPublic, isFalse);
    });

    test('Student can request subscription for private course and teacher can accept it', () async {
      // 1. Create a private course
      final course = await adminService.createCourse(
        title: 'Private AI Masterclass',
        subject: 'AI',
        isPublic: false,
      );

      // 2. Student (learnerId = 10) requests subscription
      final sub = await practiceService.requestSubscription(
        learnerId: 10,
        courseId: course.id!,
      );
      expect(sub.status, equals(SubscriptionStatus.pending));

      // 3. Teacher lists subscriptions for course
      final teacherView = await adminService.listSubscriptions(course.id!);
      expect(teacherView.length, equals(1));
      expect(teacherView.first.studentId, equals(10));
      expect(teacherView.first.status, equals(SubscriptionStatus.pending));

      // 4. Teacher accepts student
      final accepted = await adminService.respondToSubscription(
        subscriptionId: sub.id!,
        status: SubscriptionStatus.accepted,
      );
      expect(accepted.status, equals(SubscriptionStatus.accepted));
      expect(accepted.decidedAt, isNotNull);

      // 5. Student status is now accepted
      final status = await practiceService.getSubscriptionStatus(
        learnerId: 10,
        courseId: course.id!,
      );
      expect(status, equals(SubscriptionStatus.accepted));
    });

    test('Private course blocks practice if student is not accepted', () async {
      final course = await adminService.createCourse(
        title: 'Private Physics Deck',
        subject: 'Science',
        isPublic: false,
      );

      await questionRepo.save(Question(
        courseId: course.id!,
        position: 1,
        prompt: 'What is force?',
        topic: 'Mechanics',
        questionType: QuestionType.textInput,
        points: 10,
        expectedSeconds: 15,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));

      // Student has not subscribed
      expect(
        () => practiceService.serveNextCard(learnerId: 10, courseId: course.id!),
        throwsA(isA<CourseAccessDeniedException>()),
      );

      // Student subscribes (status = pending)
      await practiceService.requestSubscription(
        learnerId: 10,
        courseId: course.id!,
      );

      // Still blocked while pending
      expect(
        () => practiceService.serveNextCard(learnerId: 10, courseId: course.id!),
        throwsA(isA<CourseAccessDeniedException>()),
      );

      // Teacher accepts student
      final sub = await subscriptionRepo.findByCourseAndStudent(course.id!, 10);
      await adminService.respondToSubscription(
        subscriptionId: sub!.id!,
        status: SubscriptionStatus.accepted,
      );

      // Now student can practice!
      final card = await practiceService.serveNextCard(learnerId: 10, courseId: course.id!);
      expect(card, isNotNull);
      expect(card!.question.prompt, equals('What is force?'));
    });
  });
}
