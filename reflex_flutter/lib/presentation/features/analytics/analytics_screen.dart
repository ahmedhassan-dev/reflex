import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../data/repositories/question_admin_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import '../question_admin/widgets/course_subscriptions_sheet.dart';
import 'controller/analytics_controller.dart';
import 'widgets/question_insights_table.dart';
import 'widgets/student_cohort_table.dart';
import 'widgets/topic_mastery_bars.dart';

/// Teacher Analytics Dashboard Screen.
/// Provides deep cohort visibility across Topic Mastery with embedded question insights,
/// Student Subscriptions management, Atomic Question Counters, and Individual Student Solves.
class AnalyticsScreen extends StatefulWidget {
  final IAnalyticsRepository? repositoryOverride;
  final IQuestionAdminRepository? questionRepositoryOverride;

  const AnalyticsScreen({
    super.key,
    this.repositoryOverride,
    this.questionRepositoryOverride,
  });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends AnalyticsController {
  Future<void> _openSubscriptionsSheet() async {
    await loadSubscriptions();
    if (!mounted) return;
    CourseSubscriptionsSheet.show(
      context,
      selectedCourse: selectedCourse,
      subscriptions: subscriptions,
      isLoadingSubscriptions: isLoadingSubscriptions,
      onRespondToSubscription: respondToSubscription,
    );
  }

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
    final pendingCount = subscriptions
        .where((s) => s.status == SubscriptionStatus.pending)
        .length;
    final enrolledCount = subscriptions
        .where((s) => s.status == SubscriptionStatus.accepted)
        .length;
    final activeStudentCount = enrolledCount > 0 ? enrolledCount : students.length;

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
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(width: 6),
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
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      key: const Key('btn_analytics_manage_subscriptions'),
                      icon: Badge(
                        isLabelVisible: pendingCount > 0,
                        label: Text('$pendingCount'),
                        backgroundColor: ReflexColors.chromaticYellow,
                        child: const Icon(Icons.people_alt_rounded, size: 16),
                      ),
                      label: Text(
                        LocaleKeys.questions_admin_subscriptions_button.tr(),
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ReflexColors.primary,
                        foregroundColor: Colors.white,
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: _openSubscriptionsSheet,
                    ),
                  ],
                ),
              ),

            // Pending Subscriptions Banner Alert
            if (pendingCount > 0)
              Container(
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: ReflexColors.chromaticYellow.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ReflexColors.chromaticYellow.withValues(alpha: 0.4)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.notification_important_rounded,
                        color: ReflexColors.chromaticYellow, size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        LocaleKeys.dashboard_pending_approval_notice
                            .tr(args: ['$pendingCount']),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    ),
                    ElevatedButton(
                      key: const Key('btn_analytics_review_subscriptions'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ReflexColors.chromaticYellow,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        visualDensity: VisualDensity.compact,
                      ),
                      onPressed: _openSubscriptionsSheet,
                      child: Text(
                        LocaleKeys.questions_admin_subscriptions_button.tr(),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),

            // Tabs Content
            Expanded(
              child: TabBarView(
                children: [
                  RefreshIndicator(
                    onRefresh: loadSummary,
                    child: ListView(
                      padding: const EdgeInsetsDirectional.all(16),
                      children: [
                        TopicMasteryBars(
                          masteryList: mastery,
                          questions: questions,
                          subscribedCount: activeStudentCount,
                        ),
                      ],
                    ),
                  ),
                  RefreshIndicator(
                    onRefresh: loadSummary,
                    child: ListView(
                      padding: const EdgeInsetsDirectional.all(16),
                      children: [
                        QuestionInsightsTable(questions: questions),
                      ],
                    ),
                  ),
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
