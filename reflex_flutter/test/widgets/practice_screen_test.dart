import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/practice_repository.dart';
import 'package:reflex_flutter/presentation/features/practice/practice_screen.dart';
import 'package:reflex_flutter/presentation/features/practice/widgets/help_bottom_sheet.dart';
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

  group('PracticeScreen widget tests', () {
    testWidgets('Help button triggers HelpBottomSheet', (tester) async {
      final sampleCard = PracticeItem(
        kind: CardKind.review,
        question: QuestionView(
          id: 42,
          prompt: 'What is the SI unit of force?',
          topic: 'Physics',
          questionType: QuestionType.multipleChoice,
          points: 10,
          expectedSeconds: 5,
          hasHelpHint: true,
          options: [
            QuestionOptionView(id: 1, text: 'Newton'),
            QuestionOptionView(id: 2, text: 'Joule'),
          ],
        ),
      );

      final sampleHelp = HelpResult(
        helpHint: 'Think of Isaac and falling apples.',
      );

      when(() => mockRepo.serveNextCard(any()))
          .thenAnswer((_) async => Result.success(sampleCard));
      when(() => mockRepo.requestHelp(42))
          .thenAnswer((_) async => Result.success(sampleHelp));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: PracticeScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify question prompt is visible
      expect(find.text('What is the SI unit of force?'), findsOneWidget);

      // Verify Help button is displayed
      final helpButtonFinder = find.byKey(const Key('practice_help_button'));
      expect(helpButtonFinder, findsOneWidget);

      // Tap Help button
      await tester.tap(helpButtonFinder);
      await tester.pumpAndSettle();

      // Verify HelpBottomSheet is triggered and contains the hint
      expect(find.byType(HelpBottomSheet), findsOneWidget);
      expect(find.text('Think of Isaac and falling apples.'), findsOneWidget);

      // Dismiss help sheet
      await tester.tap(find.byKey(const Key('help_got_it_button')));
      await tester.pumpAndSettle();

      expect(find.byType(HelpBottomSheet), findsNothing);
    });

    testWidgets('private course shows subscription request barrier', (tester) async {
      when(() => mockRepo.listCourses()).thenAnswer((_) async => Result.success([
            Course(id: 2, title: 'Private Physics', subject: 'Physics', isPublic: false, teacherName: 'Dr. Feynman'),
          ]));
      when(() => mockRepo.getCourseSubscriptionStatus(2))
          .thenAnswer((_) async => Result.success(null));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: PracticeScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Private access card is shown
      expect(find.byKey(const Key('btn_request_subscription')), findsOneWidget);
      expect(find.text('Teacher: Dr. Feynman'), findsOneWidget);
    });

    testWidgets('student can request subscription on private course', (tester) async {
      when(() => mockRepo.listCourses()).thenAnswer((_) async => Result.success([
            Course(id: 2, title: 'Private Physics', subject: 'Physics', isPublic: false),
          ]));
      when(() => mockRepo.getCourseSubscriptionStatus(2))
          .thenAnswer((_) async => Result.success(null));
      when(() => mockRepo.requestCourseSubscription(2)).thenAnswer(
        (_) async => Result.success(CourseSubscription(
          id: 1,
          courseId: 2,
          studentId: 99,
          status: SubscriptionStatus.pending,
          requestedAt: DateTime.now(),
        )),
      );

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: PracticeScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final reqBtn = find.byKey(const Key('btn_request_subscription'));
      expect(reqBtn, findsOneWidget);
      await tester.tap(reqBtn);
      await tester.pumpAndSettle();

      verify(() => mockRepo.requestCourseSubscription(2)).called(1);
      expect(find.byKey(const Key('btn_refresh_subscription_status')), findsOneWidget);
    });
  });
}
