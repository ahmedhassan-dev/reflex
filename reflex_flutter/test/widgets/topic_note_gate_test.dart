import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_flutter/presentation/features/practice/widgets/topic_note_gate_widget.dart';
import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('TopicNoteGateWidget tests', () {
    testWidgets('Continue button is enabled immediately and advances card without checkbox',
        (tester) async {
      bool continued = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: TopicNoteGateWidget(
            topicNote: 'Foundational concept note for physics vectors',
            onContinue: () {
              continued = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final continueButtonFinder = find.byKey(const Key('practice_continue_button'));
      expect(continueButtonFinder, findsOneWidget);

      // Checkbox is removed
      expect(find.byKey(const Key('note_gate_checkbox')), findsNothing);
      expect(find.byKey(const Key('note_gate_checkbox_tile')), findsNothing);

      // Button is immediately enabled
      final continueButton = tester.widget<ElevatedButton>(continueButtonFinder);
      expect(continueButton.onPressed, isNotNull);

      // Tap continue
      await tester.tap(continueButtonFinder);
      await tester.pumpAndSettle();

      expect(continued, isTrue);
    });

    testWidgets('Arabic locale renders RTL text alignment', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: TopicNoteGateWidget(
            topicNote: 'شرح مفهوم المتجهات الفيزيائية',
            onContinue: () {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TopicNoteGateWidget), findsOneWidget);
      final directionality = Directionality.of(tester.element(find.byType(TopicNoteGateWidget)));
      expect(directionality, TextDirection.rtl);
    });
  });
}
