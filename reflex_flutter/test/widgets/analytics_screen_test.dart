import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/analytics_repository.dart';
import 'package:reflex_flutter/presentation/features/analytics/analytics_screen.dart';
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

  group('AnalyticsScreen widget tests', () {
    testWidgets('loads cohort summary and renders mastery and question insights',
        (tester) async {
      final sampleSummary = CohortSummary(
        mastery: [
          TopicMastery(topic: 'Physics', masteryRate: 0.85),
          TopicMastery(topic: 'Chemistry', masteryRate: 0.45),
        ],
        questions: [
          QuestionInsight(
            questionId: 1,
            prompt: 'What is Newton second law?',
            topic: 'Physics',
            questionType: QuestionType.multipleChoice,
            attemptCount: 15,
            solvedStudentCount: 5,
            firstTrySolveCount: 4,
            underTimeSolveCount: 3,
            cleanSolveCount: 3,
            firstTryRate: 0.80,
            cleanRate: 0.60,
            avgResponseMs: 1200.0,
          ),
        ],
        students: [
          StudentProgress(
            profileId: 1,
            displayName: 'Tariq',
            solvedCount: 10,
            cleanFirstTryCount: 8,
            avgResponseMs: 1500.0,
          ),
        ],
      );

      when(() => mockRepo.listCourses()).thenAnswer(
        (_) async => Result.success([
          Course(id: 1, title: 'Physics 101', subject: 'Physics', isPublic: true),
        ]),
      );
      when(() => mockRepo.getCohortSummary(any()))
          .thenAnswer((_) async => Result.success(sampleSummary));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: AnalyticsScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tab 1: Topic Mastery (embedded Question Insights inside topics!)
      expect(find.text('Physics'), findsWidgets);
      expect(find.text('Chemistry'), findsOneWidget);
      expect(find.byIcon(Icons.people_alt_rounded), findsWidgets);
      expect(find.text('1 Students'), findsWidgets);

      // Verify question insights are embedded directly inside the Topic Mastery tab!
      expect(find.text('What is Newton second law?'), findsOneWidget);

      // Switch to Tab 2: Question Insights table
      await tester.tap(find.text('Question Insights (Atomic Counters)'));
      await tester.pumpAndSettle();

      expect(find.text('What is Newton second law?'), findsOneWidget);
      expect(find.text('15'), findsOneWidget); // attemptCount
      expect(find.text('80%'), findsOneWidget); // firstTryRate
    });
  });
}
