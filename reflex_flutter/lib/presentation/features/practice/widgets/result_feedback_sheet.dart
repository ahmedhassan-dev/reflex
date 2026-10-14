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
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: tierColor.withValues(alpha: isDark ? 0.15 : 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: tierColor.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Row 1: Verdict text & Tier icon ───────────────────────
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
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // ── Row 2: Points delta & Total Score badge ───────────────
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: result.points > 0
                      ? tierColor.withValues(alpha: 0.2)
                      : (isDark ? Colors.white10 : Colors.black12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '+${result.points} ${LocaleKeys.practice_points.tr()}',
                  style: TextStyle(
                    color: result.points > 0
                        ? tierColor
                        : (isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              if (result.totalScore != null) ...[
                const SizedBox(width: 8),
                Container(
                  key: const Key('result_total_score_badge'),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ReflexColors.primary.withValues(alpha: isDark ? 0.25 : 0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: ReflexColors.primary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.emoji_events_rounded,
                        color: ReflexColors.primary,
                        size: 14,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${LocaleKeys.practice_total_score.tr()}: ${result.totalScore}',
                        style: const TextStyle(
                          color: ReflexColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
