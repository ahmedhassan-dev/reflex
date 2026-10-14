import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "../../../core/theme/app_colors.dart";
import "../../../../generated/locale_keys.g.dart";

/// Dedicated OTP Verification widget for confirming user email on sign-up.
class OtpVerificationWidget extends StatelessWidget {
  final String email;
  final TextEditingController otpController;
  final Color roleColor;
  final bool isLoading;
  final VoidCallback onVerify;
  final VoidCallback onResend;
  final VoidCallback onBack;

  const OtpVerificationWidget({
    super.key,
    required this.email,
    required this.otpController,
    required this.roleColor,
    this.isLoading = false,
    required this.onVerify,
    required this.onResend,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AutofillGroup(
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            IconButton(
              key: const Key("btn_back_otp_header"),
              icon: const Icon(Icons.arrow_back_rounded),
              tooltip: LocaleKeys.auth_back_to_signup.tr(),
              onPressed: onBack,
            ),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                LocaleKeys.auth_verify_email_title.tr(),
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_rounded,
              size: 42,
              color: roleColor,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          LocaleKeys.auth_verify_email_title.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          LocaleKeys.auth_verify_email_subtitle.tr(args: [email]),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 24),
        TextField(
          key: const Key("input_otp_code"),
          controller: otpController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          autofillHints: const [AutofillHints.oneTimeCode],
          onSubmitted: (_) => onVerify(),
          textAlign: TextAlign.center,
          maxLength: 8,
          autofocus: true,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            letterSpacing: 6,
          ),
          decoration: InputDecoration(
            counterText: "",
            labelText: LocaleKeys.auth_otp_code_label.tr(),
            hintText: LocaleKeys.auth_otp_code_hint.tr(),
            prefixIcon: const Icon(Icons.security_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            key: const Key("btn_verify_otp"),
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
                    LocaleKeys.auth_verify_and_create.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: roleColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: isLoading ? null : onVerify,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              key: const Key("btn_resend_otp"),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(LocaleKeys.auth_resend_code.tr()),
              style: TextButton.styleFrom(foregroundColor: roleColor),
              onPressed: isLoading ? null : onResend,
            ),
            const SizedBox(width: 8),
            TextButton(
              key: const Key("btn_back_to_signup"),
              onPressed: onBack,
              child: Text(
                LocaleKeys.auth_back_to_signup.tr(),
                style: TextStyle(
                  color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
}
