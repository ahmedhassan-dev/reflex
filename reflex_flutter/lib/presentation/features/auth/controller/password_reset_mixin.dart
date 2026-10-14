import "dart:async";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "../../../../client.dart";
import "../../../../generated/locale_keys.g.dart";
import "../auth_screen.dart";
import "auth_view_mode.dart";

/// Mixin managing Password Reset requests, verification, and completion.
mixin PasswordResetMixin on State<AuthScreen> {
  bool get isLoading;
  set isLoading(bool value);
  String? get errorMessage;
  set errorMessage(String? value);
  AuthViewMode get authViewMode;
  set authViewMode(AuthViewMode value);
  UuidValue? get passwordResetRequestId;
  set passwordResetRequestId(UuidValue? value);
  bool get isResetCodeSent;
  set isResetCodeSent(bool value);

  TextEditingController get emailController;
  TextEditingController get passwordController;
  TextEditingController get otpController;
  TextEditingController get newPasswordController;
  TextEditingController get confirmPasswordController;
  TabController get tabController;
  Role get selectedRole;

  void navigateToAppShell({
    required Role role,
    String? userName,
  });

  void openForgotPassword() {
    setState(() {
      authViewMode = AuthViewMode.forgotPassword;
      isResetCodeSent = false;
      otpController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();
      errorMessage = null;
    });
  }

  Future<void> sendPasswordResetCode() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      setState(() => errorMessage = LocaleKeys.auth_enter_email_password.tr());
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final reqId = await client.emailIdp.startPasswordReset(email: email);
      if (!mounted) return;
      setState(() {
        passwordResetRequestId = reqId;
        isResetCodeSent = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.auth_reset_code_sent.tr()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e, st) {
      debugPrint("[PasswordResetMixin.sendCode] error: $e\n$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) setState(() => errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> verifyResetOtpAndSetPassword() async {
    final code = otpController.text.trim();
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;
    if (code.isEmpty) {
      setState(() => errorMessage = LocaleKeys.auth_enter_otp_code.tr());
      return;
    }
    if (newPassword.length < 8) {
      setState(() => errorMessage = LocaleKeys.auth_password_too_short.tr());
      return;
    }
    if (newPassword != confirmPassword) {
      setState(() => errorMessage = LocaleKeys.auth_passwords_do_not_match.tr());
      return;
    }
    if (passwordResetRequestId == null) {
      setState(() => errorMessage = LocaleKeys.auth_invalid_code.tr());
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final finishToken = await client.emailIdp.verifyPasswordResetCode(
        passwordResetRequestId: passwordResetRequestId!,
        verificationCode: code,
      );
      await client.emailIdp.finishPasswordReset(
        finishPasswordResetToken: finishToken,
        newPassword: newPassword,
      );
      final email = emailController.text.trim();
      try {
        final authSuccess = await client.emailIdp.login(email: email, password: newPassword);
        await authSessionManager?.updateSignedInUser(authSuccess);
        TextInput.finishAutofillContext(shouldSave: true);
        if (!mounted) return;
        navigateToAppShell(role: selectedRole, userName: null);
      } catch (_) {
        if (!mounted) return;
        setState(() {
          authViewMode = AuthViewMode.tabs;
          passwordController.clear();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.auth_password_reset_success.tr()),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (e, st) {
      debugPrint("[PasswordResetMixin.verify] error: $e\n$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        final errStr = e.toString().toLowerCase();
        if (errStr.contains("expired")) {
          setState(() => errorMessage = LocaleKeys.auth_otp_expired.tr());
        } else {
          setState(() => errorMessage = LocaleKeys.auth_invalid_code.tr());
        }
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> resendPasswordResetOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final reqId = await client.emailIdp.startPasswordReset(email: email);
      if (!mounted) return;
      setState(() => passwordResetRequestId = reqId);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.auth_code_resent.tr()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      if (mounted) setState(() => errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
