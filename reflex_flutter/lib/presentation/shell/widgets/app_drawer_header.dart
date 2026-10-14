import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';

/// Distinctive branded header for the app drawer with user persona info.
class AppDrawerHeader extends StatelessWidget {
  final Role currentRole;
  final String? userName;
  final String? userImageUrl;

  const AppDrawerHeader({
    super.key,
    required this.currentRole,
    this.userName,
    this.userImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final isStudent = currentRole == Role.student;
    final roleColor = isStudent ? ReflexColors.primary : ReflexColors.accent;
    final roleBadgeText = isStudent
        ? LocaleKeys.auth_role_student_badge.tr()
        : LocaleKeys.auth_role_teacher_badge.tr();

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            roleColor.withValues(alpha: 0.18),
            ReflexColors.accent.withValues(alpha: 0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ReflexColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.flash_on_rounded,
                  color: ReflexColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                LocaleKeys.app_title.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: roleColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: roleColor.withValues(alpha: 0.5)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (userImageUrl != null && userImageUrl!.isNotEmpty) ...[
                  CircleAvatar(
                    radius: 10,
                    backgroundImage: NetworkImage(userImageUrl!),
                    onBackgroundImageError: (error, stackTrace) {},
                  ),
                  const SizedBox(width: 6),
                ] else ...[
                  Icon(
                    isStudent ? Icons.school_rounded : Icons.co_present_rounded,
                    size: 14,
                    color: roleColor,
                  ),
                  const SizedBox(width: 6),
                ],
                Text(
                  userName != null ? '$userName ($roleBadgeText)' : roleBadgeText,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: roleColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
