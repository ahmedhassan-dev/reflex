import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Table displaying individual student progress with clean first-try solves.
class StudentCohortTable extends StatelessWidget {
  final List<StudentProgress> students;

  const StudentCohortTable({
    super.key,
    required this.students,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (students.isEmpty) {
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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStatePropertyAll(
              isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
            ),
            columns: [
              DataColumn(label: Text(LocaleKeys.dashboard_student_name.tr(), style: const TextStyle(fontWeight: FontWeight.bold))),
              DataColumn(label: Text(LocaleKeys.dashboard_mastered_count.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text(LocaleKeys.dashboard_clean_first_try.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
              DataColumn(label: Text(LocaleKeys.dashboard_avg_latency.tr(), style: const TextStyle(fontWeight: FontWeight.bold)), numeric: true),
            ],
            rows: [
              for (final s in students)
                DataRow(
                  cells: [
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 12,
                            backgroundColor: ReflexColors.primary.withValues(alpha: 0.2),
                            child: Text(
                              s.displayName.isNotEmpty ? s.displayName[0] : 'S',
                              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: ReflexColors.primary),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(s.displayName),
                        ],
                      ),
                    ),
                    DataCell(Text('${s.solvedCount}')),
                    DataCell(
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: ReflexColors.chromaticGreen.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          '${s.cleanFirstTryCount}',
                          style: const TextStyle(
                            color: ReflexColors.chromaticGreen,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text('${s.avgResponseMs.round()}ms')),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
