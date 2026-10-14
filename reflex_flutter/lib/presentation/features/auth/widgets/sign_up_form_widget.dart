import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../shell/widgets/legal_doc_dialog.dart';
import 'oauth_buttons_widget.dart';

class SignUpFormWidget extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Role selectedRole;
  final Color roleColor;
  final bool isLoading;
  final bool acceptedPrivacyPolicy;
  final ValueChanged<bool?> onPrivacyPolicyChanged;
  final VoidCallback onSignUp;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onAppleSignIn;

  const SignUpFormWidget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.selectedRole,
    required this.roleColor,
    this.isLoading = false,
    this.acceptedPrivacyPolicy = false,
    required this.onPrivacyPolicyChanged,
    required this.onSignUp,
    required this.onGoogleSignIn,
    required this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const Key('input_signup_name'),
          controller: nameController,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_name_label.tr(),
            hintText: LocaleKeys.auth_name_hint.tr(),
            prefixIcon: const Icon(Icons.badge_outlined, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('input_signup_email'),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_email_label.tr(),
            hintText: LocaleKeys.auth_email_hint.tr(),
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('input_signup_password'),
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_password_label.tr(),
            hintText: LocaleKeys.auth_password_hint.tr(),
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                key: const Key('checkbox_privacy_policy'),
                value: acceptedPrivacyPolicy,
                activeColor: roleColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                onChanged: isLoading ? null : onPrivacyPolicyChanged,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text.rich(
                TextSpan(
                  text: LocaleKeys.auth_agree_to_terms_prefix.tr(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                  children: [
                    TextSpan(
                      text: LocaleKeys.auth_terms_of_service_link.tr(),
                      style: TextStyle(
                        color: roleColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => LegalDocDialog.show(context, LegalDocType.termsOfService),
                    ),
                    TextSpan(
                      text: LocaleKeys.auth_and_conjunction.tr(),
                    ),
                    TextSpan(
                      text: LocaleKeys.auth_privacy_policy_link.tr(),
                      style: TextStyle(
                        color: roleColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => LegalDocDialog.show(context, LegalDocType.privacyPolicy),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            key: const Key('btn_submit_signup'),
            icon: isLoading
                ? const SizedBox.shrink()
                : const Icon(Icons.check_circle_outline_rounded),
            label: isLoading
                ? const SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    '${LocaleKeys.auth_create_account.tr()} (${selectedRole == Role.student ? LocaleKeys.auth_role_student.tr() : LocaleKeys.auth_role_teacher.tr()})',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: roleColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: isLoading ? null : onSignUp,
          ),
        ),
        const SizedBox(height: 16),
        OAuthButtonsWidget(
          onGoogleSignIn: onGoogleSignIn,
          onAppleSignIn: onAppleSignIn,
        ),
      ],
    );
  }
}
