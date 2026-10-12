import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Clean course selector dropdown for student progress screen.
class StudentCourseSelectorWidget extends StatelessWidget {
  final List<Course> courses;
  final Course? selectedCourse;
  final ValueChanged<Course> onCourseSelected;

  const StudentCourseSelectorWidget({
    super.key,
    required this.courses,
    required this.selectedCourse,
    required this.onCourseSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (courses.isEmpty && selectedCourse == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: ReflexColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.school_rounded, size: 20, color: ReflexColors.primary),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Course>(
                key: const Key('student_progress_course_selector'),
                isExpanded: true,
                value: selectedCourse,
                icon: const Icon(Icons.arrow_drop_down_rounded),
                hint: Text(
                  LocaleKeys.dashboard_select_course.tr(),
                  style: theme.textTheme.bodyMedium,
                ),
                items: courses.map((c) {
                  final isPub = c.isPublic ?? true;
                  return DropdownMenuItem<Course>(
                    value: c,
                    child: Row(
                      children: [
                        Flexible(
                          child: Text(
                            '${c.title} (${c.subject})',
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: (isPub
                                    ? ReflexColors.chromaticGreen
                                    : ReflexColors.chromaticYellow)
                                .withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            isPub
                                ? LocaleKeys.questions_admin_visibility_public.tr()
                                : LocaleKeys.questions_admin_visibility_private.tr(),
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: isPub
                                  ? ReflexColors.chromaticGreen
                                  : ReflexColors.chromaticYellow,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (course) {
                  if (course != null) {
                    onCourseSelected(course);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
