import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Data table rendering all 6 atomic question counters:
/// attemptCount, attemptedStudentCount, solvedStudentCount, firstTrySolveCount,
/// underTimeSolveCount, cleanSolveCount, plus firstTryRate %.
class QuestionInsightsTable extends StatefulWidget {
  final List<QuestionInsight> questions;

  const QuestionInsightsTable({
    super.key,
    required this.questions,
  });

  @override
  State<QuestionInsightsTable> createState() => _QuestionInsightsTableState();
}

class _QuestionInsightsTableState extends State<QuestionInsightsTable> {
  late final ScrollController _horizontalController;

  @override
  void initState() {
    super.initState();
    _horizontalController = ScrollController();
  }

  @override
  void dispose() {
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (widget.questions.isEmpty) {
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

    return Container(
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            final isMedium = constraints.maxWidth > 600;
            final columnSpacing = isWide ? 32.0 : (isMedium ? 20.0 : 14.0);
            final promptMaxWidth = isWide ? 320.0 : (isMedium ? 240.0 : 180.0);

            return ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                  PointerDeviceKind.trackpad,
                  PointerDeviceKind.stylus,
                },
              ),
              child: Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minWidth: constraints.maxWidth),
                    child: DataTable(
                      columnSpacing: columnSpacing,
                      horizontalMargin: isMedium ? 20.0 : 12.0,
                      headingRowColor: WidgetStatePropertyAll(
                        isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
                      ),
                  columns: [
                    DataColumn(label: Text(LocaleKeys.dashboard_prompt.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(LocaleKeys.dashboard_topic.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(LocaleKeys.dashboard_total_attempts.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    DataColumn(label: Text(LocaleKeys.dashboard_solved_students.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    DataColumn(label: Text(LocaleKeys.dashboard_first_try_solves.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    DataColumn(label: Text(LocaleKeys.dashboard_under_time_solves.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    DataColumn(label: Text(LocaleKeys.dashboard_clean_solves.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                    DataColumn(label: Text(LocaleKeys.dashboard_first_try_rate.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
                  ],
                    rows: [
                      for (final q in widget.questions)
                        DataRow(
                          cells: [
                            DataCell(
                              ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: promptMaxWidth),
                                child: Text(
                                  q.prompt,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DataCell(Text(q.topic)),
                            DataCell(Text('${q.attemptCount}')),
                            DataCell(Text('${q.solvedStudentCount}')),
                            DataCell(Text('${q.firstTrySolveCount}')),
                            DataCell(Text('${q.underTimeSolveCount}')),
                            DataCell(
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: ReflexColors.chromaticGreen.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  '${q.cleanSolveCount}',
                                  style: const TextStyle(
                                    color: ReflexColors.chromaticGreen,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${(q.firstTryRate > 1.0 ? q.firstTryRate : q.firstTryRate * 100).round()}%',
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
  }
}
