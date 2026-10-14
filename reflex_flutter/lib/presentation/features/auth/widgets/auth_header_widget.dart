import "package:easy_localization/easy_localization.dart";
import "package:flutter/material.dart";
import "package:reflex_client/reflex_client.dart";
import "../../../core/theme/app_colors.dart";
import "../../../../generated/locale_keys.g.dart";

/// Header icon and title branding widget for the authentication screen.
class AuthHeaderWidget extends StatelessWidget {
  final Role selectedRole;
  final Color roleColor;

  const AuthHeaderWidget({
    super.key,
    required this.selectedRole,
    required this.roleColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  roleColor.withValues(alpha: 0.25),
                  ReflexColors.accent.withValues(alpha: 0.15),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: roleColor.withValues(alpha: 0.25),
                  blurRadius: 24,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(
              selectedRole == Role.student
                  ? Icons.school_rounded
                  : Icons.co_present_rounded,
              size: 40,
              color: roleColor,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          LocaleKeys.auth_welcome_title.tr(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          LocaleKeys.auth_welcome_subtitle.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark
                ? ReflexColors.textSecondaryDark
                : ReflexColors.textSecondaryLight,
          ),
        ),
      ],
    );
  }
}
