import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class AdminCourseHeader extends StatelessWidget {
  final List<Course> courses;
  final Course? selectedCourse;
  final int courseId;
  final List<CourseSubscriptionView> subscriptions;
  final ValueChanged<Course> onCourseSelected;
  final VoidCallback onAddCourse;
  final VoidCallback onToggleVisibility;
  final VoidCallback onManageSubscriptions;

  const AdminCourseHeader({
    super.key,
    required this.courses,
    required this.selectedCourse,
    required this.courseId,
    required this.subscriptions,
    required this.onCourseSelected,
    required this.onAddCourse,
    required this.onToggleVisibility,
    required this.onManageSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsetsDirectional.all(14),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.menu_book_rounded,
                  color: ReflexColors.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.questions_admin_course_label.tr(),
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: courses.isEmpty
                    ? Text(selectedCourse?.title ?? 'Default Course')
                    : DropdownButtonFormField<int>(
                        key: const Key('dropdown_course_selector'),
                        initialValue: courses.any((c) => c.id == courseId)
                            ? courseId
                            : courses.first.id,
                        isExpanded: true,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        items: courses
                            .map((c) => DropdownMenuItem<int>(
                                  value: c.id,
                                  child: Text('${c.title} (${c.subject})'),
                                ))
                            .toList(),
                        onChanged: (newId) {
                          if (newId != null) {
                            final found = courses
                                .where((c) => c.id == newId)
                                .firstOrNull;
                            if (found != null) {
                              onCourseSelected(found);
                            }
                          }
                        },
                      ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                key: const Key('btn_add_course'),
                icon: const Icon(Icons.add, size: 16),
                label: Text(LocaleKeys.questions_admin_add_course_button.tr()),
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onAddCourse,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              ActionChip(
                key: const Key('chip_course_visibility_toggle'),
                avatar: Icon(
                  (selectedCourse?.isPublic ?? true)
                      ? Icons.public_rounded
                      : Icons.lock_outline_rounded,
                  size: 16,
                  color: (selectedCourse?.isPublic ?? true)
                      ? ReflexColors.chromaticGreen
                      : ReflexColors.chromaticYellow,
                ),
                label: Text(
                  (selectedCourse?.isPublic ?? true)
                      ? LocaleKeys.questions_admin_visibility_public.tr()
                      : LocaleKeys.questions_admin_visibility_private.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: (selectedCourse?.isPublic ?? true)
                        ? ReflexColors.chromaticGreen
                        : ReflexColors.chromaticYellow,
                  ),
                ),
                tooltip: (selectedCourse?.isPublic ?? true)
                    ? LocaleKeys.questions_admin_make_private.tr()
                    : LocaleKeys.questions_admin_make_public.tr(),
                backgroundColor: ((selectedCourse?.isPublic ?? true)
                        ? ReflexColors.chromaticGreen
                        : ReflexColors.chromaticYellow)
                    .withValues(alpha: 0.1),
                side: BorderSide(
                  color: ((selectedCourse?.isPublic ?? true)
                          ? ReflexColors.chromaticGreen
                          : ReflexColors.chromaticYellow)
                      .withValues(alpha: 0.3),
                ),
                onPressed: onToggleVisibility,
              ),
              if (selectedCourse?.teacherName != null)
                Chip(
                  key: const Key('chip_course_teacher'),
                  avatar: const Icon(Icons.person_rounded,
                      size: 14, color: ReflexColors.primary),
                  label: Text(
                    LocaleKeys.questions_admin_teacher_label
                        .tr(args: [selectedCourse!.teacherName!]),
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                  backgroundColor: ReflexColors.primary.withValues(alpha: 0.08),
                  side: BorderSide(
                      color: ReflexColors.primary.withValues(alpha: 0.2)),
                  visualDensity: VisualDensity.compact,
                ),
              if (selectedCourse != null &&
                  (selectedCourse!.isPublic == false)) ...[
                Builder(
                  builder: (context) {
                    final pendingCount = subscriptions
                        .where((s) => s.status == SubscriptionStatus.pending)
                        .length;
                    return ElevatedButton.icon(
                      key: const Key('btn_manage_subscriptions'),
                      icon: Badge(
                        isLabelVisible: pendingCount > 0,
                        label: Text('$pendingCount'),
                        backgroundColor: ReflexColors.chromaticYellow,
                        child: const Icon(Icons.people_outline_rounded,
                            size: 16),
                      ),
                      label: Text(
                        LocaleKeys.questions_admin_subscriptions_button.tr(),
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ReflexColors.primary,
                        foregroundColor: Colors.white,
                        visualDensity: VisualDensity.compact,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: onManageSubscriptions,
                    );
                  },
                ),
              ],
            ],
          ),
          if (selectedCourse?.topics != null &&
              selectedCourse!.topics!.isNotEmpty) ...[
            const SizedBox(height: 10),
            Wrap(
              spacing: 6,
              runSpacing: 4,
              children: selectedCourse!.topics!
                  .map(
                    (topic) => Chip(
                      key: Key('chip_course_topic_$topic'),
                      avatar: const Icon(Icons.tag_rounded,
                          size: 14, color: ReflexColors.primary),
                      label: Text(topic, style: const TextStyle(fontSize: 12)),
                      backgroundColor:
                          ReflexColors.primary.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                            color: ReflexColors.primary.withValues(alpha: 0.2)),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
          ],
        ],
      ),
    );
  }
}
