import "dart:async";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "../../../../client.dart";
import "../../../../core/services/firebase_messaging_service.dart";
import "../../../../core/storage/role_preferences.dart";
import "../../../../generated/locale_keys.g.dart";
import "../../../shell/app_shell.dart";
import "../auth_screen.dart";
import "../role_selection_screen.dart";
import "auth_view_mode.dart";
import "demo_auth_mixin.dart";
import "email_registration_mixin.dart";
import "oauth_auth_mixin.dart";
import "password_reset_mixin.dart";

/// State Controller managing authentication, persona selection, and email/OAuth flows.
abstract class AuthController extends State<AuthScreen>
    with
        SingleTickerProviderStateMixin,
        DemoAuthMixin,
        OAuthAuthMixin,
        PasswordResetMixin,
        EmailRegistrationMixin {
  @override
  late TabController tabController;
  @override
  Role selectedRole = Role.student;
  @override
  bool isLoading = false;
  @override
  String? errorMessage;
  @override
  bool acceptedPrivacyPolicy = false;

  @override
  AuthViewMode authViewMode = AuthViewMode.tabs;
  @override
  UuidValue? accountRequestId;
  @override
  UuidValue? passwordResetRequestId;
  @override
  bool isResetCodeSent = false;

  Future<void> signUpWithGoogle() async {
    if (!acceptedPrivacyPolicy) {
      setState(() => errorMessage = LocaleKeys.auth_must_accept_privacy_policy.tr());
      return;
    }
    await signInWithGoogle();
  }

  @override
  final emailController = TextEditingController();
  @override
  final passwordController = TextEditingController();
  @override
  final nameController = TextEditingController();
  @override
  final otpController = TextEditingController();
  @override
  final newPasswordController = TextEditingController();
  @override
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    if (widget.initialRole != null) {
      selectedRole = widget.initialRole!;
    }
    if (isUserAuthenticated) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _navigateToAppShell(role: selectedRole, userName: null);
      });
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void selectRole(Role role) {
    if (selectedRole != role) {
      setState(() {
        selectedRole = role;
        errorMessage = null;
      });
      RolePreferences.saveRole(role);
    }
  }

  Future<void> signInWithEmail() async {
    if (isUserAuthenticated) {
      _navigateToAppShell(role: selectedRole, userName: null);
      return;
    }
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() => errorMessage = LocaleKeys.auth_enter_email_password.tr());
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final authSuccess = await client.emailIdp.login(email: email, password: password);
      await authSessionManager?.updateSignedInUser(authSuccess);
      TextInput.finishAutofillContext(shouldSave: true);
      _navigateToAppShell(role: selectedRole, userName: null);
    } catch (e, st) {
      TextInput.finishAutofillContext(shouldSave: false);
      debugPrint("[AuthController.signInWithEmail] error: $e\n$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (e.toString().contains("SignInWhileAuthenticatedException")) {
        _navigateToAppShell(role: selectedRole, userName: null);
        return;
      }
      if (mounted) setState(() => errorMessage = LocaleKeys.auth_invalid_credentials.tr());
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void cancelSubView() {
    setState(() {
      authViewMode = AuthViewMode.tabs;
      errorMessage = null;
    });
  }

  void toggleLanguage() {
    final newLocale =
        context.locale.languageCode == "en" ? const Locale("ar") : const Locale("en");
    context.setLocale(newLocale);
  }

  void switchToRoleSelection() {
    unawaited(signOutDemo());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => RoleSelectionScreen(initialRole: selectedRole),
      ),
    );
  }

  @override
  void navigateToAppShell({
    required Role role,
    String? userName,
  }) {
    _navigateToAppShell(role: role, userName: userName);
  }

  void _navigateToAppShell({required Role role, String? userName}) {
    if (!mounted) return;
    RolePreferences.saveRole(role);
    unawaited(FirebaseMessagingService.syncWithServer());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AppShell(initialRole: role, userName: userName),
      ),
    );
  }
}
