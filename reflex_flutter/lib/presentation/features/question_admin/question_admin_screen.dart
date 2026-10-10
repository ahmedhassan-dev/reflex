import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/question_admin_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/question_admin_controller.dart';

/// Screen allowing teachers to inspect question details, atomic counters,
/// and edit concept topic notes and guided hints.
class QuestionAdminScreen extends StatefulWidget {
  final IQuestionAdminRepository? repositoryOverride;

  const QuestionAdminScreen({
    super.key,
    this.repositoryOverride,
  });

  @override
  State<QuestionAdminScreen> createState() => _QuestionAdminScreenState();
}

class _QuestionAdminScreenState extends QuestionAdminController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isLoading && questions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.questions_admin_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: LocaleKeys.retry.tr(),
            onPressed: isLoading ? null : loadQuestions,
          ),
        ],
      ),
      body: questions.isEmpty
          ? Center(
              child: Text(errorMessage ?? LocaleKeys.no_response_yet.tr()),
            )
          : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Question Selector Dropdown ─────────────────────────────
                  Text(
                    LocaleKeys.questions_admin_select_question.tr(),
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: selectedQuestion?.id,
                        isExpanded: true,
                        items: [
                          for (final q in questions)
                            DropdownMenuItem<int>(
                              value: q.id,
                              child: Text(
                                '#${q.id} [${q.topic}] ${q.prompt}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                        onChanged: (id) {
                          if (id != null) {
                            final target = questions.firstWhere((q) => q.id == id);
                            selectQuestion(target);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (selectedQuestion != null) ...[
                    // ── Question Metadata & Atomic Counters Card ───────────────
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
                                label: Text(selectedQuestion!.topic),
                                padding: EdgeInsets.zero,
                              ),
                              Text(
                                '${selectedQuestion!.expectedSeconds}s target',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            selectedQuestion!.prompt,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Wrap(
                            spacing: 12,
                            runSpacing: 8,
                            children: [
                              _Badge(label: '${selectedQuestion!.attemptCount} Attempts'),
                              _Badge(label: '${selectedQuestion!.solvedStudentCount} Solved'),
                              _Badge(label: '${selectedQuestion!.cleanSolveCount} Clean Solves'),
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
                    ElevatedButton(
                      key: const Key('save_question_button'),
                      onPressed: isSaving ? null : saveChanges,
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
                ],
              ),
            ),
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
