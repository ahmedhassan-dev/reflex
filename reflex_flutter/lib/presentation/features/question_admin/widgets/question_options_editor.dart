import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

class QuestionOptionsEditor extends StatelessWidget {
  final List<Map<String, dynamic>> options;
  final VoidCallback onAddOption;
  final ValueChanged<int> onRemoveOption;
  final void Function(int index, bool isCorrect) onToggleCorrect;

  const QuestionOptionsEditor({
    super.key,
    required this.options,
    required this.onAddOption,
    required this.onRemoveOption,
    required this.onToggleCorrect,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              LocaleKeys.questions_admin_options_label.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextButton.icon(
              icon: const Icon(Icons.add, size: 16),
              label: Text(LocaleKeys.questions_admin_add_option_button.tr()),
              onPressed: onAddOption,
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
                color: isCorr
                    ? ReflexColors.chromaticGreen
                    : Colors.grey.withValues(alpha: 0.3),
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
                      onChanged: (val) => onToggleCorrect(idx, val ?? false),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textC,
                        decoration: InputDecoration(
                          hintText:
                              '${LocaleKeys.questions_admin_option_text_hint.tr()} #${idx + 1}',
                          isDense: true,
                        ),
                      ),
                    ),
                    if (options.length > 2)
                      IconButton(
                        icon: const Icon(Icons.delete_outline_rounded,
                            color: Colors.redAccent, size: 20),
                        onPressed: () => onRemoveOption(idx),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: expC,
                  decoration: InputDecoration(
                    hintText: LocaleKeys
                        .questions_admin_option_explanation_hint
                        .tr(),
                    isDense: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  ),
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
