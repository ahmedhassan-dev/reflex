import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/analytics_controller.dart';
import 'widgets/question_insights_table.dart';
import 'widgets/student_cohort_table.dart';
import 'widgets/topic_mastery_bars.dart';

/// Teacher Analytics Dashboard Screen.
///
/// Provides deep cohort visibility across Topic Mastery with embedded question insights,
/// Atomic Question Counters, and Individual Student Solves.
class AnalyticsScreen extends StatefulWidget {
  final IAnalyticsRepository? repositoryOverride;

  const AnalyticsScreen({
    super.key,
    this.repositoryOverride,
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends AnalyticsController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isLoading && summary == null && courses.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null && summary == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadCoursesAndSummary,
              child: Text(LocaleKeys.retry.tr()),
            ),
          ],
        ),
      );
    }

    final data = summary;
    final mastery = data?.mastery ?? [];
    final questions = data?.questions ?? [];
    final students = data?.students ?? [];

    final activeCourse = selectedCourse;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(LocaleKeys.dashboard_title.tr()),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh_rounded),
              tooltip: LocaleKeys.dashboard_refresh.tr(),
              onPressed: isLoading ? null : loadSummary,
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: LocaleKeys.dashboard_cohort_mastery.tr(),
                icon: const Icon(Icons.bar_chart_rounded),
              ),
              Tab(
                text: LocaleKeys.dashboard_questions.tr(),
                icon: const Icon(Icons.quiz_rounded),
              ),
              Tab(
                text: LocaleKeys.dashboard_students.tr(),
                icon: const Icon(Icons.people_rounded),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            // Course Selector Header Banner
            if (courses.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
                  border: Border(
                    bottom: BorderSide(
                      color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.school_rounded, size: 20, color: ReflexColors.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<Course>(
                          isExpanded: true,
                          value: selectedCourse,
                          icon: const Icon(Icons.arrow_drop_down_rounded),
                          items: courses.map((c) {
                            final cIsPub = c.isPublic ?? true;
                            return DropdownMenuItem<Course>(
                              value: c,
                              child: Row(
                                children: [
                                  Text(
                                    c.title,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: cIsPub
                                          ? ReflexColors.chromaticGreen.withValues(alpha: 0.15)
                                          : ReflexColors.chromaticYellow.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      cIsPub
                                          ? LocaleKeys.questions_admin_visibility_public.tr()
                                          : LocaleKeys.questions_admin_visibility_private.tr(),
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: cIsPub
                                            ? ReflexColors.chromaticGreen
                                            : ReflexColors.chromaticYellow,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (c) {
                            if (c != null) onSelectCourse(c);
                          },
                        ),
                      ),
                    ),
                    if (activeCourse?.teacherName != null) ...[
                      const SizedBox(width: 8),
                      Text(
                        LocaleKeys.questions_admin_teacher_label.tr(args: [activeCourse!.teacherName!]),
                        style: TextStyle(
                          fontSize: 12,
                          color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
                        ),
                      ),
                    ],
                  ],
                ),
              ),

            // Tabs Content
            Expanded(
              child: TabBarView(
                children: [
                  // Tab 1: Topic Mastery (with embedded question insights!)
                  RefreshIndicator(
                    onRefresh: loadSummary,
                    child: ListView(
                      padding: const EdgeInsetsDirectional.all(16),
                      children: [
                        TopicMasteryBars(
                          masteryList: mastery,
                          questions: questions,
                        ),
                      ],
                    ),
                  ),

                  // Tab 2: Question Insights Table
                  RefreshIndicator(
                    onRefresh: loadSummary,
                    child: ListView(
                      padding: const EdgeInsetsDirectional.all(16),
                      children: [
                        QuestionInsightsTable(questions: questions),
                      ],
                    ),
                  ),

                  // Tab 3: Student Cohort Table
                  RefreshIndicator(
                    onRefresh: loadSummary,
                    child: ListView(
                      padding: const EdgeInsetsDirectional.all(16),
                      children: [
                        StudentCohortTable(students: students),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
