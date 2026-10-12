import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/student_progress_controller.dart';
import 'widgets/metric_card_widget.dart';
import 'widgets/student_course_selector_widget.dart';

/// Student self-progress and mastery metrics profile screen.
class StudentProgressScreen extends StatefulWidget {
  final IAnalyticsRepository? repositoryOverride;
  final String? userName;

  const StudentProgressScreen({
    super.key,
    this.repositoryOverride,
    this.userName,
  });

  @override
  State<StudentProgressScreen> createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends StudentProgressController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isLoading && progress == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (errorMessage != null && progress == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(errorMessage!, style: TextStyle(color: theme.colorScheme.error)),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: loadCoursesAndProgress,
              child: Text(LocaleKeys.retry.tr()),
            ),
          ],
        ),
      );
    }

    final p = progress;
    final displayName = (widget.userName != null && widget.userName!.isNotEmpty)
        ? widget.userName!
        : (p?.displayName != null && p!.displayName.isNotEmpty ? p.displayName : 'Learner');
    final cleanSolves = p?.cleanFirstTryCount ?? 0;
    final solvedCount = p?.solvedCount ?? 0;
    final avgSpeedSeconds = ((p?.avgResponseMs ?? 0) / 1000).toStringAsFixed(1);
    final streakDays = p?.studyStreakDays ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: LocaleKeys.retry.tr(),
            onPressed: isLoading ? null : loadProgress,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadCoursesAndProgress,
        child: ListView(
          padding: const EdgeInsetsDirectional.all(20),
          children: [
            // ── Student Header Card ──────────────────────────────────────────
            Container(
              padding: const EdgeInsetsDirectional.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    ReflexColors.primary,
                    ReflexColors.accent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: ReflexColors.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.white.withValues(alpha: 0.2),
                    child: const Icon(Icons.person_rounded, size: 36, color: Colors.white),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          displayName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          LocaleKeys.profile_summary_subtitle.tr(),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.85),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    key: const Key('student_progress_total_score_badge'),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.stars_rounded,
                              color: ReflexColors.chromaticYellow,
                              size: 18,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${p?.totalScore ?? 0}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          LocaleKeys.practice_total_score.tr(),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.9),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ── Course Selector ──────────────────────────────────────────────
            StudentCourseSelectorWidget(
              courses: courses,
              selectedCourse: selectedCourse,
              onCourseSelected: selectCourse,
            ),

            // ── Key Metrics Grid ─────────────────────────────────────────────
            Text(
              LocaleKeys.profile_summary_title.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Row(
              children: [
                Expanded(
                  child: MetricCardWidget(
                    title: LocaleKeys.profile_clean_first_try.tr(),
                    value: '$cleanSolves',
                    icon: Icons.verified_rounded,
                    color: ReflexColors.chromaticGreen,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCardWidget(
                    title: LocaleKeys.profile_cards_mastered.tr(),
                    value: '$solvedCount',
                    icon: Icons.check_circle_outline_rounded,
                    color: ReflexColors.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: MetricCardWidget(
                    title: LocaleKeys.profile_avg_latency.tr(),
                    value: '${avgSpeedSeconds}s',
                    icon: Icons.speed_rounded,
                    color: ReflexColors.chromaticYellow,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: MetricCardWidget(
                    title: LocaleKeys.profile_study_streak.tr(),
                    value: '$streakDays ${LocaleKeys.profile_days.tr()}',
                    icon: Icons.local_fire_department_rounded,
                    color: Colors.deepOrange,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
