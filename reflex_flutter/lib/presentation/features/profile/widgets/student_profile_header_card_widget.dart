import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/storage/avatar_preferences.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'avatar_selector_modal.dart';

/// Header card displaying student avatar with customization badge, display name, and total score badge.
class StudentProfileHeaderCardWidget extends StatelessWidget {
  final String displayName;
  final int totalScore;
  final String avatarId;
  final int avatarColorValue;
  final void Function(String newId, int newColor) onAvatarChanged;

  const StudentProfileHeaderCardWidget({
    super.key,
    required this.displayName,
    required this.totalScore,
    required this.avatarId,
    required this.avatarColorValue,
    required this.onAvatarChanged,
  });

  @override
  Widget build(BuildContext context) {
    final activeAvatarOption = AvatarPreferences.getAvatarOption(avatarId);
    final activeAvatarColor = Color(avatarColorValue);

    return Container(
      padding: const EdgeInsetsDirectional.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ReflexColors.primary,
            ReflexColors.accent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ReflexColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Stack(
            children: [
              GestureDetector(
                key: const Key('btn_change_avatar'),
                onTap: () => AvatarSelectorModal.show(
                  context,
                  currentAvatarId: avatarId,
                  currentColorValue: avatarColorValue,
                  onAvatarSaved: (newId, newColor) {
                    onAvatarChanged(newId, newColor);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(LocaleKeys.profile_avatar_updated.tr()),
                        duration: const Duration(seconds: 2),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                ),
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: activeAvatarColor,
                  child: Icon(
                    activeAvatarOption.icon,
                    size: 34,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => AvatarSelectorModal.show(
                    context,
                    currentAvatarId: avatarId,
                    currentColorValue: avatarColorValue,
                    onAvatarSaved: (newId, newColor) {
                      onAvatarChanged(newId, newColor);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(LocaleKeys.profile_avatar_updated.tr()),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.edit_rounded,
                      size: 14,
                      color: activeAvatarColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  displayName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  LocaleKeys.profile_summary_subtitle.tr(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            key: const Key('student_progress_total_score_badge'),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.stars_rounded,
                      color: ReflexColors.chromaticYellow,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$totalScore',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  LocaleKeys.practice_total_score.tr(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.9),
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
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
