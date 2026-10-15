import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';

class QuestionPromptAndTypeFields extends StatelessWidget {
  final TextEditingController promptCtrl;
  final TextEditingController topicCtrl;
  final TextEditingController pointsCtrl;
  final TextEditingController timeCtrl;
  final QuestionType selectedType;
  final ValueChanged<QuestionType> onTypeChanged;

  const QuestionPromptAndTypeFields({
    super.key,
    required this.promptCtrl,
    required this.topicCtrl,
    required this.pointsCtrl,
    required this.timeCtrl,
    required this.selectedType,
    required this.onTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.questions_admin_prompt_label.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextField(
          key: const Key('input_question_prompt'),
          controller: promptCtrl,
          decoration: InputDecoration(
            hintText: LocaleKeys.questions_admin_prompt_hint.tr(),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          LocaleKeys.questions_admin_topic_label.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        TextField(
          key: const Key('input_question_topic'),
          controller: topicCtrl,
          decoration: InputDecoration(
            hintText: LocaleKeys.questions_admin_topic_hint.tr(),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          LocaleKeys.questions_admin_question_type_label.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        DropdownButtonFormField<QuestionType>(
          key: const Key('dropdown_question_type'),
          initialValue: selectedType,
          isExpanded: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: [
            DropdownMenuItem(
              value: QuestionType.multipleChoice,
              child: Text(
                LocaleKeys.questions_admin_type_multiple_choice.tr(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DropdownMenuItem(
              value: QuestionType.textInput,
              child: Text(
                LocaleKeys.questions_admin_type_text_input.tr(),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
          onChanged: (val) {
            if (val != null) onTypeChanged(val);
          },
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.questions_admin_points_label.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    key: const Key('input_question_points'),
                    controller: pointsCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.questions_admin_expected_seconds_label.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  TextField(
                    key: const Key('input_question_time'),
                    controller: timeCtrl,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
