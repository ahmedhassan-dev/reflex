import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/presentation/features/auth/auth_screen.dart';
import 'package:reflex_flutter/presentation/shell/app_shell.dart';
import 'package:reflex_flutter/presentation/shell/widgets/app_drawer_widget.dart';
import 'package:reflex_flutter/presentation/shell/widgets/delete_account_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('AppShell delete account flow navigates directly to AuthScreen', (tester) async {
    // Set smaller screen size to trigger mobile drawer in AppShell
    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(() => tester.view.resetPhysicalSize());

    await tester.pumpWidget(
      createLocalizedTestWidget(
        child: const AppShell(
          initialRole: Role.student,
          userName: 'Alice',
        ),
      ),
    );
    await tester.pumpAndSettle();

    // Verify AppShell rendered
    expect(find.byType(AppShell), findsOneWidget);

    // Open drawer via AppBar leading button
    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();

    // Verify drawer opened
    expect(find.byType(AppDrawerWidget), findsOneWidget);

    // Tap Delete Account button in drawer
    final deleteBtn = find.byKey(const Key('btn_drawer_delete_account'));
    expect(deleteBtn, findsOneWidget);
    await tester.ensureVisible(deleteBtn);
    await tester.pumpAndSettle();
    await tester.tap(deleteBtn);
    await tester.pumpAndSettle();

    // Verify DeleteAccountDialog appeared
    expect(find.byType(DeleteAccountDialog), findsOneWidget);

    // Tap Confirm Delete
    final confirmBtn = find.byKey(const Key('btn_confirm_delete_account'));
    expect(confirmBtn, findsOneWidget);
    await tester.tap(confirmBtn);
    await tester.pumpAndSettle();

    // Verify navigation landed on AuthScreen
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byType(AppShell), findsNothing);
  });
}
