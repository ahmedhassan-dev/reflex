import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class CreateCourseDialog extends StatefulWidget {
  final Future<bool> Function({
    required String title,
    required String subject,
    List<String>? topics,
    required bool isPublic,
  }) onCreateCourse;

  const CreateCourseDialog({
    super.key,
    required this.onCreateCourse,
  });

  static Future<void> show(
    BuildContext context, {
    required Future<bool> Function({
      required String title,
      required String subject,
      List<String>? topics,
      required bool isPublic,
    }) onCreateCourse,
  }) {
    return showDialog(
      context: context,
      builder: (ctx) => CreateCourseDialog(onCreateCourse: onCreateCourse),
    );
  }

  @override
  State<CreateCourseDialog> createState() => _CreateCourseDialogState();
}

class _CreateCourseDialogState extends State<CreateCourseDialog> {
  final _titleCtrl = TextEditingController();
  final _subjectCtrl = TextEditingController();
  final _topicCtrl = TextEditingController();
  final List<String> _topics = [];
  bool _isPublic = true;

  @override
  void dispose() {
    _titleCtrl.dispose();
    _subjectCtrl.dispose();
    _topicCtrl.dispose();
    super.dispose();
  }

  void _addTopic() {
    final t = _topicCtrl.text.trim();
    if (t.isNotEmpty && !_topics.contains(t)) {
      setState(() {
        _topics.add(t);
        _topicCtrl.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.school_rounded, color: ReflexColors.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(LocaleKeys.questions_admin_new_course_dialog_title.tr()),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.questions_admin_course_title_label.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            TextField(
              key: const Key('input_new_course_title'),
              controller: _titleCtrl,
              decoration: InputDecoration(
                hintText: LocaleKeys.questions_admin_course_title_hint.tr(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.questions_admin_course_subject_label.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            TextField(
              key: const Key('input_new_course_subject'),
              controller: _subjectCtrl,
              decoration: InputDecoration(
                hintText: LocaleKeys.questions_admin_course_subject_hint.tr(),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.questions_admin_course_visibility_label.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Material(
              color: ReflexColors.primary.withValues(alpha: 0.05),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: ReflexColors.primary.withValues(alpha: 0.2)),
              ),
              child: SwitchListTile(
                key: const Key('switch_course_visibility'),
                value: _isPublic,
                activeThumbColor: ReflexColors.chromaticGreen,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Row(
                  children: [
                    Icon(
                      _isPublic ? Icons.public : Icons.lock_outline_rounded,
                      size: 18,
                      color: _isPublic
                          ? ReflexColors.chromaticGreen
                          : ReflexColors.chromaticYellow,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isPublic
                          ? LocaleKeys.questions_admin_visibility_public.tr()
                          : LocaleKeys.questions_admin_visibility_private.tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: _isPublic
                            ? ReflexColors.chromaticGreen
                            : ReflexColors.chromaticYellow,
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  _isPublic
                      ? LocaleKeys.questions_admin_visibility_public_desc.tr()
                      : LocaleKeys.questions_admin_visibility_private_desc.tr(),
                  style: const TextStyle(fontSize: 11),
                ),
                onChanged: (val) {
                  setState(() {
                    _isPublic = val;
                  });
                },
              ),
            ),
            const SizedBox(height: 12),
            Text(
              LocaleKeys.questions_admin_course_topics_label.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    key: const Key('input_new_course_topic'),
                    controller: _topicCtrl,
                    decoration: InputDecoration(
                      hintText: LocaleKeys.questions_admin_course_topics_hint.tr(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addTopic(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filledTonal(
                  key: const Key('btn_add_topic_to_course'),
                  icon: const Icon(Icons.add, size: 18),
                  onPressed: _addTopic,
                ),
              ],
            ),
            if (_topics.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                runSpacing: 4,
                children: [
                  for (int i = 0; i < _topics.length; i++)
                    Chip(
                      key: Key('chip_dialog_topic_${_topics[i]}'),
                      label: Text(_topics[i], style: const TextStyle(fontSize: 12)),
                      deleteIcon: const Icon(Icons.close, size: 14),
                      onDeleted: () {
                        setState(() {
                          _topics.removeAt(i);
                        });
                      },
                      backgroundColor: ReflexColors.primary.withValues(alpha: 0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: ReflexColors.primary.withValues(alpha: 0.3)),
                      ),
                      visualDensity: VisualDensity.compact,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(LocaleKeys.questions_admin_cancel.tr()),
        ),
        ElevatedButton(
          key: const Key('btn_confirm_create_course'),
          style: ElevatedButton.styleFrom(
            backgroundColor: ReflexColors.primary,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            final t = _titleCtrl.text.trim();
            final s = _subjectCtrl.text.trim();
            if (t.isEmpty || s.isEmpty) return;
            Navigator.of(context).pop();
            final ok = await widget.onCreateCourse(
              title: t,
              subject: s,
              topics: _topics.isNotEmpty ? _topics : null,
              isPublic: _isPublic,
            );
            if (ok && context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(LocaleKeys.questions_admin_course_created_success.tr()),
                  backgroundColor: ReflexColors.chromaticGreen,
                ),
              );
            }
          },
          child: Text(LocaleKeys.questions_admin_create_course_action.tr()),
        ),
      ],
    );
  }
}
