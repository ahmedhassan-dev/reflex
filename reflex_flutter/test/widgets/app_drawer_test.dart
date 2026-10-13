import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/presentation/shell/widgets/app_drawer_widget.dart';
import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('AppDrawerWidget tests', () {
    testWidgets('renders user info, language toggle, and sign out in drawer',
        (tester) async {
      bool timeMachineToggled = false;
      bool signedOut = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            drawer: AppDrawerWidget(
              currentRole: Role.student,
              userName: 'Alice',
              showTimeMachine: false,
              onToggleTimeMachine: (val) {
                timeMachineToggled = val;
              },
              onSignOut: () {
                signedOut = true;
              },
            ),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify user name and badge
      expect(find.text('Alice (Student)'), findsOneWidget);

      // Verify language tile exists
      expect(find.byKey(const Key('btn_drawer_switch_language')), findsOneWidget);

      // Tap language tile
      await tester.tap(find.byKey(const Key('btn_drawer_switch_language')));
      await tester.pumpAndSettle();

      // Re-open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Toggle time machine switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(timeMachineToggled, isTrue);

      // Re-open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify sign out button
      expect(find.byKey(const Key('btn_drawer_sign_out')), findsOneWidget);
      await tester.tap(find.byKey(const Key('btn_drawer_sign_out')));
      await tester.pumpAndSettle();

      expect(signedOut, isTrue);
    });

    testWidgets('renders profile image when userImageUrl is provided',
        (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            drawer: AppDrawerWidget(
              currentRole: Role.student,
              userName: 'Amira',
              userImageUrl: 'https://example.com/avatar.jpg',
              showTimeMachine: false,
              onToggleTimeMachine: (_) {},
              onSignOut: () {},
            ),
            body: Builder(
              builder: (ctx) => ElevatedButton(
                onPressed: () => Scaffold.of(ctx).openDrawer(),
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      expect(find.byType(CircleAvatar), findsOneWidget);
      expect(find.text('Amira (Student)'), findsOneWidget);
    });
  });
}
