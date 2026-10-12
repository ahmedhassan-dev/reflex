import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/practice_repository.dart';
import 'package:reflex_flutter/presentation/features/practice/practice_screen.dart';
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

  group('Practice End-to-End Modifications Flow Tests', () {
    testWidgets('full E2E flow: wrong answer (0 pts), right answer (points added once), top toast, no checkbox', (tester) async {
      final sampleCourse = Course(
        id: 1,
        title: 'Flutter Widgets',
        subject: 'Mobile Dev',
        isPublic: true,
      );

      final questionView = QuestionView(
        id: 10,
        prompt: 'What makes StatelessWidget immutable?',
        topic: 'Flutter Basics',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 15,
        hasHelpHint: false,
        options: [
          QuestionOptionView(id: 101, text: 'Fields are marked final'),
          QuestionOptionView(id: 102, text: 'It can mutate its state internally'),
        ],
      );

      final initialCard = PracticeItem(
        kind: CardKind.newCard,
        question: questionView,
        totalScore: 0,
      );

      final wrongSubmitResult = SubmitResult(
        verdict: AttemptStatus.wrong,
        reason: ResultReason.wrong,
        reflexTier: ReflexTier.redNeedsWork,
        points: 0,
        totalScore: 0,
        responseMs: 1200,
        nextDueAt: DateTime.utc(2026, 10, 13),
        topicNote: 'StatelessWidget configuration is immutable.',
      );

      final secondAttemptCard = PracticeItem(
        kind: CardKind.review,
        question: questionView,
        totalScore: 0,
      );

      final correctSubmitResult = SubmitResult(
        verdict: AttemptStatus.valid,
        reason: ResultReason.correctClean,
        reflexTier: ReflexTier.greenMastered,
        points: 10,
        totalScore: 10,
        responseMs: 1100,
        nextDueAt: DateTime.utc(2026, 11, 10),
        topicNote: 'StatelessWidget configuration is immutable.',
      );

      final thirdAttemptCard = PracticeItem(
        kind: CardKind.review,
        question: questionView,
        totalScore: 10,
      );

      final repeatedCorrectResult = SubmitResult(
        verdict: AttemptStatus.valid,
        reason: ResultReason.correctClean,
        reflexTier: ReflexTier.greenMastered,
        points: 0,
        totalScore: 10,
        responseMs: 900,
        nextDueAt: DateTime.utc(2026, 12, 10),
        topicNote: 'StatelessWidget configuration is immutable.',
      );

      when(() => mockRepo.listCourses())
          .thenAnswer((_) async => Result.success([sampleCourse]));
      when(() => mockRepo.getCourseSubscriptionStatus(any()))
          .thenAnswer((_) async => Result.success(SubscriptionStatus.accepted));

      int serveCount = 0;
      when(() => mockRepo.serveNextCard(any())).thenAnswer((_) async {
        serveCount++;
        if (serveCount == 1) return Result.success(initialCard);
        if (serveCount == 2) return Result.success(secondAttemptCard);
        return Result.success(thirdAttemptCard);
      });

      when(() => mockRepo.submitAnswer(10, optionId: 102))
          .thenAnswer((_) async => Result.success(wrongSubmitResult));
      int correctSubmissions = 0;
      when(() => mockRepo.submitAnswer(10, optionId: 101)).thenAnswer((_) async {
        correctSubmissions++;
        if (correctSubmissions == 1) {
          return Result.success(correctSubmitResult);
        }
        return Result.success(repeatedCorrectResult);
      });

      // 1. Launch PracticeScreen
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: PracticeScreen(
            repositoryOverride: mockRepo,
            initialCourseId: 1,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Initial Header Badge displays Score: 0
      expect(find.byKey(const Key('practice_header_score_badge')), findsOneWidget);
      expect(find.text('Total Score: 0'), findsOneWidget);

      // 2. Select WRONG option (id 102) and Submit
      final wrongOptionFinder = find.text('It can mutate its state internally');
      expect(wrongOptionFinder, findsOneWidget);
      await tester.tap(wrongOptionFinder);
      await tester.pumpAndSettle();

      final submitBtnFinder = find.byKey(const Key('practice_submit_button'));
      expect(submitBtnFinder, findsOneWidget);
      await tester.tap(submitBtnFinder);
      await tester.pumpAndSettle();

      // Verify WRONG attempt outcome: +0 pts, Total Score: 0
      expect(find.text('+0 pts'), findsOneWidget);
      expect(find.byKey(const Key('result_total_score_badge')), findsOneWidget);
      expect(find.text('Total Score: 0'), findsWidgets);

      // Verify Top Explanation Toast appeared with teacher explanation
      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);
      expect(find.text('StatelessWidget configuration is immutable.'), findsOneWidget);

      // Verify Checkbox is REMOVED
      expect(find.byKey(const Key('note_gate_checkbox')), findsNothing);
      expect(find.byKey(const Key('note_gate_checkbox_tile')), findsNothing);

      // Verify Continue Button is immediately enabled
      final continueBtnFinder = find.byKey(const Key('practice_continue_button'));
      expect(continueBtnFinder, findsOneWidget);
      final continueBtn = tester.widget<ElevatedButton>(continueBtnFinder);
      expect(continueBtn.onPressed, isNotNull);

      // 3. Tap Continue to Next Card -> Toast is dismissed
      await tester.tap(continueBtnFinder);
      await tester.pumpAndSettle();
      expect(find.byKey(const Key('top_explanation_toast')), findsNothing);

      // 4. Second attempt: Select CORRECT option (id 101) and Submit
      final correctOptionFinder = find.text('Fields are marked final');
      expect(correctOptionFinder, findsOneWidget);
      await tester.tap(correctOptionFinder);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('practice_submit_button')));
      await tester.pumpAndSettle();

      // Verify CORRECT attempt outcome: +10 pts, Total Score: 10
      expect(find.text('+10 pts'), findsOneWidget);
      expect(find.text('Total Score: 10'), findsWidgets);
      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);

      // 5. Advance to 3rd attempt
      await tester.tap(find.byKey(const Key('practice_continue_button')));
      await tester.pumpAndSettle();

      // 6. Third attempt: Answer correctly again
      await tester.tap(find.text('Fields are marked final'));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('practice_submit_button')));
      await tester.pumpAndSettle();

      // Verify points added ONLY ONCE: +0 pts, Total Score remains 10
      expect(find.text('+0 pts'), findsOneWidget);
      expect(find.text('Total Score: 10'), findsWidgets);
    });
  });
}
