import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import 'chromatic_aura_card.dart';
import 'multiple_choice_widget.dart';
import 'response_timer_widget.dart';
import 'result_feedback_sheet.dart';
import 'topic_note_gate_widget.dart';

class PracticeCardContentWidget extends StatelessWidget {
  final PracticeItem card;
  final SubmitResult? submitResult;
  final bool isSubmitting;
  final int? selectedOptionId;
  final TextEditingController textAnswerController;
  final bool isNoteAcknowledged;
  final bool isRequestingHelp;
  final String? errorMessage;
  final ValueChanged<int> onSelectOption;
  final VoidCallback onSubmitAnswer;
  final VoidCallback onRequestHelp;
  final ValueChanged<bool> onAcknowledgeNote;
  final VoidCallback onContinue;

  const PracticeCardContentWidget({
    super.key,
    required this.card,
    required this.submitResult,
    required this.isSubmitting,
    required this.selectedOptionId,
    required this.textAnswerController,
    required this.isNoteAcknowledged,
    required this.isRequestingHelp,
    required this.errorMessage,
    required this.onSelectOption,
    required this.onSubmitAnswer,
    required this.onRequestHelp,
    required this.onAcknowledgeNote,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final q = card.question;
    final isMcq = q.questionType == QuestionType.multipleChoice;
    final isSubmitted = submitResult != null;

    final canSubmit = !isSubmitting &&
        !isSubmitted &&
        ((isMcq && selectedOptionId != null) ||
            (!isMcq && textAnswerController.text.trim().isNotEmpty));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Top header bar: Topic & Response Timer ─────────────────────────
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: Text(
                q.topic,
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              backgroundColor: ReflexColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
              side: BorderSide(color: ReflexColors.primary.withValues(alpha: 0.3)),
              padding: const EdgeInsets.symmetric(horizontal: 4),
            ),
            ResponseTimerWidget(
              expectedSeconds: q.expectedSeconds,
              isRunning: !isSubmitted,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Main Question Card with Chromatic Aura ─────────────────────────
        ChromaticAuraCard(
          tier: submitResult?.reflexTier,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                q.prompt,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 20),

              // ── Interaction: MCQ options or Text Input ─────────────────
              if (isMcq && q.options != null) ...[
                MultipleChoiceWidget(
                  options: q.options!,
                  selectedOptionId: selectedOptionId,
                  onOptionSelected: onSelectOption,
                  isSubmitted: isSubmitted,
                  explanations: submitResult?.optionExplanations,
                ),
              ] else ...[
                TextField(
                  controller: textAnswerController,
                  enabled: !isSubmitted,
                  onSubmitted: (_) {
                    if (canSubmit) onSubmitAnswer();
                  },
                  decoration: InputDecoration(
                    hintText: LocaleKeys.practice_enter_answer_hint.tr(),
                    prefixIcon: const Icon(Icons.edit_note_rounded),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 16),

        // ── Pre-submission actions: Help hint & Submit button ──────────────
        if (!isSubmitted) ...[
          Row(
            children: [
              if (q.hasHelpHint) ...[
                OutlinedButton.icon(
                  key: const Key('practice_help_button'),
                  onPressed: isRequestingHelp ? null : onRequestHelp,
                  icon: isRequestingHelp
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.help_outline_rounded,
                          color: ReflexColors.chromaticYellow),
                  label: Text(
                    LocaleKeys.practice_hint.tr(),
                    style: const TextStyle(color: ReflexColors.chromaticYellow),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: ReflexColors.chromaticYellow),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: ElevatedButton(
                  key: const Key('practice_submit_button'),
                  onPressed: canSubmit ? onSubmitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ReflexColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          LocaleKeys.practice_submit.tr(),
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ],

        // ── Post-submission feedback & Topic Note Gate ─────────────────────
        if (isSubmitted && submitResult != null) ...[
          ResultFeedbackWidget(result: submitResult!),
          const SizedBox(height: 16),
          TopicNoteGateWidget(
            topicNote: submitResult!.topicNote,
            isAcknowledged: isNoteAcknowledged,
            onAcknowledgeChanged: onAcknowledgeNote,
            onContinue: onContinue,
          ),
        ],

        if (errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            errorMessage!,
            style: TextStyle(
              color: theme.colorScheme.error,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
