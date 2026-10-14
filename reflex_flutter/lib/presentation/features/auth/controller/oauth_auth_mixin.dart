import "dart:async";
import "package:easy_localization/easy_localization.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart";
import "../../../../client.dart";
import "../../../../generated/locale_keys.g.dart";
import "../auth_screen.dart";

/// Mixin handling Google and Apple OAuth flows.
mixin OAuthAuthMixin on State<AuthScreen> {
  bool get isLoading;
  set isLoading(bool value);
  String? get errorMessage;
  set errorMessage(String? value);
  Role get selectedRole;

  void navigateToAppShell({
    required Role role,
    String? userName,
  });

  Future<void> signInWithGoogle() async {
    if (isLoading || isUserAuthenticated) {
      if (isUserAuthenticated) {
        navigateToAppShell(role: selectedRole, userName: null);
      }
      return;
    }
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    const googleClientId = String.fromEnvironment(
      "GOOGLE_CLIENT_ID",
      defaultValue: "734034762250-oqf9beii56jafh9foolv2u34bc08sdts.apps.googleusercontent.com",
    );
    const googleServerClientId = String.fromEnvironment(
      "GOOGLE_SERVER_CLIENT_ID",
      defaultValue: "734034762250-oqf9beii56jafh9foolv2u34bc08sdts.apps.googleusercontent.com",
    );

    try {
      if (kIsWeb && !GoogleWebSignInService.instance.isInitialized) {
        if (googleClientId.isNotEmpty) {
          final redirectUri = Uri.base.resolve("auth.html").toString();
          await GoogleWebSignInService.instance.ensureInitialized(
            clientId: googleClientId,
            redirectUri: redirectUri,
          );
        } else {
          if (mounted) setState(() => errorMessage = LocaleKeys.auth_google_unconfigured.tr());
          return;
        }
      } else if (!kIsWeb) {
        await client.auth.initializeGoogleSignIn(
          clientId: googleClientId,
          serverClientId: googleServerClientId,
        );
      }

      final googleController = GoogleAuthController(
        client: client,
        onAuthenticated: () {
          navigateToAppShell(role: selectedRole, userName: null);
        },
        onError: (err) {
          if (mounted) {
            final errStr = err.toString();
            if (errStr.contains("SignInWhileAuthenticatedException")) {
              navigateToAppShell(role: selectedRole, userName: null);
            } else {
              setState(() => errorMessage = errStr);
            }
          }
        },
      );

      await googleController.signIn();
      if (googleController.error != null && mounted) {
        final errStr = googleController.error.toString();
        if (errStr.contains("SignInWhileAuthenticatedException")) {
          navigateToAppShell(role: selectedRole, userName: null);
          return;
        }
        _showError("${LocaleKeys.auth_google_signin_failed.tr()}: $errStr");
      }
    } catch (e, st) {
      debugPrint("[OAuthAuthMixin.signInWithGoogle] error: $e\n$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        if (e.toString().contains("SignInWhileAuthenticatedException")) {
          navigateToAppShell(role: selectedRole, userName: null);
          return;
        }
        _showError("${LocaleKeys.auth_google_signin_failed.tr()}: $e");
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  void _showError(String msg) {
    if (!mounted) return;
    setState(() => errorMessage = msg);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: Theme.of(context).colorScheme.error,
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void signInWithApple() {
    final name = selectedRole == Role.student ? "Apple Student" : "Apple Teacher";
    navigateToAppShell(role: selectedRole, userName: name);
  }
}
