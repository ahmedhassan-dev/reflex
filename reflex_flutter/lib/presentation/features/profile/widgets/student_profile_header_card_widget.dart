import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/storage/avatar_preferences.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'avatar_selector_modal.dart';

/// Header card displaying student photo/avatar with upload badge, display name, and total score badge.
class StudentProfileHeaderCardWidget extends StatelessWidget {
  final String displayName;
  final int totalScore;
  final String avatarId;
  final int avatarColorValue;
  final String? imageUrl;
  final bool isUploadingImage;
  final VoidCallback onPickImage;
  final VoidCallback? onRemoveImage;
  final void Function(String newId, int newColor)? onAvatarChanged;

  const StudentProfileHeaderCardWidget({
    super.key,
    required this.displayName,
    required this.totalScore,
    required this.avatarId,
    required this.avatarColorValue,
    this.imageUrl,
    this.isUploadingImage = false,
    required this.onPickImage,
    this.onRemoveImage,
    this.onAvatarChanged,
  });

  void _openAvatarModal(BuildContext context) {
    if (onAvatarChanged != null) {
      AvatarSelectorModal.show(
        context,
        currentAvatarId: avatarId,
        currentColorValue: avatarColorValue,
        onAvatarSaved: (newId, newColor) {
          onAvatarChanged!(newId, newColor);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.profile_avatar_updated.tr()),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        onUploadPhoto: onPickImage,
      );
    } else {
      onPickImage();
    }
  }

  void _handleTapImage(BuildContext context) {
    if (imageUrl != null && imageUrl!.isNotEmpty && onRemoveImage != null) {
      showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        builder: (ctx) => SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.photo_library_rounded, color: ReflexColors.primary),
                  title: Text(LocaleKeys.profile_upload_image.tr()),
                  onTap: () {
                    Navigator.pop(ctx);
                    onPickImage();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                  title: Text(LocaleKeys.profile_remove_image.tr()),
                  onTap: () {
                    Navigator.pop(ctx);
                    onRemoveImage!();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      _openAvatarModal(context);
    }
  }

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
                onTap: () => _handleTapImage(context),
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor: activeAvatarColor,
                  backgroundImage: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? NetworkImage(imageUrl!)
                      : null,
                  onBackgroundImageError: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? (error, stackTrace) {}
                      : null,
                  child: (imageUrl != null && imageUrl!.isNotEmpty)
                      ? null
                      : Icon(
                          activeAvatarOption.icon,
                          size: 34,
                          color: Colors.white,
                        ),
                ),
              ),
              if (isUploadingImage)
                const Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Colors.white,
                    ),
                  ),
                ),
              Positioned(
                right: 0,
                bottom: 0,
                child: GestureDetector(
                  key: const Key('btn_edit_profile_image'),
                  onTap: onPickImage,
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.25),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.camera_alt_rounded,
                      size: 15,
                      color: ReflexColors.primary,
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
