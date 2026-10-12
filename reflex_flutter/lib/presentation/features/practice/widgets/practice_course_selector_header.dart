import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class PracticeCourseSelectorHeader extends StatelessWidget {
  final List<Course> courses;
  final Course? selectedCourse;
  final int courseId;
  final ValueChanged<Course> onCourseSelected;
  final bool lockCourse;

  const PracticeCourseSelectorHeader({
    super.key,
    required this.courses,
    required this.selectedCourse,
    required this.courseId,
    required this.onCourseSelected,
    this.lockCourse = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (courses.isEmpty && selectedCourse == null) {
      return const SizedBox.shrink();
    }

    final isPublic = selectedCourse?.isPublic ?? true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: (!lockCourse && courses.length > 1)
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          key: const Key('practice_course_selector'),
                          isDense: true,
                          isExpanded: true,
                          value: courses.any((c) => c.id == courseId)
                              ? courseId
                              : courses.first.id,
                          items: courses.map((c) {
                            return DropdownMenuItem<int>(
                              value: c.id,
                              child: Row(
                                children: [
                                  Icon(
                                    (c.isPublic ?? true)
                                        ? Icons.menu_book_rounded
                                        : Icons.lock_outline_rounded,
                                    size: 16,
                                    color: (c.isPublic ?? true)
                                        ? ReflexColors.primary
                                        : ReflexColors.chromaticYellow,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '${c.title} (${c.subject})',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold, fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newId) {
                            if (newId != null) {
                              final found =
                                  courses.where((c) => c.id == newId).firstOrNull;
                              if (found != null) {
                                onCourseSelected(found);
                              }
                            }
                          },
                        ),
                      )
                    : Row(
                        children: [
                          Icon(
                            isPublic
                                ? Icons.menu_book_rounded
                                : Icons.lock_outline_rounded,
                            size: 18,
                            color: isPublic
                                ? ReflexColors.primary
                                : ReflexColors.chromaticYellow,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedCourse != null
                                  ? '${selectedCourse!.title} (${selectedCourse!.subject})'
                                  : 'Reflex Practice',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPublic
                          ? ReflexColors.chromaticGreen
                          : ReflexColors.chromaticYellow)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (isPublic
                            ? ReflexColors.chromaticGreen
                            : ReflexColors.chromaticYellow)
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPublic ? Icons.public_rounded : Icons.lock_outline_rounded,
                      size: 12,
                      color: isPublic
                          ? ReflexColors.chromaticGreen
                          : ReflexColors.chromaticYellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isPublic
                          ? LocaleKeys.questions_admin_visibility_public.tr()
                          : LocaleKeys.questions_admin_visibility_private.tr(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isPublic
                            ? ReflexColors.chromaticGreen
                            : ReflexColors.chromaticYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (selectedCourse?.teacherName != null) ...[
            const SizedBox(height: 6),
            Text(
              LocaleKeys.questions_admin_teacher_label
                  .tr(args: [selectedCourse!.teacherName!]),
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
