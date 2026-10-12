import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_flutter/presentation/features/practice/widgets/top_explanation_toast.dart';
import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('TopExplanationToast widget tests', () {
    testWidgets('shows toast overlay with explanation text and dismisses on close',
        (tester) async {
      OverlayEntry? toastEntry;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                key: const Key('trigger_toast_btn'),
                onPressed: () {
                  toastEntry = showTopExplanationToast(
                    context,
                    explanation: 'A vector has both magnitude and direction.',
                  );
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Trigger toast
      await tester.tap(find.byKey(const Key('trigger_toast_btn')));
      await tester.pumpAndSettle();

      // Toast is visible
      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);
      expect(find.text('A vector has both magnitude and direction.'), findsOneWidget);

      // Tap close button
      await tester.tap(find.byKey(const Key('top_explanation_toast_close_button')));
      await tester.pumpAndSettle();

      // Toast is dismissed
      expect(find.byKey(const Key('top_explanation_toast')), findsNothing);
      expect(toastEntry?.mounted, isFalse);
    });

    testWidgets('renders in Arabic RTL locale', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                key: const Key('trigger_ar_toast_btn'),
                onPressed: () {
                  showTopExplanationToast(
                    context,
                    explanation: 'المتجه له مقدار واتجاه.',
                  );
                },
                child: const Text('عرض'),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('trigger_ar_toast_btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);
      expect(find.text('المتجه له مقدار واتجاه.'), findsOneWidget);

      final directionality = Directionality.of(
        tester.element(find.byKey(const Key('top_explanation_toast'))),
      );
      expect(directionality, TextDirection.rtl);
    });

    testWidgets('toast persists indefinitely without auto-dismissing until closed manually',
        (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Builder(
            builder: (context) {
              return ElevatedButton(
                key: const Key('trigger_persist_toast_btn'),
                onPressed: () {
                  showTopExplanationToast(
                    context,
                    explanation: 'Persistent explanation note.',
                  );
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('trigger_persist_toast_btn')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);

      // Fast-forward 15 seconds to ensure it does not auto-dismiss
      await tester.pump(const Duration(seconds: 15));
      expect(find.byKey(const Key('top_explanation_toast')), findsOneWidget);

      // Dismiss manually
      await tester.tap(find.byKey(const Key('top_explanation_toast_close_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('top_explanation_toast')), findsNothing);
    });
  });
}
