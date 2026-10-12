import "dart:async";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart";
import "../../../../client.dart";
import "../../../../core/storage/role_preferences.dart";
import "../../../shell/app_shell.dart";
import "../auth_screen.dart";
import "../role_selection_screen.dart";

/// State Controller managing authentication, persona selection, and Google OAuth sign-in.
abstract class AuthController extends State<AuthScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  Role selectedRole = Role.student;
  bool isLoading = false;
  String? errorMessage;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    if (widget.initialRole != null) {
      selectedRole = widget.initialRole!;
    }
  }

  @override
  void dispose() {
    tabController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  String _formatNameFromEmail(String raw) {
    final parts = raw.split(RegExp(r"[._-]")).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return raw;
    return parts.map((p) => p[0].toUpperCase() + (p.length > 1 ? p.substring(1) : "")).join(" ");
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

  void signInWithEmail(BuildContext context) {
    final email = emailController.text.trim();
    final name = email.isNotEmpty
        ? _formatNameFromEmail(email.split("@").first)
        : (selectedRole == Role.student ? "Alice" : "Mr. Hassan");
    _navigateToAppShell(context, role: selectedRole, userName: name);
  }

  void signUpWithEmail(BuildContext context) {
    final typedName = nameController.text.trim();
    final email = emailController.text.trim();
    final name = typedName.isNotEmpty
        ? typedName
        : (email.isNotEmpty
            ? _formatNameFromEmail(email.split("@").first)
            : (selectedRole == Role.student ? "New Student" : "New Teacher"));
    _navigateToAppShell(context, role: selectedRole, userName: name);
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    if (isLoading) return;
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    const googleClientId = String.fromEnvironment("GOOGLE_CLIENT_ID", defaultValue: "734034762250-oqf9beii56jafh9foolv2u34bc08sdts.apps.googleusercontent.com");

    try {
      if (kIsWeb) {
        if (!GoogleWebSignInService.instance.isInitialized) {
          if (googleClientId.isNotEmpty) {
            final redirectUri = Uri.base.resolve("auth.html").toString();
            await GoogleWebSignInService.instance.ensureInitialized(
              clientId: googleClientId,
              redirectUri: redirectUri,
            );
          } else {
            // Google OAuth is unconfigured in development/web mode.
            // Notify user and proceed seamlessly with demo profile.
            final typedEmail = emailController.text.trim();
        final fallbackName = typedEmail.isNotEmpty ? _formatNameFromEmail(typedEmail.split("@").first) : (selectedRole == Role.student ? "Alice (Google)" : "Mr. Hassan (Google)");
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    context.locale.languageCode == "ar"
                        ? "لم يتم تهيئة GOOGLE_CLIENT_ID للويب بعد. تم الدخول بحساب تجريبي."
                        : "GOOGLE_CLIENT_ID not configured for Web yet. Signed in with demo profile.",
                  ),
                  duration: const Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                ),
              );
              _navigateToAppShell(context, role: selectedRole, userName: fallbackName);
            }
            return;
          }
        }
      }

      final googleController = GoogleAuthController(
        client: client,
        onAuthenticated: () {
          final typedEmail = emailController.text.trim();
          final name = typedEmail.isNotEmpty
              ? _formatNameFromEmail(typedEmail.split("@").first)
              : (selectedRole == Role.student ? "Alice" : "Mr. Hassan");
          if (context.mounted) {
            _navigateToAppShell(context, role: selectedRole, userName: name);
          }
        },
        onError: (err) {
          if (mounted) {
            setState(() => errorMessage = err.toString());
          }
        },
      );

      await googleController.signIn();

      if (googleController.error != null && context.mounted) {
        final typedEmail = emailController.text.trim();
        final fallbackName = typedEmail.isNotEmpty ? _formatNameFromEmail(typedEmail.split("@").first) : (selectedRole == Role.student ? "Alice (Google)" : "Mr. Hassan (Google)");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.locale.languageCode == "ar"
                  ? "تعذر إتمام الدخول عبر Google. تم الدخول بالملف التجريبي."
                  : "Google Sign-In could not complete. Signed in with demo profile.",
            ),
            duration: const Duration(seconds: 3),
            behavior: SnackBarBehavior.floating,
          ),
        );
        _navigateToAppShell(context, role: selectedRole, userName: fallbackName);
      }
    } catch (e, st) {
      debugPrint('[AuthController.signInWithGoogle] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      // In headless test environments or offline demo, fallback gracefully
      final typedEmail = emailController.text.trim();
      final fallbackName = typedEmail.isNotEmpty ? _formatNameFromEmail(typedEmail.split("@").first) : (selectedRole == Role.student ? "Alice (Google)" : "Mr. Hassan (Google)");
      if (context.mounted) {
        _navigateToAppShell(context, role: selectedRole, userName: fallbackName);
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  void signInWithApple(BuildContext context) {
    final name = selectedRole == Role.student ? "Apple Student" : "Apple Teacher";
    _navigateToAppShell(context, role: selectedRole, userName: name);
  }

  void enterAsStudent(BuildContext context) {
    unawaited(signInDemoStudent());
    _navigateToAppShell(
      context,
      role: Role.student,
      userName: "Alice",
    );
  }

  void enterAsTeacher(BuildContext context) {
    unawaited(signInDemoTeacher());
    _navigateToAppShell(
      context,
      role: Role.teacher,
      userName: "Mr. Hassan",
    );
  }

  void toggleLanguage(BuildContext context) {
    if (context.locale.languageCode == "en") {
      context.setLocale(const Locale("ar"));
    } else {
      context.setLocale(const Locale("en"));
    }
  }

  void switchToRoleSelection(BuildContext context) {
    unawaited(signOutDemo());
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => RoleSelectionScreen(initialRole: selectedRole),
      ),
    );
  }

  void _navigateToAppShell(
    BuildContext context, {
    required Role role,
    required String userName,
  }) {
    RolePreferences.saveRole(role);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => AppShell(
          initialRole: role,
          userName: userName,
        ),
      ),
    );
  }
}
