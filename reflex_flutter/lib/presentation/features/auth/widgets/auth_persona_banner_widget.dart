import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class AuthPersonaBannerWidget extends StatelessWidget {
  final Role selectedRole;
  final Color roleColor;
  final VoidCallback onSwitchRole;

  const AuthPersonaBannerWidget({
    super.key,
    required this.selectedRole,
    required this.roleColor,
    required this.onSwitchRole,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      key: const Key('persona_banner'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: roleColor.withValues(alpha: isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: roleColor.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              selectedRole == Role.student
                  ? Icons.school_rounded
                  : Icons.co_present_rounded,
              color: roleColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  selectedRole == Role.student
                      ? LocaleKeys.auth_role_student.tr()
                      : LocaleKeys.auth_role_teacher.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: roleColor,
                  ),
                ),
                Text(
                  selectedRole == Role.student
                      ? LocaleKeys.auth_role_student_desc.tr()
                      : LocaleKeys.auth_role_teacher_desc.tr(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? ReflexColors.textSecondaryDark
                        : ReflexColors.textSecondaryLight,
                  ),
                ),
              ],
            ),
          ),
          TextButton.icon(
            key: const Key('btn_change_role'),
            icon: const Icon(Icons.swap_horiz_rounded, size: 18),
            label: Text(
              LocaleKeys.auth_switch_role.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            style: TextButton.styleFrom(
              foregroundColor: roleColor,
            ),
            onPressed: onSwitchRole,
          ),
        ],
      ),
    );
  }
}
