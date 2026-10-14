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

/// Mixin managing Email Sign-Up and OTP verification flows.
mixin EmailRegistrationMixin on State<AuthScreen> {
  bool get isLoading;
  set isLoading(bool value);
  String? get errorMessage;
  set errorMessage(String? value);
  AuthViewMode get authViewMode;
  set authViewMode(AuthViewMode value);
  UuidValue? get accountRequestId;
  set accountRequestId(UuidValue? value);

  TextEditingController get emailController;
  TextEditingController get passwordController;
  TextEditingController get nameController;
  TextEditingController get otpController;
  Role get selectedRole;
  bool get acceptedPrivacyPolicy;

  void navigateToAppShell({
    required Role role,
    String? userName,
  });

  Future<void> signUpWithEmail() async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => errorMessage = LocaleKeys.auth_enter_email_password.tr());
      return;
    }
    if (password.length < 8) {
      setState(() => errorMessage = LocaleKeys.auth_password_too_short.tr());
      return;
    }
    if (!acceptedPrivacyPolicy) {
      setState(() => errorMessage = LocaleKeys.auth_must_accept_privacy_policy.tr());
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final isAlreadyRegistered = await client.emailIdp.isEmailRegistered(email: email);
      if (isAlreadyRegistered) {
        if (!mounted) return;
        setState(() => errorMessage = LocaleKeys.auth_email_already_registered.tr());
        return;
      }

      final reqId = await client.emailIdp.startRegistration(email: email);
      if (!mounted) return;
      setState(() {
        accountRequestId = reqId;
        authViewMode = AuthViewMode.otpVerification;
        otpController.clear();
        errorMessage = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(LocaleKeys.auth_code_resent.tr()),
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e, st) {
      debugPrint("[EmailRegistrationMixin.signUp] error: $e\n$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        final errStr = e.toString().toLowerCase();
        if (errStr.contains("policyviolation") || errStr.contains("already")) {
          setState(() => errorMessage = LocaleKeys.auth_email_already_registered.tr());
        } else {
          setState(() => errorMessage = "${LocaleKeys.auth_registration_failed.tr()}: $e");
        }
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> verifyOtpAndCompleteRegistration() async {
    final code = otpController.text.trim();
    if (code.isEmpty) {
      setState(() => errorMessage = LocaleKeys.auth_enter_otp_code.tr());
      return;
    }
    if (accountRequestId == null) {
      setState(() => errorMessage = LocaleKeys.auth_invalid_code.tr());
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final regToken = await client.emailIdp.verifyRegistrationCode(
        accountRequestId: accountRequestId!,
        verificationCode: code,
      );
      final authSuccess = await client.emailIdp.finishRegistration(
        registrationToken: regToken,
        password: passwordController.text,
      );
      await authSessionManager?.updateSignedInUser(authSuccess);
      TextInput.finishAutofillContext(shouldSave: true);
      final fullName = nameController.text.trim();
      if (fullName.isNotEmpty) {
        try {
          await client.userProfile.changeFullName(fullName);
        } catch (_) {}
      }
      await syncUserProfileRole(selectedRole);
      if (!mounted) return;
      navigateToAppShell(
        role: selectedRole,
        userName: fullName.isNotEmpty ? fullName : null,
      );
    } catch (e, st) {
      debugPrint("[EmailRegistrationMixin.verify] error: $e\n$st");
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

  Future<void> resendRegistrationOtp() async {
    final email = emailController.text.trim();
    if (email.isEmpty) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    try {
      final reqId = await client.emailIdp.startRegistration(email: email);
      if (!mounted) return;
      setState(() => accountRequestId = reqId);
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
