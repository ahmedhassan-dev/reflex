import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Action triggers (Start Practice, Request Subscription, Pending) for course cards.
class CourseCardActionWidget extends StatelessWidget {
  final Course course;
  final SubscriptionStatus? subscriptionStatus;
  final bool isRequesting;
  final VoidCallback onStartPractice;
  final VoidCallback onRequestSubscription;
  final VoidCallback onRefreshStatus;

  const CourseCardActionWidget({
    super.key,
    required this.course,
    required this.subscriptionStatus,
    required this.isRequesting,
    required this.onStartPractice,
    required this.onRequestSubscription,
    required this.onRefreshStatus,
  });

  @override
  Widget build(BuildContext context) {
    final isPublic = course.isPublic ?? true;
    final isAccepted = subscriptionStatus == SubscriptionStatus.accepted;
    final isPending = subscriptionStatus == SubscriptionStatus.pending;
    final isRejected = subscriptionStatus == SubscriptionStatus.rejected;

    if (isPublic || isAccepted) {
      return SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton.icon(
          key: Key('btn_start_practice_${course.id}'),
          icon: const Icon(Icons.play_arrow_rounded, size: 20),
          label: Text(
            LocaleKeys.courses_start_practice.tr(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: ReflexColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: onStartPractice,
        ),
      );
    }

    if (isPending) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: ReflexColors.chromaticYellow.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ReflexColors.chromaticYellow.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.hourglass_top_rounded,
                color: ReflexColors.chromaticYellow, size: 20),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                LocaleKeys.courses_pending_desc.tr(),
                style: const TextStyle(
                  fontSize: 12,
                  color: ReflexColors.chromaticYellow,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.refresh_rounded, size: 18),
              color: ReflexColors.chromaticYellow,
              tooltip: LocaleKeys.retry.tr(),
              onPressed: onRefreshStatus,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Icon(
              isRejected ? Icons.block_rounded : Icons.lock_outline_rounded,
              size: 14,
              color: isRejected ? ReflexColors.chromaticRed : ReflexColors.textSecondaryLight,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                isRejected
                    ? LocaleKeys.subscriptions_status_rejected.tr()
                    : LocaleKeys.subscriptions_request_access_desc.tr(),
                style: TextStyle(
                  fontSize: 12,
                  color: isRejected ? ReflexColors.chromaticRed : ReflexColors.textSecondaryLight,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 44,
          child: ElevatedButton.icon(
            key: Key('btn_subscribe_${course.id}'),
            icon: isRequesting
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : const Icon(Icons.lock_open_rounded, size: 18),
            label: Text(
              isRequesting
                  ? LocaleKeys.loading.tr()
                  : LocaleKeys.subscriptions_request_access.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: ReflexColors.accent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: isRequesting ? null : onRequestSubscription,
          ),
        ),
      ],
    );
  }
}
