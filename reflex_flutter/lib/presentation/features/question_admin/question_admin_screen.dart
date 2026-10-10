import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import '../../../data/repositories/question_admin_repository.dart';
import 'controller/question_admin_controller.dart';

/// Screen allowing teachers to browse courses, add new courses, add new questions,
/// and edit concept explanations and hints.
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
  void _openCreateCourseDialog() {
    final titleCtrl = TextEditingController();
    final subjectCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.school_rounded, color: ReflexColors.primary),
            const SizedBox(width: 8),
            Expanded(
              child: Text(LocaleKeys.questions_admin_new_course_dialog_title.tr()),
            ),
          ],
        ),
        content: Column(
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
              controller: titleCtrl,
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
              controller: subjectCtrl,
              decoration: InputDecoration(
                hintText: LocaleKeys.questions_admin_course_subject_hint.tr(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(LocaleKeys.questions_admin_cancel.tr()),
          ),
          ElevatedButton(
            key: const Key('btn_confirm_create_course'),
            style: ElevatedButton.styleFrom(
              backgroundColor: ReflexColors.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final t = titleCtrl.text.trim();
              final s = subjectCtrl.text.trim();
              if (t.isEmpty || s.isEmpty) return;
              Navigator.of(ctx).pop();
              final ok = await createNewCourse(title: t, subject: s);
              if (ok && mounted) {
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
      ),
    );
  }

  void _openCreateQuestionDialog() {
    final promptCtrl = TextEditingController();
    final topicCtrl = TextEditingController();
    final pointsCtrl = TextEditingController(text: '10');
    final timeCtrl = TextEditingController(text: '15');
    final topicNoteCtrl = TextEditingController();
    final helpHintCtrl = TextEditingController();
    final acceptedAnsCtrl = TextEditingController();

    QuestionType selectedType = QuestionType.multipleChoice;

    // Default MCQ options
    final List<Map<String, dynamic>> options = [
      {'text': TextEditingController(), 'isCorrect': true, 'exp': TextEditingController()},
      {'text': TextEditingController(), 'isCorrect': false, 'exp': TextEditingController()},
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (modalCtx, setModalState) {
          final isDark = Theme.of(context).brightness == Brightness.dark;
          return Container(
            height: MediaQuery.of(context).size.height * 0.88,
            decoration: BoxDecoration(
              color: isDark ? ReflexColors.darkBackground : Colors.white,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              top: 20,
              left: 20,
              right: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.add_task_rounded, color: ReflexColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          LocaleKeys.questions_admin_new_question_dialog_title.tr(),
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Prompt
                        Text(LocaleKeys.questions_admin_prompt_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        TextField(
                          key: const Key('input_question_prompt'),
                          controller: promptCtrl,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.questions_admin_prompt_hint.tr(),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Topic
                        Text(LocaleKeys.questions_admin_topic_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        TextField(
                          key: const Key('input_question_topic'),
                          controller: topicCtrl,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.questions_admin_topic_hint.tr(),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Question Type & Timing Row
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.questions_admin_question_type_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  DropdownButtonFormField<QuestionType>(
                                    key: const Key('dropdown_question_type'),
                                    initialValue: selectedType,
                                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                                    items: [
                                      DropdownMenuItem(
                                        value: QuestionType.multipleChoice,
                                        child: Text(LocaleKeys.questions_admin_type_multiple_choice.tr()),
                                      ),
                                      DropdownMenuItem(
                                        value: QuestionType.textInput,
                                        child: Text(LocaleKeys.questions_admin_type_text_input.tr()),
                                      ),
                                    ],
                                    onChanged: (val) {
                                      if (val != null) {
                                        setModalState(() {
                                          selectedType = val;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 80,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.questions_admin_points_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: pointsCtrl,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            SizedBox(
                              width: 90,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(LocaleKeys.questions_admin_expected_seconds_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: timeCtrl,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Options or Accepted Answers
                        if (selectedType == QuestionType.multipleChoice) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(LocaleKeys.questions_admin_options_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                              TextButton.icon(
                                icon: const Icon(Icons.add, size: 16),
                                label: Text(LocaleKeys.questions_admin_add_option_button.tr()),
                                onPressed: () {
                                  setModalState(() {
                                    options.add({
                                      'text': TextEditingController(),
                                      'isCorrect': false,
                                      'exp': TextEditingController(),
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                          ...List.generate(options.length, (idx) {
                            final opt = options[idx];
                            final textC = opt['text'] as TextEditingController;
                            final expC = opt['exp'] as TextEditingController;
                            final isCorr = opt['isCorrect'] as bool;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: isCorr ? ReflexColors.chromaticGreen : Colors.grey.withValues(alpha: 0.3),
                                  width: isCorr ? 1.5 : 1,
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: isCorr,
                                        activeColor: ReflexColors.chromaticGreen,
                                        onChanged: (val) {
                                          setModalState(() {
                                            opt['isCorrect'] = val ?? false;
                                          });
                                        },
                                      ),
                                      Expanded(
                                        child: TextField(
                                          controller: textC,
                                          decoration: InputDecoration(
                                            hintText: '${LocaleKeys.questions_admin_option_text_hint.tr()} #${idx + 1}',
                                            isDense: true,
                                          ),
                                        ),
                                      ),
                                      if (options.length > 2)
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                                          onPressed: () {
                                            setModalState(() {
                                              options.removeAt(idx);
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 4),
                                  TextField(
                                    controller: expC,
                                    decoration: InputDecoration(
                                      hintText: LocaleKeys.questions_admin_option_explanation_hint.tr(),
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            );
                          }),
                        ] else ...[
                          Text(LocaleKeys.questions_admin_accepted_answers_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 4),
                          TextField(
                            key: const Key('input_accepted_answers'),
                            controller: acceptedAnsCtrl,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.questions_admin_accepted_answers_hint.tr(),
                            ),
                          ),
                        ],
                        const SizedBox(height: 16),

                        // Topic Note
                        Text(LocaleKeys.questions_admin_topic_note_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: topicNoteCtrl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.questions_admin_topic_note_hint.tr(),
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Help Hint
                        Text(LocaleKeys.questions_admin_help_hint_label.tr(), style: const TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        TextField(
                          controller: helpHintCtrl,
                          maxLines: 2,
                          decoration: InputDecoration(
                            hintText: LocaleKeys.questions_admin_help_hint_hint.tr(),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  key: const Key('btn_confirm_create_question'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ReflexColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    final prompt = promptCtrl.text.trim();
                    final topic = topicCtrl.text.trim();
                    if (prompt.isEmpty || topic.isEmpty) return;

                    List<CreateOptionInput>? optionInputs;
                    List<String>? acceptedAnswersList;

                    if (selectedType == QuestionType.multipleChoice) {
                      optionInputs = options.map((opt) {
                        final tc = opt['text'] as TextEditingController;
                        final ec = opt['exp'] as TextEditingController;
                        final isC = opt['isCorrect'] as bool;
                        return CreateOptionInput(
                          text: tc.text.trim(),
                          isCorrect: isC,
                          explanation: ec.text.trim().isEmpty ? null : ec.text.trim(),
                        );
                      }).where((o) => o.text.isNotEmpty).toList();
                    } else {
                      acceptedAnswersList = acceptedAnsCtrl.text
                          .split(',')
                          .map((s) => s.trim())
                          .where((s) => s.isNotEmpty)
                          .toList();
                    }

                    final input = CreateQuestionInput(
                      courseId: courseId,
                      prompt: prompt,
                      topic: topic,
                      questionType: selectedType,
                      points: int.tryParse(pointsCtrl.text) ?? 10,
                      expectedSeconds: int.tryParse(timeCtrl.text) ?? 15,
                      topicNote: topicNoteCtrl.text.trim().isEmpty ? null : topicNoteCtrl.text.trim(),
                      helpHint: helpHintCtrl.text.trim().isEmpty ? null : helpHintCtrl.text.trim(),
                      options: optionInputs,
                      acceptedAnswers: acceptedAnswersList,
                    );

                    Navigator.of(ctx).pop();
                    final ok = await createNewQuestion(input);
                    if (ok && mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(LocaleKeys.questions_admin_question_created_success.tr()),
                          backgroundColor: ReflexColors.chromaticGreen,
                        ),
                      );
                    }
                  },
                  child: Text(
                    LocaleKeys.questions_admin_create_question_action.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsetsDirectional.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Course Selector & Action Header ────────────────────────
                  Container(
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
                            const Icon(Icons.menu_book_rounded, color: ReflexColors.primary, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              LocaleKeys.questions_admin_course_label.tr(),
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
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
                                      initialValue: courses.any((c) => c.id == courseId) ? courseId : courses.first.id,
                                      isExpanded: true,
                                      decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                      ),
                                      items: courses
                                          .map((c) => DropdownMenuItem<int>(
                                                value: c.id,
                                                child: Text('${c.title} (${c.subject})'),
                                              ))
                                          .toList(),
                                      onChanged: (newId) {
                                        if (newId != null) {
                                          final found = courses.where((c) => c.id == newId).firstOrNull;
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
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              ),
                              onPressed: _openCreateCourseDialog,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Questions Header with New Question button ─────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.questions_admin_title.tr(),
                          style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton.icon(
                        key: const Key('btn_add_question'),
                        icon: const Icon(Icons.add_rounded, size: 18),
                        label: Text(LocaleKeys.questions_admin_add_question_button.tr()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ReflexColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: _openCreateQuestionDialog,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  if (questions.isEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(28),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder),
                      ),
                      child: Column(
                        children: [
                          Icon(Icons.quiz_outlined, size: 48, color: Colors.grey.withValues(alpha: 0.5)),
                          const SizedBox(height: 12),
                          const Text(
                            'No questions in this course yet.\nTap "+ New Question" above to add the first problem!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    // ── Question Dropdown ────────────────────────────────────
                    Text(
                      LocaleKeys.questions_admin_select_question.tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.textTheme.bodySmall?.color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<int>(
                      key: const Key('dropdown_question_selector'),
                      initialValue: selectedQuestion?.id,
                      isExpanded: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      items: questions
                          .map((q) => DropdownMenuItem<int>(
                                value: q.id,
                                child: Text(
                                  '#${q.position} [${q.topic}] ${q.prompt}',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ))
                          .toList(),
                      onChanged: (newId) {
                        if (newId != null) {
                          final found = questions.where((q) => q.id == newId).firstOrNull;
                          if (found != null) {
                            selectQuestion(found);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),

                    if (selectedQuestion != null) ...[
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
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: ReflexColors.primary),
      ),
    );
  }
}
