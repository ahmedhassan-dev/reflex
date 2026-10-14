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

class PracticeCardContentWidget extends StatefulWidget {
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
  State<PracticeCardContentWidget> createState() =>
      _PracticeCardContentWidgetState();
}

class _PracticeCardContentWidgetState
    extends State<PracticeCardContentWidget> {
  @override
  void initState() {
    super.initState();
    widget.textAnswerController.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(covariant PracticeCardContentWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.textAnswerController != widget.textAnswerController) {
      oldWidget.textAnswerController.removeListener(_onTextChanged);
      widget.textAnswerController.addListener(_onTextChanged);
    }
  }

  @override
  void dispose() {
    widget.textAnswerController.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final q = widget.card.question;
    final isMcq = q.questionType == QuestionType.multipleChoice;
    final isSubmitted = widget.submitResult != null;
    final hasText = widget.textAnswerController.text.trim().isNotEmpty;
    final canSubmit = !widget.isSubmitting &&
        !isSubmitted &&
        ((isMcq && widget.selectedOptionId != null) || (!isMcq && hasText));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ── Top header bar: Topic, Total Score & Response Timer ───────────
        Row(
          children: [
            Flexible(
              child: Chip(
                label: Text(
                  q.topic,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                backgroundColor: ReflexColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                side: BorderSide(color: ReflexColors.primary.withValues(alpha: 0.3)),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 8),
            if (widget.card.totalScore != null || widget.submitResult?.totalScore != null) ...[
              Container(
                key: const Key('practice_header_score_badge'),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: ReflexColors.primary.withValues(alpha: isDark ? 0.2 : 0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: ReflexColors.primary.withValues(alpha: 0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stars_rounded, color: ReflexColors.primary, size: 15),
                    const SizedBox(width: 4),
                    Text(
                      '${LocaleKeys.practice_total_score.tr()}: ${widget.submitResult?.totalScore ?? widget.card.totalScore ?? 0}',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: ReflexColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
            ResponseTimerWidget(
              expectedSeconds: q.expectedSeconds,
              isRunning: !isSubmitted,
            ),
          ],
        ),
        const SizedBox(height: 16),

        // ── Main Question Card with Chromatic Aura ─────────────────────────
        ChromaticAuraCard(
          tier: widget.submitResult?.reflexTier,
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
                  selectedOptionId: widget.selectedOptionId,
                  onOptionSelected: widget.onSelectOption,
                  isSubmitted: isSubmitted,
                  explanations: widget.submitResult?.optionExplanations,
                ),
              ] else ...[
                TextField(
                  key: const Key('practice_text_input'),
                  controller: widget.textAnswerController,
                  enabled: !isSubmitted,
                  onChanged: (_) => _onTextChanged(),
                  onSubmitted: (_) {
                    if (canSubmit) widget.onSubmitAnswer();
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
                  onPressed: widget.isRequestingHelp ? null : widget.onRequestHelp,
                  icon: widget.isRequestingHelp
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
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                  onPressed: canSubmit ? widget.onSubmitAnswer : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ReflexColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                        isDark ? Colors.grey[800] : Colors.grey[300],
                    disabledForegroundColor:
                        isDark ? Colors.grey[500] : Colors.grey[500],
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: widget.isSubmitting
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
        if (isSubmitted && widget.submitResult != null) ...[
          ResultFeedbackWidget(result: widget.submitResult!),
          const SizedBox(height: 16),
          TopicNoteGateWidget(
            topicNote: widget.submitResult!.topicNote,
            isAcknowledged: widget.isNoteAcknowledged,
            onAcknowledgeChanged: widget.onAcknowledgeNote,
            onContinue: widget.onContinue,
          ),
        ],

        if (widget.errorMessage != null) ...[
          const SizedBox(height: 12),
          Text(
            widget.errorMessage!,
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
