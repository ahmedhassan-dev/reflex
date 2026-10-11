import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/question_admin_controller.dart';

class AdminQuestionEditor extends StatelessWidget {
  final Question selectedQuestion;
  final TextEditingController topicNoteController;
  final TextEditingController helpHintController;
  final bool isSaving;
  final String? successMessage;
  final String? errorMessage;
  final VoidCallback onSave;

  const AdminQuestionEditor({
    super.key,
    required this.selectedQuestion,
    required this.topicNoteController,
    required this.helpHintController,
    required this.isSaving,
    required this.successMessage,
    required this.errorMessage,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Question Metadata & Atomic Counters Card ─────────────
        Container(
          padding: const EdgeInsetsDirectional.all(16),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Chip(
                    label: Text(selectedQuestion.topic),
                    padding: EdgeInsets.zero,
                  ),
                  Text(
                    '${selectedQuestion.expectedSeconds}s target',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                selectedQuestion.prompt,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _Badge(label: '${selectedQuestion.attemptCount} Attempts'),
                  _Badge(label: '${selectedQuestion.solvedStudentCount} Solved'),
                  _Badge(label: '${selectedQuestion.cleanSolveCount} Clean Solves'),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // ── Topic Note Field (with char counter) ──────────────────
        Text(
          LocaleKeys.questions_admin_topic_note_label.tr(),
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          key: const Key('topic_note_input'),
          controller: topicNoteController,
          maxLines: 4,
          maxLength: QuestionAdminController.maxCharLimit,
          decoration: InputDecoration(
            hintText: LocaleKeys.questions_admin_topic_note_hint.tr(),
          ),
        ),
        const SizedBox(height: 16),

        // ── Help Hint Field ──────────────────────────────────────
        Text(
          LocaleKeys.questions_admin_help_hint_label.tr(),
          style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextField(
          key: const Key('help_hint_input'),
          controller: helpHintController,
          maxLines: 3,
          maxLength: QuestionAdminController.maxCharLimit,
          decoration: InputDecoration(
            hintText: LocaleKeys.questions_admin_help_hint_hint.tr(),
          ),
        ),
        const SizedBox(height: 20),

        // ── Save Button ──────────────────────────────────────────
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            key: const Key('save_question_button'),
            onPressed: isSaving ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: ReflexColors.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: isSaving
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Text(
                    LocaleKeys.questions_admin_save_changes.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
          ),
        ),

        if (successMessage != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsetsDirectional.all(12),
            decoration: BoxDecoration(
              color: ReflexColors.chromaticGreen.withValues(alpha: isDark ? 0.2 : 0.1),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ReflexColors.chromaticGreen.withValues(alpha: 0.4)),
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle_rounded, color: ReflexColors.chromaticGreen, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    LocaleKeys.questions_admin_saved_successfully.tr(),
                    style: const TextStyle(
                      color: ReflexColors.chromaticGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],

        if (errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            errorMessage!,
            style: TextStyle(color: theme.colorScheme.error),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  const _Badge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: ReflexColors.primary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ReflexColors.primary),
      ),
    );
  }
}
