import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class OAuthButtonsWidget extends StatelessWidget {
  final VoidCallback onGoogleSignIn;
  final VoidCallback? onAppleSignIn;
  final bool showAppleSignIn;

  const OAuthButtonsWidget({
    super.key,
    required this.onGoogleSignIn,
    this.onAppleSignIn,
    this.showAppleSignIn = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                LocaleKeys.auth_or_divider.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 14),
        // Google Sign-In Button
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            key: const Key('btn_google_signin'),
            icon: const Icon(Icons.g_mobiledata_rounded, size: 28, color: Colors.redAccent),
            label: Text(
              LocaleKeys.auth_sign_in_with_google.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: onGoogleSignIn,
          ),
        ),
        if (showAppleSignIn && onAppleSignIn != null) ...[
          const SizedBox(height: 10),
          // Apple Sign-In Button
          SizedBox(
            width: double.infinity,
            height: 46,
            child: OutlinedButton.icon(
              key: const Key('btn_apple_signin'),
              icon: const Icon(Icons.apple_rounded, size: 22),
              label: Text(
                LocaleKeys.auth_sign_in_with_apple.tr(),
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onAppleSignIn,
            ),
          ),
        ],
      ],
    );
  }
}
