import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/presentation/features/practice/widgets/result_feedback_sheet.dart';
import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('ResultFeedbackWidget widget tests', () {
    testWidgets('renders points delta and total score badge', (tester) async {
      final result = SubmitResult(
        verdict: AttemptStatus.valid,
        reason: ResultReason.correctClean,
        reflexTier: ReflexTier.greenMastered,
        points: 10,
        totalScore: 30,
        responseMs: 1500,
        nextDueAt: DateTime.utc(2026, 11, 10),
      );

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: ResultFeedbackWidget(result: result),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('+10 pts'), findsOneWidget);
      expect(find.byKey(const Key('result_total_score_badge')), findsOneWidget);
      expect(find.text('Total Score: 30'), findsOneWidget);
    });

    testWidgets('renders 0 points when answer is wrong and shows total score', (tester) async {
      final result = SubmitResult(
        verdict: AttemptStatus.wrong,
        reason: ResultReason.wrong,
        reflexTier: ReflexTier.redNeedsWork,
        points: 0,
        totalScore: 10,
        responseMs: 3500,
        nextDueAt: DateTime.utc(2026, 10, 13),
      );

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: ResultFeedbackWidget(result: result),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('+0 pts'), findsOneWidget);
      expect(find.text('Total Score: 10'), findsOneWidget);
    });

    testWidgets('renders in Arabic RTL locale', (tester) async {
      final result = SubmitResult(
        verdict: AttemptStatus.valid,
        reason: ResultReason.correctClean,
        reflexTier: ReflexTier.greenMastered,
        points: 10,
        totalScore: 20,
        responseMs: 1200,
        nextDueAt: DateTime.utc(2026, 11, 10),
      );

      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: ResultFeedbackWidget(result: result),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(ResultFeedbackWidget), findsOneWidget);
      final directionality = Directionality.of(
        tester.element(find.byType(ResultFeedbackWidget)),
      );
      expect(directionality, TextDirection.rtl);
    });
  });
}
