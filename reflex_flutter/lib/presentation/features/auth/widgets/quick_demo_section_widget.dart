import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class QuickDemoSectionWidget extends StatelessWidget {
  final VoidCallback onEnterAsStudent;
  final VoidCallback? onEnterAsStudentBob;
  final VoidCallback? onEnterAsStudentCharlie;
  final VoidCallback onEnterAsTeacher;
  final VoidCallback? onEnterAsTeacherSarah;

  const QuickDemoSectionWidget({
    super.key,
    required this.onEnterAsStudent,
    this.onEnterAsStudentBob,
    this.onEnterAsStudentCharlie,
    required this.onEnterAsTeacher,
    this.onEnterAsTeacherSarah,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.auth_demo_hint.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 16),
        // Student Demo Accounts Section
        Row(
          children: [
            const Icon(Icons.school_rounded, size: 16, color: ReflexColors.primary),
            const SizedBox(width: 6),
            Text(
              LocaleKeys.auth_role_student.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: ReflexColors.primary),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildDemoChip(
              key: const Key('btn_quick_student'),
              icon: Icons.person_outline_rounded,
              label: LocaleKeys.auth_demo_student_alice.tr(),
              color: ReflexColors.primary,
              onTap: onEnterAsStudent,
            ),
            if (onEnterAsStudentBob != null)
              _buildDemoChip(
                key: const Key('btn_quick_student_bob'),
                icon: Icons.person_outline_rounded,
                label: LocaleKeys.auth_demo_student_bob.tr(),
                color: ReflexColors.primary,
                onTap: onEnterAsStudentBob!,
              ),
            if (onEnterAsStudentCharlie != null)
              _buildDemoChip(
                key: const Key('btn_quick_student_charlie'),
                icon: Icons.person_outline_rounded,
                label: LocaleKeys.auth_demo_student_charlie.tr(),
                color: ReflexColors.primary,
                onTap: onEnterAsStudentCharlie!,
              ),
          ],
        ),
        const SizedBox(height: 18),
        // Teacher Demo Accounts Section
        Row(
          children: [
            const Icon(Icons.co_present_rounded, size: 16, color: ReflexColors.accent),
            const SizedBox(width: 6),
            Text(
              LocaleKeys.auth_role_teacher.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: ReflexColors.accent),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildDemoChip(
              key: const Key('btn_quick_teacher'),
              icon: Icons.badge_outlined,
              label: LocaleKeys.auth_demo_teacher_hassan.tr(),
              color: ReflexColors.accent,
              onTap: onEnterAsTeacher,
            ),
            if (onEnterAsTeacherSarah != null)
              _buildDemoChip(
                key: const Key('btn_quick_teacher_sarah'),
                icon: Icons.badge_outlined,
                label: LocaleKeys.auth_demo_teacher_sarah.tr(),
                color: ReflexColors.accent,
                onTap: onEnterAsTeacherSarah!,
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildDemoChip({
    required Key key,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return ActionChip(
      key: key,
      avatar: Icon(icon, size: 16, color: color),
      label: Text(
        label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
      ),
      side: BorderSide(color: color.withValues(alpha: 0.5), width: 1.2),
      backgroundColor: color.withValues(alpha: 0.08),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onTap,
    );
  }
}
