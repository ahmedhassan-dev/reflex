import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'question_options_editor.dart';
import 'question_prompt_and_type_fields.dart';

class CreateQuestionBottomSheet extends StatefulWidget {
  final int courseId;
  final Future<bool> Function(CreateQuestionInput input) onCreateQuestion;

  const CreateQuestionBottomSheet({
    super.key,
    required this.courseId,
    required this.onCreateQuestion,
  });

  static Future<void> show(
    BuildContext context, {
    required int courseId,
    required Future<bool> Function(CreateQuestionInput input) onCreateQuestion,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => CreateQuestionBottomSheet(
        courseId: courseId,
        onCreateQuestion: onCreateQuestion,
      ),
    );
  }

  @override
  State<CreateQuestionBottomSheet> createState() =>
      _CreateQuestionBottomSheetState();
}

class _CreateQuestionBottomSheetState extends State<CreateQuestionBottomSheet> {
  final _promptCtrl = TextEditingController();
  final _topicCtrl = TextEditingController();
  final _pointsCtrl = TextEditingController(text: '10');
  final _timeCtrl = TextEditingController(text: '15');
  final _topicNoteCtrl = TextEditingController();
  final _helpHintCtrl = TextEditingController();
  final _acceptedAnsCtrl = TextEditingController();

  QuestionType _selectedType = QuestionType.multipleChoice;

  final List<Map<String, dynamic>> _options = [
    {
      'text': TextEditingController(),
      'isCorrect': true,
      'exp': TextEditingController(),
    },
    {
      'text': TextEditingController(),
      'isCorrect': false,
      'exp': TextEditingController(),
    },
  ];

  @override
  void dispose() {
    _promptCtrl.dispose();
    _topicCtrl.dispose();
    _pointsCtrl.dispose();
    _timeCtrl.dispose();
    _topicNoteCtrl.dispose();
    _helpHintCtrl.dispose();
    _acceptedAnsCtrl.dispose();
    for (final opt in _options) {
      (opt['text'] as TextEditingController).dispose();
      (opt['exp'] as TextEditingController).dispose();
    }
    super.dispose();
  }

  Future<void> _submit() async {
    final prompt = _promptCtrl.text.trim();
    final topic = _topicCtrl.text.trim();
    if (prompt.isEmpty || topic.isEmpty) return;

    List<CreateOptionInput>? optionInputs;
    List<String>? acceptedAnswersList;

    if (_selectedType == QuestionType.multipleChoice) {
      optionInputs = _options
          .map((opt) {
            final tc = opt['text'] as TextEditingController;
            final ec = opt['exp'] as TextEditingController;
            final isC = opt['isCorrect'] as bool;
            return CreateOptionInput(
              text: tc.text.trim(),
              isCorrect: isC,
              explanation: ec.text.trim().isEmpty ? null : ec.text.trim(),
            );
          })
          .where((o) => o.text.isNotEmpty)
          .toList();
    } else {
      acceptedAnswersList = _acceptedAnsCtrl.text
          .split(',')
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
    }

    final input = CreateQuestionInput(
      courseId: widget.courseId,
      prompt: prompt,
      topic: topic,
      questionType: _selectedType,
      points: int.tryParse(_pointsCtrl.text) ?? 10,
      expectedSeconds: int.tryParse(_timeCtrl.text) ?? 15,
      topicNote:
          _topicNoteCtrl.text.trim().isEmpty ? null : _topicNoteCtrl.text.trim(),
      helpHint:
          _helpHintCtrl.text.trim().isEmpty ? null : _helpHintCtrl.text.trim(),
      options: optionInputs,
      acceptedAnswers: acceptedAnswersList,
    );

    Navigator.of(context).pop();
    final ok = await widget.onCreateQuestion(input);
    if (ok && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text(LocaleKeys.questions_admin_question_created_success.tr()),
          backgroundColor: ReflexColors.chromaticGreen,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  const Icon(Icons.add_task_rounded,
                      color: ReflexColors.primary),
                  const SizedBox(width: 8),
                  Text(
                    LocaleKeys.questions_admin_new_question_dialog_title.tr(),
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuestionPromptAndTypeFields(
                    promptCtrl: _promptCtrl,
                    topicCtrl: _topicCtrl,
                    pointsCtrl: _pointsCtrl,
                    timeCtrl: _timeCtrl,
                    selectedType: _selectedType,
                    onTypeChanged: (type) => setState(() => _selectedType = type),
                  ),
                  const SizedBox(height: 16),
                  if (_selectedType == QuestionType.multipleChoice) ...[
                    QuestionOptionsEditor(
                      options: _options,
                      onAddOption: () {
                        setState(() {
                          _options.add({
                            'text': TextEditingController(),
                            'isCorrect': false,
                            'exp': TextEditingController(),
                          });
                        });
                      },
                      onRemoveOption: (idx) {
                        setState(() {
                          _options.removeAt(idx);
                        });
                      },
                      onToggleCorrect: (idx, val) {
                        setState(() {
                          _options[idx]['isCorrect'] = val;
                        });
                      },
                    ),
                  ] else ...[
                    Text(
                      LocaleKeys.questions_admin_accepted_answers_label.tr(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    TextField(
                      key: const Key('input_accepted_answers'),
                      controller: _acceptedAnsCtrl,
                      decoration: InputDecoration(
                        hintText: LocaleKeys
                            .questions_admin_accepted_answers_hint
                            .tr(),
                      ),
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    LocaleKeys.questions_admin_topic_note_label.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _topicNoteCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:
                          LocaleKeys.questions_admin_topic_note_hint.tr(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    LocaleKeys.questions_admin_help_hint_label.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    controller: _helpHintCtrl,
                    maxLines: 2,
                    decoration: InputDecoration(
                      hintText:
                          LocaleKeys.questions_admin_help_hint_hint.tr(),
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
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: _submit,
            child: Text(
              LocaleKeys.questions_admin_create_question_action.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
