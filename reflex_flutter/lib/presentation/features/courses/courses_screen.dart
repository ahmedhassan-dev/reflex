import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../data/repositories/practice_repository.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/courses_controller.dart';
import 'widgets/course_card_widget.dart';

/// Screen allowing students to explore all available public and private courses,
/// request enrollment subscriptions, and start practicing.
class CoursesScreen extends StatefulWidget {
  final IPracticeRepository? repositoryOverride;
  final ValueChanged<int>? onStartPractice;

  const CoursesScreen({
    super.key,
    this.repositoryOverride,
    this.onStartPractice,
  });

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends CoursesController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final items = filteredCourses;

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.courses_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: LocaleKeys.retry.tr(),
            onPressed: isLoading ? null : loadCourses,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: loadCourses,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildHeaderBanner(theme, isDark),
            const SizedBox(height: 16),
            _buildFilterChips(),
            const SizedBox(height: 16),
            if (isLoading && courses.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (errorMessage != null && courses.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    children: [
                      Text(errorMessage!, style: theme.textTheme.bodyMedium),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: loadCourses,
                        child: Text(LocaleKeys.retry.tr()),
                      ),
                    ],
                  ),
                ),
              )
            else if (items.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Text(
                    LocaleKeys.courses_no_courses.tr(),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                    ),
                  ),
                ),
              )
            else
              ...items.map((course) {
                return CourseCardWidget(
                  key: ValueKey('course_card_${course.id}'),
                  course: course,
                  subscriptionStatus: subscriptionStatuses[course.id],
                  isRequesting: requestingCourses.contains(course.id),
                  onStartPractice: () {
                    if (course.id != null) {
                      widget.onStartPractice?.call(course.id!);
                    }
                  },
                  onRequestSubscription: () => requestSubscription(course),
                  onRefreshStatus: () {
                    if (course.id != null) {
                      refreshCourseStatus(course.id!);
                    }
                  },
                );
              }),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner(ThemeData theme, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: ReflexColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.explore_rounded,
                    color: ReflexColors.primary, size: 22),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.courses_title.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      LocaleKeys.courses_subtitle.tr(),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip(
            label: LocaleKeys.courses_filter_all.tr(),
            filterKey: 'all',
            icon: Icons.apps_rounded,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: LocaleKeys.courses_filter_public.tr(),
            filterKey: 'public',
            icon: Icons.public_rounded,
          ),
          const SizedBox(width: 8),
          _buildFilterChip(
            label: LocaleKeys.courses_filter_private.tr(),
            filterKey: 'private',
            icon: Icons.lock_outline_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required String filterKey,
    required IconData icon,
  }) {
    final isSelected = selectedFilter == filterKey;
    return ChoiceChip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => setFilter(filterKey),
    );
  }
}
