import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Topic mastery breakdown progress bars.
class TopicMasteryBars extends StatelessWidget {
  final List<TopicMastery> masteryList;

  const TopicMasteryBars({
    super.key,
    required this.masteryList,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (masteryList.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            LocaleKeys.dashboard_no_cohort_data.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final item in masteryList) ...[
          _TopicBarItem(item: item),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _TopicBarItem extends StatelessWidget {
  final TopicMastery item;

  const _TopicBarItem({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final pct = (item.masteryRate * 100).round();
    Color barColor;
    if (item.masteryRate >= 0.8) {
      barColor = ReflexColors.chromaticGreen;
    } else if (item.masteryRate >= 0.5) {
      barColor = ReflexColors.chromaticYellow;
    } else {
      barColor = ReflexColors.chromaticRed;
    }

    return Container(
      padding: const EdgeInsetsDirectional.all(14),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  item.topic,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                '$pct%',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: barColor,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: item.masteryRate.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: isDark
                  ? ReflexColors.darkSurface
                  : ReflexColors.lightBorder.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(barColor),
            ),
          ),
        ],
      ),
    );
  }
}
