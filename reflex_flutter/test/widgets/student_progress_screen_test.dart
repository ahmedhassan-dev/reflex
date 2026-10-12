import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/analytics_repository.dart';
import 'package:reflex_flutter/presentation/features/profile/student_progress_screen.dart';
import '../test_helpers.dart';

class MockAnalyticsRepository extends Mock implements IAnalyticsRepository {}

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  late MockAnalyticsRepository mockRepo;

  setUp(() {
    mockRepo = MockAnalyticsRepository();
  });

  group('StudentProgressScreen widget tests', () {
    testWidgets('renders student metrics and dynamic study streak correctly',
        (tester) async {
      final sampleProgress = StudentProgress(
        learnerId: 101,
        displayName: 'Amira Tariq',
        solvedCount: 18,
        cleanFirstTryCount: 14,
        avgResponseMs: 1420.0,
        studyStreakDays: 5,
      );

      final sampleCourses = [
        Course(id: 1, title: 'STEM Math', subject: 'Math', isPublic: true),
        Course(id: 2, title: 'Physics', subject: 'Science', isPublic: false),
      ];

      when(() => mockRepo.listCourses())
          .thenAnswer((_) async => Result.success(sampleCourses));
      when(() => mockRepo.getMyProgress(any()))
          .thenAnswer((_) async => Result.success(sampleProgress));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: StudentProgressScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify student name
      expect(find.text('Amira Tariq'), findsOneWidget);

      // Verify Clean 1st Try count
      expect(find.text('14'), findsOneWidget);

      // Verify Solved count
      expect(find.text('18'), findsOneWidget);

      // Verify Latency
      expect(find.text('1.4s'), findsOneWidget);

      // Verify dynamic study streak
      expect(find.text('5 days'), findsOneWidget);

      // Verify course selector is visible
      expect(find.byKey(const Key('student_progress_course_selector')),
          findsOneWidget);
    });

    testWidgets('switching course loads progress for newly selected course',
        (tester) async {
      final course1 =
          Course(id: 1, title: 'Course 1', subject: 'Math', isPublic: true);
      final course2 =
          Course(id: 2, title: 'Course 2', subject: 'Physics', isPublic: true);

      final progress1 = StudentProgress(
        learnerId: 1,
        displayName: 'Student',
        solvedCount: 5,
        cleanFirstTryCount: 3,
        avgResponseMs: 2000.0,
        studyStreakDays: 2,
      );
      final progress2 = StudentProgress(
        learnerId: 1,
        displayName: 'Student',
        solvedCount: 10,
        cleanFirstTryCount: 8,
        avgResponseMs: 1500.0,
        studyStreakDays: 4,
      );

      when(() => mockRepo.listCourses())
          .thenAnswer((_) async => Result.success([course1, course2]));
      when(() => mockRepo.getMyProgress(1))
          .thenAnswer((_) async => Result.success(progress1));
      when(() => mockRepo.getMyProgress(2))
          .thenAnswer((_) async => Result.success(progress2));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: StudentProgressScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('5'), findsOneWidget);

      // Tap dropdown to select course 2
      await tester.tap(find.byKey(const Key('student_progress_course_selector')));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Course 2 (Physics)').last);
      await tester.pumpAndSettle();

      verify(() => mockRepo.getMyProgress(2)).called(1);
      expect(find.text('10'), findsOneWidget);
    });
  });
}
