import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/presentation/shell/widgets/app_drawer_widget.dart';
import 'package:reflex_flutter/presentation/shell/widgets/legal_doc_dialog.dart';
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
      bool accountDeleted = false;

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
              onDeleteAccount: () async {
                accountDeleted = true;
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

      // Verify Privacy Policy tile opens LegalDocDialog
      expect(find.byKey(const Key('btn_drawer_privacy_policy')), findsOneWidget);
      await tester.tap(find.byKey(const Key('btn_drawer_privacy_policy')));
      await tester.pumpAndSettle();
      expect(find.byType(LegalDocDialog), findsOneWidget);
      // Close dialog
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();

      // Re-open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify Terms of Service tile exists
      expect(find.byKey(const Key('btn_drawer_terms_of_service')), findsOneWidget);

      // Toggle time machine switch
      await tester.tap(find.byType(Switch));
      await tester.pumpAndSettle();
      expect(timeMachineToggled, isTrue);

      // Re-open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify Delete Account button and dialog
      final deleteBtn = find.byKey(const Key('btn_drawer_delete_account'));
      expect(deleteBtn, findsOneWidget);
      await tester.ensureVisible(deleteBtn);
      await tester.pumpAndSettle();
      await tester.tap(deleteBtn);
      await tester.pumpAndSettle();

      // Confirm deletion in dialog
      expect(find.byKey(const Key('btn_confirm_delete_account')), findsOneWidget);
      await tester.tap(find.byKey(const Key('btn_confirm_delete_account')));
      await tester.pumpAndSettle();
      expect(accountDeleted, isTrue);

      // Re-open drawer
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      // Verify sign out button
      final signOutBtn = find.byKey(const Key('btn_drawer_sign_out'));
      expect(signOutBtn, findsOneWidget);
      await tester.ensureVisible(signOutBtn);
      await tester.pumpAndSettle();
      await tester.tap(signOutBtn);
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
              onDeleteAccount: () async {},
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
