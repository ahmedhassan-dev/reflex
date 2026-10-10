import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/practice_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'controller/practice_controller.dart';
import 'widgets/chromatic_aura_card.dart';
import 'widgets/deck_complete_widget.dart';
import 'widgets/multiple_choice_widget.dart';
import 'widgets/response_timer_widget.dart';
import 'widgets/result_feedback_sheet.dart';
import 'widgets/topic_note_gate_widget.dart';

/// Adaptive Practice Screen for reflex-based spaced repetition learning.
///
/// Follows the arch_demo pattern: widget markup is isolated here, while
/// all state management and action logic lives in [PracticeController].
class PracticeScreen extends StatefulWidget {
  final IPracticeRepository? repositoryOverride;

  const PracticeScreen({
    super.key,
    this.repositoryOverride,
  });

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends PracticeController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (isLoading && currentCard == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (isDeckComplete) {
      return DeckCompleteWidget(
        onRefresh: loadNextCard,
      );
    }

    if (currentCard == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage ?? LocaleKeys.no_response_yet.tr(),
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: loadNextCard,
              child: Text(LocaleKeys.retry.tr()),
            ),
          ],
        ),
      );
    }

    final q = currentCard!.question;
    final isMcq = q.questionType == QuestionType.multipleChoice;
    final isSubmitted = submitResult != null;

    final canSubmit = !isSubmitting &&
        !isSubmitted &&
        ((isMcq && selectedOptionId != null) ||
            (!isMcq && textAnswerController.text.trim().isNotEmpty));

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.practice_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: LocaleKeys.retry.tr(),
            onPressed: isLoading ? null : loadNextCard,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
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
                      onOptionSelected: selectOption,
                      isSubmitted: isSubmitted,
                      explanations: submitResult?.optionExplanations,
                    ),
                  ] else ...[
                    TextField(
                      controller: textAnswerController,
                      enabled: !isSubmitted,
                      onChanged: (_) => setState(() {}),
                      onSubmitted: (_) {
                        if (canSubmit) submitAnswer();
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
                      onPressed: isRequestingHelp ? null : requestHelp,
                      icon: isRequestingHelp
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.help_outline_rounded, color: ReflexColors.chromaticYellow),
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
                      onPressed: canSubmit ? submitAnswer : null,
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
                              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                onAcknowledgeChanged: setNoteAcknowledged,
                onContinue: continueToNextCard,
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
        ),
      ),
    );
  }
}
