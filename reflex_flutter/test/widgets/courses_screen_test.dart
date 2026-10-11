import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/practice_repository.dart';
import 'package:reflex_flutter/presentation/features/courses/courses_screen.dart';
import '../test_helpers.dart';

class MockPracticeRepository extends Mock implements IPracticeRepository {}

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  late MockPracticeRepository mockRepo;

  setUp(() {
    mockRepo = MockPracticeRepository();
  });

  group('CoursesScreen widget tests', () {
    testWidgets('renders public and private courses with distinct actions',
        (tester) async {
      final sampleCourses = [
        Course(
          id: 1,
          title: 'Calculus I',
          subject: 'Mathematics',
          teacherName: 'Dr. Euler',
          isPublic: true,
          topics: ['Derivatives', 'Limits'],
        ),
        Course(
          id: 2,
          title: 'Advanced Mechanics',
          subject: 'Physics',
          teacherName: 'Prof. Newton',
          isPublic: false,
          topics: ['Kinematics', 'Dynamics'],
        ),
      ];

      when(() => mockRepo.listCourses())
          .thenAnswer((_) async => Result.success(sampleCourses));
      when(() => mockRepo.getCourseSubscriptionStatus(2))
          .thenAnswer((_) async => Result.success(null));

      int? startedCourseId;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: CoursesScreen(
            repositoryOverride: mockRepo,
            onStartPractice: (id) => startedCourseId = id,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify titles rendered
      expect(find.text('Calculus I'), findsOneWidget);
      expect(find.text('Advanced Mechanics'), findsOneWidget);

      // Verify Public course has start practice button
      expect(find.byKey(const Key('btn_start_practice_1')), findsOneWidget);

      // Verify Private course has request access button
      expect(find.byKey(const Key('btn_subscribe_2')), findsOneWidget);

      // Tap start practice
      await tester.tap(find.byKey(const Key('btn_start_practice_1')));
      expect(startedCourseId, equals(1));
    });

    testWidgets('requesting access to private course triggers subscription request',
        (tester) async {
      final sampleCourses = [
        Course(
          id: 10,
          title: 'Quantum Physics',
          subject: 'Physics',
          teacherName: 'Prof. Planck',
          isPublic: false,
        ),
      ];

      final sampleSub = CourseSubscription(
        id: 101,
        courseId: 10,
        studentId: 5,
        status: SubscriptionStatus.pending,
        requestedAt: DateTime.now(),
      );

      when(() => mockRepo.listCourses())
          .thenAnswer((_) async => Result.success(sampleCourses));
      when(() => mockRepo.getCourseSubscriptionStatus(10))
          .thenAnswer((_) async => Result.success(null));
      when(() => mockRepo.requestCourseSubscription(10))
          .thenAnswer((_) async => Result.success(sampleSub));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: CoursesScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap request subscription
      final subBtn = find.byKey(const Key('btn_subscribe_10'));
      expect(subBtn, findsOneWidget);
      await tester.tap(subBtn);
      await tester.pumpAndSettle();

      // Verify repo was called
      verify(() => mockRepo.requestCourseSubscription(10)).called(1);

      // Verify UI changes to pending indicator
      expect(find.byIcon(Icons.hourglass_top_rounded), findsWidgets);
    });
  });
}
