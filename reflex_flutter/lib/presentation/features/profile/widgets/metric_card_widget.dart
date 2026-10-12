import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

/// Clean chromatic metric card for student mastery milestones.
class MetricCardWidget extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const MetricCardWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 14),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark
                  ? ReflexColors.textSecondaryDark
                  : ReflexColors.textSecondaryLight,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
