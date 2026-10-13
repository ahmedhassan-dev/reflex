import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Representation of a customizable avatar preset.
class AvatarOption {
  final String id;
  final IconData icon;
  final String label;

  const AvatarOption({
    required this.id,
    required this.icon,
    required this.label,
  });
}

/// Local persistence and preset provider for user profile avatar customization.
class AvatarPreferences {
  static const String keyAvatarId = 'reflex_saved_avatar_id';
  static const String keyAvatarColor = 'reflex_saved_avatar_color';

  static const List<AvatarOption> presets = [
    AvatarOption(id: 'student', icon: Icons.school_rounded, label: 'Student'),
    AvatarOption(id: 'rocket', icon: Icons.rocket_launch_rounded, label: 'Explorer'),
    AvatarOption(id: 'bolt', icon: Icons.bolt_rounded, label: 'Speedster'),
    AvatarOption(id: 'brain', icon: Icons.psychology_rounded, label: 'Mastermind'),
    AvatarOption(id: 'scientist', icon: Icons.science_rounded, label: 'Scientist'),
    AvatarOption(id: 'star', icon: Icons.auto_awesome_rounded, label: 'Achiever'),
    AvatarOption(id: 'lion', icon: Icons.cruelty_free_rounded, label: 'Brave'),
    AvatarOption(id: 'palette', icon: Icons.palette_rounded, label: 'Creative'),
    AvatarOption(id: 'trophy', icon: Icons.emoji_events_rounded, label: 'Champion'),
    AvatarOption(id: 'owl', icon: Icons.visibility_rounded, label: 'Wise'),
  ];

  static const List<Color> colorPalette = [
    Color(0xFF10B981), // Emerald
    Color(0xFF6366F1), // Indigo
    Color(0xFFF59E0B), // Amber
    Color(0xFFF43F5E), // Rose
    Color(0xFF0EA5E9), // Sky
    Color(0xFF8B5CF6), // Purple
  ];

  static Future<String?> getSavedAvatarId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyAvatarId);
  }

  static Future<int?> getSavedAvatarColor() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(keyAvatarColor);
  }

  static Future<void> saveAvatar(String id, int colorValue) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyAvatarId, id);
    await prefs.setInt(keyAvatarColor, colorValue);
  }

  static AvatarOption getAvatarOption(String? id) {
    if (id == null) return presets.first;
    return presets.firstWhere(
      (opt) => opt.id == id,
      orElse: () => presets.first,
    );
  }
}
