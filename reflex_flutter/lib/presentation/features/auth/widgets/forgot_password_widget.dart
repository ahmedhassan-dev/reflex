import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "../../../core/theme/app_colors.dart";
import "../../../../generated/locale_keys.g.dart";

/// Widget managing the two-step Password Reset flow:
/// Step 1: Request reset OTP to email.
/// Step 2: Enter reset OTP and define new password.
class ForgotPasswordWidget extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController otpController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final Color roleColor;
  final bool isCodeSent;
  final bool isLoading;
  final VoidCallback onSendResetCode;
  final VoidCallback onSubmitPasswordReset;
  final VoidCallback onResendResetCode;
  final VoidCallback onBack;

  const ForgotPasswordWidget({
    super.key,
    required this.emailController,
    required this.otpController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.roleColor,
    required this.isCodeSent,
    this.isLoading = false,
    required this.onSendResetCode,
    required this.onSubmitPasswordReset,
    required this.onResendResetCode,
    required this.onBack,
  });

  @override
  State<ForgotPasswordWidget> createState() => _ForgotPasswordWidgetState();
}

class _ForgotPasswordWidgetState extends State<ForgotPasswordWidget> {
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              key: const Key("btn_back_forgot_header"),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: LocaleKeys.auth_back_to_signin.tr(),
              onPressed: widget.onBack,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                LocaleKeys.auth_reset_password_title.tr(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.roleColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.isCodeSent ? Icons.mark_email_read_rounded : Icons.lock_reset_rounded,
              size: 40,
              color: widget.roleColor,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          LocaleKeys.auth_reset_password_title.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          widget.isCodeSent
              ? LocaleKeys.auth_reset_enter_code_desc.tr(args: [widget.emailController.text])
              : LocaleKeys.auth_reset_password_desc.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 20),
        if (!widget.isCodeSent) ...[
          TextField(
            key: const Key("input_reset_email"),
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_email_label.tr(),
              hintText: LocaleKeys.auth_email_hint.tr(),
              prefixIcon: const Icon(Icons.email_outlined, size: 20),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              key: const Key("btn_send_reset_code"),
              icon: widget.isLoading
                  ? const SizedBox.shrink()
                  : const Icon(Icons.send_rounded),
              label: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Text(
                      LocaleKeys.auth_send_reset_code.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.roleColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: widget.isLoading ? null : widget.onSendResetCode,
            ),
          ),
        ] else ...[
          TextField(
            key: const Key("input_reset_otp"),
            controller: widget.otpController,
            textAlign: TextAlign.center,
            maxLength: 8,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, letterSpacing: 5),
            decoration: InputDecoration(
              counterText: "",
              labelText: LocaleKeys.auth_otp_code_label.tr(),
              hintText: LocaleKeys.auth_otp_code_hint.tr(),
              prefixIcon: const Icon(Icons.security_rounded, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key("input_new_password"),
            controller: widget.newPasswordController,
            obscureText: _obscureNewPassword,
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_new_password_label.tr(),
              hintText: LocaleKeys.auth_new_password_hint.tr(),
              prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
              suffixIcon: IconButton(
                icon: Icon(_obscureNewPassword ? Icons.visibility_off : Icons.visibility, size: 20),
                onPressed: () => setState(() => _obscureNewPassword = !_obscureNewPassword),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key("input_confirm_password"),
            controller: widget.confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            decoration: InputDecoration(
              labelText: LocaleKeys.auth_confirm_password_label.tr(),
              hintText: LocaleKeys.auth_confirm_password_hint.tr(),
              prefixIcon: const Icon(Icons.lock_reset_rounded, size: 20),
              suffixIcon: IconButton(
                icon: Icon(_obscureConfirmPassword ? Icons.visibility_off : Icons.visibility, size: 20),
                onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
              ),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 50,
            child: ElevatedButton.icon(
              key: const Key("btn_submit_password_reset"),
              icon: widget.isLoading
                  ? const SizedBox.shrink()
                  : const Icon(Icons.check_circle_outline_rounded),
              label: widget.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                    )
                  : Text(
                      LocaleKeys.auth_submit_password_reset.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.roleColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: widget.isLoading ? null : widget.onSubmitPasswordReset,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: TextButton.icon(
              key: const Key("btn_resend_reset_otp"),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(LocaleKeys.auth_resend_code.tr()),
              style: TextButton.styleFrom(foregroundColor: widget.roleColor),
              onPressed: widget.isLoading ? null : widget.onResendResetCode,
            ),
          ),
        ],
        const SizedBox(height: 8),
        Center(
          child: TextButton(
            key: const Key("btn_back_to_signin"),
            onPressed: widget.onBack,
            child: Text(
              LocaleKeys.auth_back_to_signin.tr(),
              style: TextStyle(
                color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
}
