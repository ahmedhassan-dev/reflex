import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Widget displayed when all due cards in the review session have been completed.
class DeckCompleteWidget extends StatelessWidget {
  final VoidCallback? onRefresh;

  const DeckCompleteWidget({
    super.key,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ReflexColors.chromaticGreen.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.emoji_events_rounded,
                size: 56,
                color: ReflexColors.chromaticGreen,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              LocaleKeys.practice_deck_complete_title.tr(),
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.practice_deck_complete_subtitle.tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? ReflexColors.textSecondaryDark
                    : ReflexColors.textSecondaryLight,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            // if (onRefresh != null) ...[
            //   const SizedBox(height: 28),
            //   OutlinedButton.icon(
            //     onPressed: onRefresh,
            //     icon: const Icon(Icons.refresh),
            //     label: Text(LocaleKeys.retry.tr()),
            //     style: OutlinedButton.styleFrom(
            //       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
