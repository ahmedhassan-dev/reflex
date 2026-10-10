import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import 'controller/analytics_controller.dart';
import 'widgets/question_insights_table.dart';
import 'widgets/student_cohort_table.dart';
import 'widgets/topic_mastery_bars.dart';

/// Teacher Analytics Dashboard Screen.
///
/// Provides deep cohort visibility across Topic Mastery,
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

    if (isLoading && summary == null) {
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
              onPressed: loadSummary,
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
              Tab(text: LocaleKeys.dashboard_cohort_mastery.tr(), icon: const Icon(Icons.bar_chart_rounded)),
              Tab(text: LocaleKeys.dashboard_questions.tr(), icon: const Icon(Icons.quiz_rounded)),
              Tab(text: LocaleKeys.dashboard_students.tr(), icon: const Icon(Icons.people_rounded)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // Tab 1: Topic Mastery
            RefreshIndicator(
              onRefresh: loadSummary,
              child: ListView(
                padding: const EdgeInsetsDirectional.all(16),
                children: [
                  TopicMasteryBars(masteryList: mastery),
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
    );
  }
}
