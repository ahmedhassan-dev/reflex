import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'course_card_action_widget.dart';

/// Card displaying course details, public/private accessibility status,
/// and instant subscription request or start-practice action triggers.
class CourseCardWidget extends StatelessWidget {
  final Course course;
  final SubscriptionStatus? subscriptionStatus;
  final bool isRequesting;
  final VoidCallback onStartPractice;
  final VoidCallback onRequestSubscription;
  final VoidCallback onRefreshStatus;

  const CourseCardWidget({
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPublic = course.isPublic ?? true;
    final isAccepted = subscriptionStatus == SubscriptionStatus.accepted;
    final isPending = subscriptionStatus == SubscriptionStatus.pending;

    final borderColor = isPublic
        ? ReflexColors.chromaticGreen.withValues(alpha: 0.3)
        : (isAccepted
            ? ReflexColors.chromaticGreen.withValues(alpha: 0.3)
            : (isPending
                ? ReflexColors.chromaticYellow.withValues(alpha: 0.4)
                : (isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder)));

    final VoidCallback? cardTapAction = (isPublic || isAccepted)
        ? onStartPractice
        : (isPending ? null : onRequestSubscription);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: cardTapAction,
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: ReflexColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    course.subject.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: ReflexColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              _buildVisibilityBadge(),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            course.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          if (course.teacherName != null && course.teacherName!.isNotEmpty) ...[
            const SizedBox(height: 6),
            Row(
              children: [
                const Icon(Icons.person_outline_rounded,
                    size: 15, color: ReflexColors.textSecondaryLight),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    LocaleKeys.questions_admin_teacher_label.tr(args: [course.teacherName!]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (course.topics != null && course.topics!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: course.topics!.map((t) {
                return Chip(
                  label: Text(t, style: const TextStyle(fontSize: 11)),
                  backgroundColor: isDark ? Colors.white10 : Colors.grey[200],
                  visualDensity: VisualDensity.compact,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 14),
            CourseCardActionWidget(
              course: course,
              subscriptionStatus: subscriptionStatus,
              isRequesting: isRequesting,
              onStartPractice: onStartPractice,
              onRequestSubscription: onRequestSubscription,
              onRefreshStatus: onRefreshStatus,
            ),
          ],
        ),
      ),
    ),
  ),
);
  }

  Widget _buildVisibilityBadge() {
    final isPublic = course.isPublic ?? true;
    final isAccepted = subscriptionStatus == SubscriptionStatus.accepted;
    final isPending = subscriptionStatus == SubscriptionStatus.pending;

    if (isPublic) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: ReflexColors.chromaticGreen.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: ReflexColors.chromaticGreen.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.public_rounded, size: 12, color: ReflexColors.chromaticGreen),
            const SizedBox(width: 4),
            Text(
              LocaleKeys.courses_filter_public.tr(),
              style: const TextStyle(
                color: ReflexColors.chromaticGreen,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      );
    }

    final color = isAccepted
        ? ReflexColors.chromaticGreen
        : (isPending ? ReflexColors.chromaticYellow : ReflexColors.chromaticYellow);
    final icon = isAccepted
        ? Icons.verified_rounded
        : (isPending ? Icons.hourglass_top_rounded : Icons.lock_outline_rounded);
    final label = isAccepted
        ? LocaleKeys.courses_enrolled.tr()
        : (isPending
            ? LocaleKeys.subscriptions_status_pending.tr()
            : LocaleKeys.courses_filter_private.tr());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
