import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/storage/role_preferences.dart';
import 'package:reflex_flutter/generated/locale_keys.g.dart';
import 'package:reflex_flutter/presentation/features/auth/auth_screen.dart';
import 'package:reflex_flutter/presentation/features/auth/role_selection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('RolePreferences Unit Tests', () {
    test('getSavedRole returns null when no role saved', () async {
      final role = await RolePreferences.getSavedRole();
      expect(role, isNull);
    });

    test('saveRole persists and retrieves role properly', () async {
      await RolePreferences.saveRole(Role.teacher);
      final role = await RolePreferences.getSavedRole();
      expect(role, equals(Role.teacher));

      await RolePreferences.saveRole(Role.student);
      final updated = await RolePreferences.getSavedRole();
      expect(updated, equals(Role.student));

      await RolePreferences.clearRole();
      final cleared = await RolePreferences.getSavedRole();
      expect(cleared, isNull);
    });
  });

  group('RoleSelectionScreen Widget Tests', () {
    testWidgets('renders role cards, welcome header, and continue button', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const RoleSelectionScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Welcome header & prompt
      expect(find.text(LocaleKeys.auth_welcome_title.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.auth_choose_role_prompt.tr()), findsOneWidget);

      // Both role cards exist
      expect(find.byKey(const Key('role_card_student')), findsOneWidget);
      expect(find.byKey(const Key('role_card_teacher')), findsOneWidget);

      // Continue button exists with default Student role
      expect(find.byKey(const Key('btn_role_continue')), findsOneWidget);
      expect(find.text(LocaleKeys.auth_continue_as_student.tr()), findsOneWidget);
    });

    testWidgets('selecting teacher highlights card and updates continue button', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const RoleSelectionScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Teacher card
      final teacherCardFinder = find.byKey(const Key('role_card_teacher'));
      await tester.tap(teacherCardFinder);
      await tester.pumpAndSettle();

      // Continue button now reflects Teacher
      expect(find.text(LocaleKeys.auth_continue_as_teacher.tr()), findsOneWidget);

      // Tap Student card again
      final studentCardFinder = find.byKey(const Key('role_card_student'));
      await tester.tap(studentCardFinder);
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.auth_continue_as_student.tr()), findsOneWidget);
    });

    testWidgets('pressing continue button persists role and navigates to AuthScreen', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const RoleSelectionScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Select Teacher
      await tester.tap(find.byKey(const Key('role_card_teacher')));
      await tester.pumpAndSettle();

      // Tap Continue
      final continueBtn = find.byKey(const Key('btn_role_continue'));
      await tester.ensureVisible(continueBtn);
      await tester.tap(continueBtn);
      await tester.pumpAndSettle();

      // Role is persisted in SharedPreferences
      final saved = await RolePreferences.getSavedRole();
      expect(saved, equals(Role.teacher));

      // AuthScreen is rendered with Teacher persona banner
      expect(find.byKey(const Key('persona_banner')), findsOneWidget);
      expect(find.text(LocaleKeys.auth_role_teacher.tr()), findsWidgets);
      expect(find.byKey(const Key('input_signin_email')), findsOneWidget);
    });

    testWidgets('renders Arabic translations and RTL layout for role selection', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: const RoleSelectionScreen(),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('مرحباً بك في ريفلكس'), findsOneWidget);
      expect(find.text('طالب'), findsOneWidget);
      expect(find.text('معلم'), findsOneWidget);
      expect(find.text('الدخول كطالب'), findsOneWidget);
    });
  });

  group('AuthScreen Dedicated Form & Persona Widget Tests', () {
    testWidgets('renders persona banner, auth tabs, and sign in inputs', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(initialRole: Role.student),
        ),
      );
      await tester.pumpAndSettle();

      // Persona banner & change role button
      expect(find.byKey(const Key('persona_banner')), findsOneWidget);
      expect(find.byKey(const Key('btn_change_role')), findsOneWidget);
      expect(find.byKey(const Key('btn_switch_role_appbar')), findsOneWidget);

      // Sign In form inputs & buttons
      expect(find.byKey(const Key('input_signin_email')), findsOneWidget);
      expect(find.byKey(const Key('input_signin_password')), findsOneWidget);
      expect(find.byKey(const Key('btn_submit_signin')), findsOneWidget);
      expect(find.text(LocaleKeys.auth_continue_as_student.tr()), findsOneWidget);

      // OAuth buttons
      expect(find.byKey(const Key('btn_google_signin')), findsOneWidget);
      expect(find.byKey(const Key('btn_apple_signin')), findsOneWidget);
    });

    testWidgets('renders teacher role correctly when initialRole is Teacher', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(initialRole: Role.teacher),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(LocaleKeys.auth_role_teacher.tr()), findsWidgets);
      expect(find.text(LocaleKeys.auth_continue_as_teacher.tr()), findsOneWidget);
    });

    testWidgets('tapping change role button navigates back to RoleSelectionScreen', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(initialRole: Role.teacher),
        ),
      );
      await tester.pumpAndSettle();

      // Tap change role in persona banner
      await tester.tap(find.byKey(const Key('btn_change_role')));
      await tester.pumpAndSettle();

      // Returns to RoleSelectionScreen
      expect(find.byKey(const Key('role_card_teacher')), findsOneWidget);
      expect(find.byKey(const Key('role_card_student')), findsOneWidget);
      expect(find.byKey(const Key('btn_role_continue')), findsOneWidget);
    });

    testWidgets('switching to Quick Demo tab reveals demo profiles', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Switch to Quick Demo tab (3rd tab)
      final demoTab = find.text(LocaleKeys.auth_tab_demo.tr());
      await tester.ensureVisible(demoTab);
      await tester.tap(demoTab);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('btn_quick_student')), findsOneWidget);
      expect(find.byKey(const Key('btn_quick_teacher')), findsOneWidget);
    });

    testWidgets('renders Arabic translations on AuthScreen', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: const AuthScreen(initialRole: Role.student),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('مرحباً بك في ريفلكس'), findsOneWidget);
      expect(find.text('طالب'), findsWidgets);
      expect(find.text('الدخول كطالب'), findsOneWidget);
      expect(find.text('تسجيل الدخول عبر Google'), findsOneWidget);
      expect(find.text('تسجيل الدخول عبر Apple'), findsOneWidget);
      expect(find.text('تبديل الدور'), findsWidgets);
    });
  });
}
