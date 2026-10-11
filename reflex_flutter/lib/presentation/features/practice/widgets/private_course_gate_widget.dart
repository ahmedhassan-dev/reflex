import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class PrivateCourseGateWidget extends StatelessWidget {
  final SubscriptionStatus? subscriptionStatus;
  final bool isRequestingSubscription;
  final VoidCallback onRequestSubscription;
  final VoidCallback onRefresh;

  const PrivateCourseGateWidget({
    super.key,
    required this.subscriptionStatus,
    required this.isRequestingSubscription,
    required this.onRequestSubscription,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPending = subscriptionStatus == SubscriptionStatus.pending;
    final isRejected = subscriptionStatus == SubscriptionStatus.rejected;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPending
              ? ReflexColors.chromaticYellow.withValues(alpha: 0.4)
              : isRejected
                  ? ReflexColors.chromaticRed.withValues(alpha: 0.4)
                  : isDark
                      ? ReflexColors.darkBorder
                      : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isRejected
                      ? ReflexColors.chromaticRed
                      : isPending
                          ? ReflexColors.chromaticYellow
                          : ReflexColors.primary)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRejected
                  ? Icons.block_rounded
                  : isPending
                      ? Icons.hourglass_top_rounded
                      : Icons.lock_outline_rounded,
              size: 40,
              color: isRejected
                  ? ReflexColors.chromaticRed
                  : isPending
                      ? ReflexColors.chromaticYellow
                      : ReflexColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isRejected
                ? LocaleKeys.subscriptions_status_rejected.tr()
                : isPending
                    ? LocaleKeys.subscriptions_pending_approval.tr()
                    : LocaleKeys.subscriptions_access_denied.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.subscriptions_request_access_desc.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (isPending) ...[
            OutlinedButton.icon(
              key: const Key('btn_refresh_subscription_status'),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(LocaleKeys.retry.tr()),
              style: OutlinedButton.styleFrom(
                foregroundColor: ReflexColors.chromaticYellow,
                side: const BorderSide(color: ReflexColors.chromaticYellow),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: onRefresh,
            ),
          ] else ...[
            ElevatedButton.icon(
              key: const Key('btn_request_subscription'),
              icon: isRequestingSubscription
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send_rounded, size: 18),
              label: Text(LocaleKeys.subscriptions_request_access.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: ReflexColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: isRequestingSubscription ? null : onRequestSubscription,
            ),
          ],
        ],
      ),
    );
  }
}
