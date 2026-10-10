import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_flutter/presentation/features/practice/widgets/topic_note_gate_widget.dart';
import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('TopicNoteGateWidget tests', () {
    testWidgets('Continue button is disabled when topic note is present and unacknowledged',
        (tester) async {
      bool continued = false;
      bool acknowledged = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: TopicNoteGateWidget(
            topicNote: 'Foundational concept note for physics vectors',
            isAcknowledged: acknowledged,
            onAcknowledgeChanged: (_) {},
            onContinue: () {
              continued = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      final continueButtonFinder = find.byKey(const Key('practice_continue_button'));
      expect(continueButtonFinder, findsOneWidget);

      final continueButton = tester.widget<ElevatedButton>(continueButtonFinder);
      expect(continueButton.onPressed, isNull,
          reason: 'Button must be strictly disabled before acknowledgment');
      expect(continued, isFalse);
    });

    testWidgets('Tapping acknowledge enables Continue button and advances card',
        (tester) async {
      bool continued = false;
      bool acknowledged = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: StatefulBuilder(
            builder: (context, setState) {
              return TopicNoteGateWidget(
                topicNote: 'Essential vector addition principles',
                isAcknowledged: acknowledged,
                onAcknowledgeChanged: (val) {
                  setState(() {
                    acknowledged = val;
                  });
                },
                onContinue: () {
                  continued = true;
                },
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Checkbox is initially false
      final checkboxFinder = find.byKey(const Key('note_gate_checkbox'));
      expect(checkboxFinder, findsOneWidget);
      expect(tester.widget<Checkbox>(checkboxFinder).value, isFalse);

      // Tap acknowledge
      await tester.tap(checkboxFinder);
      await tester.pumpAndSettle();

      expect(acknowledged, isTrue);

      // Button is now enabled
      final continueButton =
          tester.widget<ElevatedButton>(find.byKey(const Key('practice_continue_button')));
      expect(continueButton.onPressed, isNotNull);

      // Tap continue
      await tester.tap(find.byKey(const Key('practice_continue_button')));
      await tester.pumpAndSettle();

      expect(continued, isTrue);
    });

    testWidgets('Arabic locale renders RTL text alignment', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: TopicNoteGateWidget(
            topicNote: 'شرح مفهوم المتجهات الفيزيائية',
            isAcknowledged: false,
            onAcknowledgeChanged: (_) {},
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
