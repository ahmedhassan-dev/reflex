import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class TopicQuestionCard extends StatelessWidget {
  final QuestionInsight question;
  final int index;

  const TopicQuestionCard({
    super.key,
    required this.question,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: ReflexColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '#${index + 1}',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: ReflexColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  question.prompt,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: [
              _MetricBadge(
                icon: Icons.check_circle_rounded,
                label:
                    '${LocaleKeys.dashboard_clean_solves.tr()}: ${question.cleanSolveCount}',
                color: ReflexColors.chromaticGreen,
              ),
              _MetricBadge(
                icon: Icons.flag_rounded,
                label:
                    '${LocaleKeys.dashboard_first_try_rate.tr()}: ${(question.firstTryRate * 100).round()}%',
                color: ReflexColors.primary,
              ),
              _MetricBadge(
                icon: Icons.speed_rounded,
                label: '${(question.avgResponseMs / 1000).toStringAsFixed(1)}s',
                color: ReflexColors.chromaticYellow,
              ),
              _MetricBadge(
                icon: Icons.repeat_rounded,
                label:
                    '${LocaleKeys.dashboard_total_attempts.tr()}: ${question.attemptCount}',
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _MetricBadge({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
