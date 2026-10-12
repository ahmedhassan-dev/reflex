import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'topic_question_card.dart';

/// Topic mastery breakdown progress bars with embedded question insights.
class TopicMasteryBars extends StatelessWidget {
  final List<TopicMastery> masteryList;
  final List<QuestionInsight> questions;

  final int subscribedCount;

  const TopicMasteryBars({
    super.key,
    required this.masteryList,
    this.questions = const [],
    this.subscribedCount = 0,
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
          _TopicBarItem(
            item: item,
            questions: questions.where((q) => q.topic == item.topic).toList(),
            subscribedCount: subscribedCount,
          ),
          const SizedBox(height: 14),
        ],
      ],
    );
  }
}

class _TopicBarItem extends StatefulWidget {
  final TopicMastery item;
  final List<QuestionInsight> questions;
  final int subscribedCount;

  const _TopicBarItem({
    required this.item,
    required this.questions,
    this.subscribedCount = 0,
  });

  @override
  State<_TopicBarItem> createState() => _TopicBarItemState();
}

class _TopicBarItemState extends State<_TopicBarItem> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.questions.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final normalizedRate = widget.item.masteryRate > 1.0
        ? widget.item.masteryRate / 100.0
        : widget.item.masteryRate;
    Color barColor;
    if (normalizedRate >= 0.8) {
      barColor = ReflexColors.chromaticGreen;
    } else if (normalizedRate >= 0.5) {
      barColor = ReflexColors.chromaticYellow;
    } else {
      barColor = ReflexColors.chromaticRed;
    }

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Topic Header & Mastery Bar
          Padding(
            padding: const EdgeInsetsDirectional.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: barColor,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              widget.item.topic,
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: barColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: barColor.withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.people_alt_rounded, size: 14, color: barColor),
                          const SizedBox(width: 5),
                          Text(
                            LocaleKeys.dashboard_students_count
                                .tr(args: ['${widget.subscribedCount}']),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: barColor,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: normalizedRate.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: isDark
                        ? ReflexColors.darkSurface
                        : ReflexColors.lightBorder.withValues(alpha: 0.5),
                    valueColor: AlwaysStoppedAnimation<Color>(barColor),
                  ),
                ),
                const SizedBox(height: 12),
                // Toggle Question Insights button
                InkWell(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Icon(
                          _isExpanded ? Icons.expand_less_rounded : Icons.expand_more_rounded,
                          size: 18,
                          color: ReflexColors.primary,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _isExpanded
                              ? LocaleKeys.dashboard_hide_topic_questions.tr()
                              : LocaleKeys.dashboard_view_topic_questions.tr(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ReflexColors.primary,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            LocaleKeys.dashboard_topic_questions_count.tr(
                              args: [widget.questions.length.toString()],
                            ),
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Embedded Question Insights inside this topic
          if (_isExpanded) ...[
            Divider(
              height: 1,
              color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
            ),
            if (widget.questions.isEmpty)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  LocaleKeys.dashboard_no_cohort_data.tr(),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(12),
                itemCount: widget.questions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, idx) {
                  return TopicQuestionCard(
                    question: widget.questions[idx],
                    index: idx,
                  );
                },
              ),
          ],
        ],
      ),
    );
  }
}
