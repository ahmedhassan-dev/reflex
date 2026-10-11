import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class CourseSubscriptionsSheet extends StatefulWidget {
  final Course? selectedCourse;
  final List<CourseSubscriptionView> subscriptions;
  final bool isLoadingSubscriptions;
  final Future<void> Function(int subscriptionId, SubscriptionStatus status)
      onRespondToSubscription;

  const CourseSubscriptionsSheet({
    super.key,
    required this.selectedCourse,
    required this.subscriptions,
    required this.isLoadingSubscriptions,
    required this.onRespondToSubscription,
  });

  static Future<void> show(
    BuildContext context, {
    required Course? selectedCourse,
    required List<CourseSubscriptionView> subscriptions,
    required bool isLoadingSubscriptions,
    required Future<void> Function(
            int subscriptionId, SubscriptionStatus status)
        onRespondToSubscription,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CourseSubscriptionsSheet(
        selectedCourse: selectedCourse,
        subscriptions: subscriptions,
        isLoadingSubscriptions: isLoadingSubscriptions,
        onRespondToSubscription: onRespondToSubscription,
      ),
    );
  }

  @override
  State<CourseSubscriptionsSheet> createState() =>
      _CourseSubscriptionsSheetState();
}

class _CourseSubscriptionsSheetState extends State<CourseSubscriptionsSheet> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkBackground : Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.people_alt_rounded,
                      color: ReflexColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.subscriptions_title.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          Text(
            widget.selectedCourse?.title ?? '',
            style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.grey[400] : Colors.grey[600]),
          ),
          const Divider(height: 24),
          Expanded(
            child: widget.isLoadingSubscriptions
                ? const Center(child: CircularProgressIndicator())
                : widget.subscriptions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.person_off_outlined,
                                size: 48,
                                color: Colors.grey.withValues(alpha: 0.5)),
                            const SizedBox(height: 12),
                            Text(
                              LocaleKeys.subscriptions_no_subscriptions.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      )
                    : ListView.separated(
                        itemCount: widget.subscriptions.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final sub = widget.subscriptions[index];
                          final isPending =
                              sub.status == SubscriptionStatus.pending;
                          final isAccepted =
                              sub.status == SubscriptionStatus.accepted;
                          final isRejected =
                              sub.status == SubscriptionStatus.rejected;

                          return Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? ReflexColors.darkCard
                                  : ReflexColors.lightCard,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isPending
                                    ? ReflexColors.chromaticYellow
                                        .withValues(alpha: 0.5)
                                    : isDark
                                        ? ReflexColors.darkBorder
                                        : ReflexColors.lightBorder,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        LocaleKeys.subscriptions_student_label
                                            .tr(args: [sub.studentName]),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                    _buildSubscriptionStatusChip(sub.status),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  LocaleKeys.subscriptions_requested_on.tr(
                                    args: [
                                      sub.requestedAt
                                          .toLocal()
                                          .toString()
                                          .substring(0, 16)
                                    ],
                                  ),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.grey[400]
                                        : Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (!isAccepted)
                                      ElevatedButton.icon(
                                        key: Key('btn_accept_sub_${sub.id}'),
                                        icon: const Icon(
                                            Icons.check_circle_rounded,
                                            size: 16),
                                        label: Text(LocaleKeys
                                            .subscriptions_accept_action
                                            .tr()),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ReflexColors.chromaticGreen,
                                          foregroundColor: Colors.white,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        onPressed: () async {
                                          await widget.onRespondToSubscription(
                                              sub.id,
                                              SubscriptionStatus.accepted);
                                          setState(() {});
                                        },
                                      ),
                                    if (!isAccepted && !isRejected)
                                      const SizedBox(width: 8),
                                    if (!isRejected)
                                      OutlinedButton.icon(
                                        key: Key('btn_reject_sub_${sub.id}'),
                                        icon: const Icon(Icons.cancel_outlined,
                                            size: 16),
                                        label: Text(LocaleKeys
                                            .subscriptions_reject_action
                                            .tr()),
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor:
                                              ReflexColors.chromaticRed,
                                          side: const BorderSide(
                                              color: ReflexColors.chromaticRed),
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14, vertical: 8),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                        ),
                                        onPressed: () async {
                                          await widget.onRespondToSubscription(
                                              sub.id,
                                              SubscriptionStatus.rejected);
                                          setState(() {});
                                        },
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionStatusChip(SubscriptionStatus status) {
    switch (status) {
      case SubscriptionStatus.accepted:
        return Chip(
          label: Text(LocaleKeys.subscriptions_status_accepted.tr(),
              style: const TextStyle(fontSize: 11, color: Colors.white)),
          backgroundColor: ReflexColors.chromaticGreen,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        );
      case SubscriptionStatus.rejected:
        return Chip(
          label: Text(LocaleKeys.subscriptions_status_rejected.tr(),
              style: const TextStyle(fontSize: 11, color: Colors.white)),
          backgroundColor: ReflexColors.chromaticRed,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        );
      case SubscriptionStatus.pending:
        return Chip(
          label: Text(LocaleKeys.subscriptions_status_pending.tr(),
              style: const TextStyle(fontSize: 11, color: Colors.white)),
          backgroundColor: ReflexColors.chromaticYellow,
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
        );
    }
  }
}
