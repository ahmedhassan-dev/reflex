import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class QuickDemoSectionWidget extends StatelessWidget {
  final VoidCallback onEnterAsStudent;
  final VoidCallback onEnterAsTeacher;

  const QuickDemoSectionWidget({
    super.key,
    required this.onEnterAsStudent,
    required this.onEnterAsTeacher,
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
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                key: const Key('btn_quick_student'),
                icon: const Icon(Icons.school_outlined, size: 18),
                label: Text(
                  LocaleKeys.auth_demo_student_alice.tr(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ReflexColors.primary, width: 1.5),
                  foregroundColor: ReflexColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onEnterAsStudent,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                key: const Key('btn_quick_teacher'),
                icon: const Icon(Icons.co_present_outlined, size: 18),
                label: Text(
                  LocaleKeys.auth_demo_teacher_hassan.tr(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ReflexColors.accent, width: 1.5),
                  foregroundColor: ReflexColors.accent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: onEnterAsTeacher,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
