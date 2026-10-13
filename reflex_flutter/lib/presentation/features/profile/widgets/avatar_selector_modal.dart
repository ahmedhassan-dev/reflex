import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../core/storage/avatar_preferences.dart';
import '../../../../generated/locale_keys.g.dart';

/// Modal bottom sheet allowing the student to select and customize their profile avatar and color.
class AvatarSelectorModal extends StatefulWidget {
  final String currentAvatarId;
  final int currentColorValue;
  final void Function(String avatarId, int colorValue) onAvatarSaved;

  const AvatarSelectorModal({
    super.key,
    required this.currentAvatarId,
    required this.currentColorValue,
    required this.onAvatarSaved,
  });

  static Future<void> show(
    BuildContext context, {
    required String currentAvatarId,
    required int currentColorValue,
    required void Function(String avatarId, int colorValue) onAvatarSaved,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => AvatarSelectorModal(
        currentAvatarId: currentAvatarId,
        currentColorValue: currentColorValue,
        onAvatarSaved: onAvatarSaved,
      ),
    );
  }

  @override
  State<AvatarSelectorModal> createState() => _AvatarSelectorModalState();
}

class _AvatarSelectorModalState extends State<AvatarSelectorModal> {
  late String _selectedId;
  late int _selectedColor;

  @override
  void initState() {
    super.initState();
    _selectedId = widget.currentAvatarId;
    _selectedColor = widget.currentColorValue;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeOption = AvatarPreferences.getAvatarOption(_selectedId);
    final activeColor = Color(_selectedColor);

    return Container(
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drag Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title & Live Preview
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: activeColor,
                child: Icon(activeOption.icon, size: 30, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.profile_choose_avatar_title.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      activeOption.label,
                      style: TextStyle(
                        fontSize: 13,
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.65),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Avatar Icon Presets Grid
          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: AvatarPreferences.presets.map((preset) {
              final isSelected = preset.id == _selectedId;
              return InkWell(
                key: Key('btn_avatar_${preset.id}'),
                onTap: () => setState(() => _selectedId = preset.id),
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? activeColor.withValues(alpha: 0.2)
                        : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? activeColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    preset.icon,
                    size: 26,
                    color: isSelected ? activeColor : theme.colorScheme.onSurface,
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Background Color Palette Selector
          Text(
            LocaleKeys.profile_avatar_color.tr(),
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: AvatarPreferences.colorPalette.map((color) {
              final isSelected = color.toARGB32() == _selectedColor;
              return GestureDetector(
                onTap: () => setState(() => _selectedColor = color.toARGB32()),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? Colors.white : Colors.transparent,
                      width: 3,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: color.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 2,
                            )
                          ]
                        : null,
                  ),
                  child: isSelected
                      ? const Icon(Icons.check_rounded, size: 20, color: Colors.white)
                      : null,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 22),

          // Save Button
          ElevatedButton.icon(
            key: const Key('btn_save_avatar'),
            icon: const Icon(Icons.check_rounded),
            label: Text(
              LocaleKeys.profile_save_avatar.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: activeColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {
              widget.onAvatarSaved(_selectedId, _selectedColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
