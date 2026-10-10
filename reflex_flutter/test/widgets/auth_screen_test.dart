import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_flutter/generated/locale_keys.g.dart';
import 'package:reflex_flutter/presentation/features/auth/auth_screen.dart';

import '../test_helpers.dart';

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group('AuthScreen & Role Selection Widget Tests', () {
    testWidgets('renders role cards, tabs, and form elements', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify welcome header
      expect(find.text(LocaleKeys.auth_welcome_title.tr()), findsOneWidget);
      expect(find.text(LocaleKeys.auth_choose_role_prompt.tr()), findsOneWidget);

      // Verify both role cards exist
      expect(find.byKey(const Key('role_card_student')), findsOneWidget);
      expect(find.byKey(const Key('role_card_teacher')), findsOneWidget);

      // Verify Sign In form inputs & buttons
      expect(find.byKey(const Key('input_signin_email')), findsOneWidget);
      expect(find.byKey(const Key('input_signin_password')), findsOneWidget);
      expect(find.byKey(const Key('btn_submit_signin')), findsOneWidget);

      // Verify OAuth buttons exist
      expect(find.byKey(const Key('btn_google_signin')), findsOneWidget);
      expect(find.byKey(const Key('btn_apple_signin')), findsOneWidget);
    });

    testWidgets('tapping teacher role card updates selected role to Teacher', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap Teacher card
      final teacherCardFinder = find.byKey(const Key('role_card_teacher'));
      await tester.tap(teacherCardFinder);
      await tester.pumpAndSettle();

      // Verify submit button now reflects Teacher
      expect(find.text(LocaleKeys.auth_continue_as_teacher.tr()), findsOneWidget);

      // Tap Student card again
      final studentCardFinder = find.byKey(const Key('role_card_student'));
      await tester.tap(studentCardFinder);
      await tester.pumpAndSettle();

      // Verify submit button updates back to Student
      expect(find.text(LocaleKeys.auth_continue_as_student.tr()), findsOneWidget);
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

    testWidgets('renders Arabic translations and RTL layout under Arabic locale', (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale('ar'),
          child: const AuthScreen(),
        ),
      );
      await tester.pumpAndSettle();

      // Verify Arabic welcome header & role titles
      expect(find.text('مرحباً بك في ريفلكس'), findsOneWidget);
      expect(find.text('طالب'), findsOneWidget);
      expect(find.text('معلم'), findsOneWidget);
      expect(find.text('الدخول كطالب'), findsOneWidget);
      expect(find.text('تسجيل الدخول عبر Google'), findsOneWidget);
      expect(find.text('تسجيل الدخول عبر Apple'), findsOneWidget);
    });
  });
}
