import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import 'oauth_buttons_widget.dart';

class SignInFormWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Role selectedRole;
  final Color roleColor;
  final bool isLoading;
  final VoidCallback onSignIn;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAppleSignIn;
  final VoidCallback? onForgotPassword;

  const SignInFormWidget({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.selectedRole,
    required this.roleColor,
    this.isLoading = false,
    required this.onSignIn,
    required this.onGoogleSignIn,
    required this.onAppleSignIn,
    this.onForgotPassword,
  });

  @override
  State<SignInFormWidget> createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            key: const Key('input_signin_email'),
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email, AutofillHints.username],
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_email_label.tr(),
              hintText: LocaleKeys.auth_email_hint.tr(),
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('input_signin_password'),
            controller: widget.passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => widget.onSignIn(),
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_password_label.tr(),
              hintText: LocaleKeys.auth_password_hint.tr(),
              prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
              suffixIcon: IconButton(
                key: const Key('btn_toggle_signin_password'),
                icon: Icon(
                  _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  size: 20,
                ),
                onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
              ),
            ),
          ),
          if (widget.onForgotPassword != null)
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                key: const Key('btn_forgot_password'),
                onPressed: widget.onForgotPassword,
                child: Text(
                  LocaleKeys.auth_forgot_password.tr(),
                  style: TextStyle(
                    color: widget.roleColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 12),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              key: const Key('btn_submit_signin'),
              icon: widget.isLoading
                  ? const SizedBox.shrink()
                  : const Icon(Icons.login_rounded),
              label: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      widget.selectedRole == Role.student
                          ? LocaleKeys.auth_continue_as_student.tr()
                          : LocaleKeys.auth_continue_as_teacher.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.roleColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: widget.isLoading ? null : widget.onSignIn,
            ),
          ),
          const SizedBox(height: 16),
          OAuthButtonsWidget(
            onGoogleSignIn: widget.onGoogleSignIn,
            onAppleSignIn: widget.onAppleSignIn,
          ),
        ],
      ),
    );
  }
}
