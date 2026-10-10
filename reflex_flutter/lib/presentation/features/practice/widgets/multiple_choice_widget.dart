import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Multiple Choice Options widget supporting selection before submission
/// and rich option rationales ('Why this option is right/wrong') after submission.
class MultipleChoiceWidget extends StatelessWidget {
  final List<QuestionOptionView> options;
  final int? selectedOptionId;
  final ValueChanged<int>? onOptionSelected;
  final bool isSubmitted;
  final List<OptionExplanationView>? explanations;

  const MultipleChoiceWidget({
    super.key,
    required this.options,
    required this.selectedOptionId,
    required this.onOptionSelected,
    this.isSubmitted = false,
    this.explanations,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (int i = 0; i < options.length; i++) ...[
          _OptionTile(
            option: options[i],
            index: i,
            isSelected: selectedOptionId == options[i].id,
            isSubmitted: isSubmitted,
            onSelect: isSubmitted ? null : () => onOptionSelected?.call(options[i].id),
            explanation: _findExplanation(options[i].id),
          ),
          if (i < options.length - 1) const SizedBox(height: 12),
        ],
      ],
    );
  }

  OptionExplanationView? _findExplanation(int optionId) {
    if (explanations == null) return null;
    try {
      return explanations!.firstWhere((e) => e.optionId == optionId);
    } catch (_) {
      return null;
    }
  }
}

class _OptionTile extends StatelessWidget {
  final QuestionOptionView option;
  final int index;
  final bool isSelected;
  final bool isSubmitted;
  final VoidCallback? onSelect;
  final OptionExplanationView? explanation;

  const _OptionTile({
    required this.option,
    required this.index,
    required this.isSelected,
    required this.isSubmitted,
    required this.onSelect,
    required this.explanation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color borderColor;
    Color tileBg;
    Widget trailingIcon = const SizedBox.shrink();

    if (isSubmitted && explanation != null) {
      if (explanation!.isCorrect) {
        borderColor = ReflexColors.chromaticGreen;
        tileBg = ReflexColors.chromaticGreen.withValues(alpha: isDark ? 0.15 : 0.08);
        trailingIcon = const Icon(Icons.check_circle, color: ReflexColors.chromaticGreen);
      } else if (isSelected) {
        borderColor = ReflexColors.chromaticRed;
        tileBg = ReflexColors.chromaticRed.withValues(alpha: isDark ? 0.15 : 0.08);
        trailingIcon = const Icon(Icons.cancel, color: ReflexColors.chromaticRed);
      } else {
        borderColor = isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder;
        tileBg = Colors.transparent;
      }
    } else if (isSelected) {
      borderColor = ReflexColors.primary;
      tileBg = ReflexColors.primary.withValues(alpha: isDark ? 0.18 : 0.08);
      trailingIcon = const Icon(Icons.radio_button_checked, color: ReflexColors.primary);
    } else {
      borderColor = isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder;
      tileBg = Colors.transparent;
      trailingIcon = Icon(
        Icons.radio_button_off,
        color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
      );
    }

    final letter = String.fromCharCode(65 + index); // A, B, C, D...

    return InkWell(
      onTap: onSelect,
      borderRadius: BorderRadius.circular(14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: tileBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: borderColor,
            width: isSelected || (isSubmitted && explanation?.isCorrect == true) ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ReflexColors.primary
                        : (isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? ReflexColors.primary : borderColor,
                    ),
                  ),
                  child: Text(
                    letter,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    option.text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                trailingIcon,
              ],
            ),
            if (isSubmitted && explanation?.explanation != null && explanation!.explanation!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsetsDirectional.all(10),
                decoration: BoxDecoration(
                  color: (explanation!.isCorrect ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow)
                      .withValues(alpha: isDark ? 0.1 : 0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (explanation!.isCorrect ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow)
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      explanation!.isCorrect ? Icons.lightbulb_outline : Icons.info_outline,
                      size: 18,
                      color: explanation!.isCorrect ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            explanation!.isCorrect
                                ? LocaleKeys.practice_why_right.tr()
                                : LocaleKeys.practice_why_wrong.tr(),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: explanation!.isCorrect ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            explanation!.explanation!,
                            style: theme.textTheme.bodySmall?.copyWith(
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
