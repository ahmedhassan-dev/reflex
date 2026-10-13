import "dart:async";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart";
import "../../../../client.dart";
import "../../../../core/storage/role_preferences.dart";
import "../../../../generated/locale_keys.g.dart";
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


  void selectRole(Role role) {
    if (selectedRole != role) {
      setState(() {
        selectedRole = role;
        errorMessage = null;
      });
      RolePreferences.saveRole(role);
    }
  }

  Future<void> signInWithEmail(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = LocaleKeys.auth_enter_email_password.tr();
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final authSuccess = await client.emailIdp.login(
        email: email,
        password: password,
      );
      await authSessionManager?.updateSignedInUser(authSuccess);

      if (context.mounted) {
        _navigateToAppShell(context, role: selectedRole, userName: null);
      }
    } catch (e, st) {
      debugPrint('[AuthController.signInWithEmail] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() {
          errorMessage = LocaleKeys.auth_invalid_credentials.tr();
        });
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<void> signUpWithEmail(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = LocaleKeys.auth_enter_email_password.tr();
      });
      return;
    }
    if (password.length < 8) {
      setState(() {
        errorMessage = LocaleKeys.auth_password_too_short.tr();
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      await client.emailIdp.startRegistration(email: email);
      if (mounted) {
        setState(() {
          errorMessage = null;
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                context.locale.languageCode == "ar"
                    ? "تم إرسال كود التحقق إلى بريدك الإلكتروني."
                    : "Verification code sent to your email.",
              ),
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e, st) {
      debugPrint('[AuthController.signUpWithEmail] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() {
          errorMessage = '${LocaleKeys.auth_registration_failed.tr()}: $e';
        });
      }
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
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
            if (mounted) {
              setState(() {
                errorMessage = LocaleKeys.auth_google_unconfigured.tr();
              });
            }
            return;
          }
        }
      }

      final googleController = GoogleAuthController(
        client: client,
        onAuthenticated: () {
          if (context.mounted) {
            _navigateToAppShell(context, role: selectedRole, userName: null);
          }
        },
        onError: (err) {
          if (mounted) {
            setState(() => errorMessage = err.toString());
          }
        },
      );

      await googleController.signIn();

      if (googleController.error != null && mounted) {
        setState(() {
          errorMessage = googleController.error.toString();
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${LocaleKeys.auth_google_signin_failed.tr()}: ${googleController.error}',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      }
    } catch (e, st) {
      debugPrint('[AuthController.signInWithGoogle] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() {
          errorMessage = '${LocaleKeys.auth_google_signin_failed.tr()}: $e';
        });
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${LocaleKeys.auth_google_signin_failed.tr()}: $e',
              ),
              backgroundColor: Theme.of(context).colorScheme.error,
              duration: const Duration(seconds: 4),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
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
    _navigateToAppShell(context, role: Role.student, userName: "Alice");
  }

  void enterAsStudentBob(BuildContext context) {
    unawaited(signInDemoStudentBob());
    _navigateToAppShell(context, role: Role.student, userName: "Bob");
  }

  void enterAsStudentCharlie(BuildContext context) {
    unawaited(signInDemoStudentCharlie());
    _navigateToAppShell(context, role: Role.student, userName: "Charlie");
  }

  void enterAsTeacher(BuildContext context) {
    unawaited(signInDemoTeacher());
    _navigateToAppShell(context, role: Role.teacher, userName: "Mr. Hassan");
  }

  void enterAsTeacherSarah(BuildContext context) {
    unawaited(signInDemoTeacherSarah());
    _navigateToAppShell(context, role: Role.teacher, userName: "Dr. Sarah");
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
    String? userName,
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
