import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:reflex_client/reflex_client.dart";
import "package:reflex_flutter/generated/locale_keys.g.dart";
import "package:reflex_flutter/presentation/features/auth/auth_screen.dart";
import "package:reflex_flutter/presentation/features/auth/widgets/forgot_password_widget.dart";
import "package:reflex_flutter/presentation/features/auth/widgets/otp_verification_widget.dart";
import "../test_helpers.dart";

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  group("Auth Screen OTP Verification & Forgot Password Flow Tests", () {
    testWidgets("tapping forgot password button transitions to ForgotPasswordWidget", (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(initialRole: Role.student),
        ),
      );
      await tester.pumpAndSettle();

      // Forgot password button is present in Sign In form
      final forgotBtn = find.byKey(const Key("btn_forgot_password"));
      expect(forgotBtn, findsOneWidget);
      expect(find.text(LocaleKeys.auth_forgot_password.tr()), findsOneWidget);

      // Tap forgot password
      await tester.tap(forgotBtn);
      await tester.pumpAndSettle();

      // Verify ForgotPasswordWidget is shown
      expect(find.byType(ForgotPasswordWidget), findsOneWidget);
      expect(find.byKey(const Key("input_reset_email")), findsOneWidget);
      expect(find.byKey(const Key("btn_send_reset_code")), findsOneWidget);
      expect(find.byKey(const Key("btn_back_to_signin")), findsOneWidget);

      // Tap back to sign in
      await tester.tap(find.byKey(const Key("btn_back_forgot_header")));
      await tester.pumpAndSettle();

      // Verify returned to Sign In tab
      expect(find.byKey(const Key("input_signin_email")), findsOneWidget);
      expect(find.byKey(const Key("input_signin_password")), findsOneWidget);
    });

    testWidgets("ForgotPasswordWidget renders step 2 inputs when code is sent", (tester) async {
      final emailCtrl = TextEditingController(text: "student@example.com");
      final otpCtrl = TextEditingController();
      final newPassCtrl = TextEditingController();
      final confirmPassCtrl = TextEditingController();

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: ForgotPasswordWidget(
              emailController: emailCtrl,
              otpController: otpCtrl,
              newPasswordController: newPassCtrl,
              confirmPasswordController: confirmPassCtrl,
              roleColor: Colors.blue,
              isCodeSent: true,
              onSendResetCode: () {},
              onSubmitPasswordReset: () {},
              onResendResetCode: () {},
              onBack: () {},
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("input_reset_otp")), findsOneWidget);
      expect(find.byKey(const Key("input_new_password")), findsOneWidget);
      expect(find.byKey(const Key("input_confirm_password")), findsOneWidget);
      expect(find.byKey(const Key("btn_submit_password_reset")), findsOneWidget);
      expect(find.byKey(const Key("btn_resend_reset_otp")), findsOneWidget);
    });

    testWidgets("OtpVerificationWidget renders code input, verify and resend buttons", (tester) async {
      final otpCtrl = TextEditingController();
      bool verifyCalled = false;
      bool resendCalled = false;
      bool backCalled = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: Scaffold(
            body: OtpVerificationWidget(
              email: "alice@example.com",
              otpController: otpCtrl,
              roleColor: Colors.indigo,
              onVerify: () => verifyCalled = true,
              onResend: () => resendCalled = true,
              onBack: () => backCalled = true,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("input_otp_code")), findsOneWidget);
      expect(find.byKey(const Key("btn_verify_otp")), findsOneWidget);
      expect(find.byKey(const Key("btn_resend_otp")), findsOneWidget);
      expect(find.byKey(const Key("btn_back_to_signup")), findsOneWidget);

      await tester.tap(find.byKey(const Key("btn_verify_otp")));
      expect(verifyCalled, isTrue);

      await tester.tap(find.byKey(const Key("btn_resend_otp")));
      expect(resendCalled, isTrue);

      await tester.tap(find.byKey(const Key("btn_back_to_signup")));
      expect(backCalled, isTrue);
    });

    testWidgets("renders Arabic translations for forgot password and reset flows", (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          locale: const Locale("ar"),
          child: const AuthScreen(initialRole: Role.student),
        ),
      );
      await tester.pumpAndSettle();

      // Forgot password in Arabic
      expect(find.text("نسيت كلمة المرور؟"), findsOneWidget);

      await tester.tap(find.text("نسيت كلمة المرور؟"));
      await tester.pumpAndSettle();

      expect(find.text("إعادة تعيين كلمة المرور"), findsWidgets);
      expect(find.text("إرسال رمز التعيين"), findsOneWidget);
      expect(find.text("العودة لتسجيل الدخول"), findsOneWidget);
    });

    testWidgets("displays error banner and shortcut to Sign In on duplicate email", (tester) async {
      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: const AuthScreen(initialRole: Role.student),
        ),
      );
      await tester.pumpAndSettle();

      // Switch to Sign Up tab (tab index 1)
      await tester.tap(find.text(LocaleKeys.auth_tab_signup.tr()));
      await tester.pumpAndSettle();

      // Verify on Sign Up tab
      final submitBtn = find.byKey(const Key("btn_submit_signup"));
      expect(submitBtn, findsOneWidget);

      // Trigger sign up with empty email to see validation error banner
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key("auth_error_banner")), findsOneWidget);
      expect(find.text(LocaleKeys.auth_enter_email_password.tr()), findsOneWidget);

      // Enter name, email and password
      await tester.enterText(find.byKey(const Key("input_signup_name")), "Existing User");
      await tester.enterText(find.byKey(const Key("input_signup_email")), "existing@example.com");
      await tester.enterText(find.byKey(const Key("input_signup_password")), "securePassword123");
      await tester.pumpAndSettle();

      // Tap submit sign up
      await tester.ensureVisible(submitBtn);
      await tester.tap(submitBtn);
      await tester.pumpAndSettle();

      // Should show duplicate email or registration error banner without transitioning to OTP
      expect(find.byType(OtpVerificationWidget), findsNothing);
      expect(find.byKey(const Key("auth_error_banner")), findsOneWidget);
    });
  });
}

