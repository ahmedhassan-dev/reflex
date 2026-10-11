import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Feedback banner showing the verdict, reflex tier, points, and latency.
class ResultFeedbackWidget extends StatelessWidget {
  final SubmitResult result;

  const ResultFeedbackWidget({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color tierColor;
    String tierLabel;
    IconData tierIcon;

    switch (result.reflexTier) {
      case ReflexTier.greenMastered:
        tierColor = ReflexColors.chromaticGreen;
        tierLabel = LocaleKeys.practice_mastered.tr();
        tierIcon = Icons.bolt_rounded;
        break;
      case ReflexTier.yellowDeveloping:
        tierColor = ReflexColors.chromaticYellow;
        tierLabel = LocaleKeys.practice_developing.tr();
        tierIcon = Icons.warning_amber_rounded;
        break;
      case ReflexTier.redNeedsWork:
        tierColor = ReflexColors.chromaticRed;
        tierLabel = LocaleKeys.practice_needs_work.tr();
        tierIcon = Icons.close_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsetsDirectional.all(16),
      decoration: BoxDecoration(
        color: tierColor.withValues(alpha: isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tierColor.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: tierColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(tierIcon, color: tierColor, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  tierLabel,
                  style: TextStyle(
                    color: tierColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: tierColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '+${result.points} ${LocaleKeys.practice_points.tr()}',
                  style: TextStyle(
                    color: tierColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                LocaleKeys.practice_latency.tr(
                  args: [(result.responseMs / 1000).toStringAsFixed(1)],
                ),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                ),
              ),
              Text(
                'Next: ${result.nextDueAt.toLocal().toString().split(' ')[0]}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
