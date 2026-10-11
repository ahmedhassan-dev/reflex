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
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.practice_title.tr()),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            tooltip: LocaleKeys.retry.tr(),
            onPressed: isLoading ? null : checkAccessAndLoad,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCourseSelectorHeader(context),
            if (isPrivateAccessRestricted)
              _buildPrivateCourseGate(context)
            else if (isLoading && currentCard == null)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (isDeckComplete)
              DeckCompleteWidget(onRefresh: loadNextCard)
            else if (currentCard == null)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        errorMessage ?? LocaleKeys.no_response_yet.tr(),
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: loadNextCard,
                        child: Text(LocaleKeys.retry.tr()),
                      ),
                    ],
                  ),
                ),
              )
            else
              _buildPracticeCardContent(context),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseSelectorHeader(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    if (courses.isEmpty && selectedCourse == null) {
      return const SizedBox.shrink();
    }

    final isPublic = selectedCourse?.isPublic ?? true;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: courses.length > 1
                    ? DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          key: const Key('practice_course_selector'),
                          isDense: true,
                          isExpanded: true,
                          value: courses.any((c) => c.id == courseId) ? courseId : courses.first.id,
                          items: courses.map((c) {
                            return DropdownMenuItem<int>(
                              value: c.id,
                              child: Row(
                                children: [
                                  Icon(
                                    (c.isPublic ?? true) ? Icons.menu_book_rounded : Icons.lock_outline_rounded,
                                    size: 16,
                                    color: (c.isPublic ?? true)
                                        ? ReflexColors.primary
                                        : ReflexColors.chromaticYellow,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      '${c.title} (${c.subject})',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          onChanged: (newId) {
                            if (newId != null) {
                              final found = courses.where((c) => c.id == newId).firstOrNull;
                              if (found != null) {
                                onCourseSelected(found);
                              }
                            }
                          },
                        ),
                      )
                    : Row(
                        children: [
                          Icon(
                            isPublic ? Icons.menu_book_rounded : Icons.lock_outline_rounded,
                            size: 18,
                            color: isPublic ? ReflexColors.primary : ReflexColors.chromaticYellow,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              selectedCourse != null
                                  ? '${selectedCourse!.title} (${selectedCourse!.subject})'
                                  : 'Reflex Practice',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPublic ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: (isPublic ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow)
                        .withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isPublic ? Icons.public_rounded : Icons.lock_outline_rounded,
                      size: 12,
                      color: isPublic ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isPublic
                          ? LocaleKeys.questions_admin_visibility_public.tr()
                          : LocaleKeys.questions_admin_visibility_private.tr(),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: isPublic ? ReflexColors.chromaticGreen : ReflexColors.chromaticYellow,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (selectedCourse?.teacherName != null) ...[
            const SizedBox(height: 6),
            Text(
              LocaleKeys.questions_admin_teacher_label.tr(args: [selectedCourse!.teacherName!]),
              style: TextStyle(
                fontSize: 11,
                color: isDark ? Colors.grey[400] : Colors.grey[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPrivateCourseGate(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isPending = subscriptionStatus == SubscriptionStatus.pending;
    final isRejected = subscriptionStatus == SubscriptionStatus.rejected;

    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkCard : ReflexColors.lightCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPending
              ? ReflexColors.chromaticYellow.withValues(alpha: 0.4)
              : isRejected
                  ? ReflexColors.chromaticRed.withValues(alpha: 0.4)
                  : isDark
                      ? ReflexColors.darkBorder
                      : ReflexColors.lightBorder,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: (isRejected
                      ? ReflexColors.chromaticRed
                      : isPending
                          ? ReflexColors.chromaticYellow
                          : ReflexColors.primary)
                  .withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isRejected
                  ? Icons.block_rounded
                  : isPending
                      ? Icons.hourglass_top_rounded
                      : Icons.lock_outline_rounded,
              size: 40,
              color: isRejected
                  ? ReflexColors.chromaticRed
                  : isPending
                      ? ReflexColors.chromaticYellow
                      : ReflexColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isRejected
                ? LocaleKeys.subscriptions_status_rejected.tr()
                : isPending
                    ? LocaleKeys.subscriptions_pending_approval.tr()
                    : LocaleKeys.subscriptions_access_denied.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            LocaleKeys.subscriptions_request_access_desc.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.grey[400] : Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          if (isPending) ...[
            OutlinedButton.icon(
              key: const Key('btn_refresh_subscription_status'),
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: Text(LocaleKeys.retry.tr()),
              style: OutlinedButton.styleFrom(
                foregroundColor: ReflexColors.chromaticYellow,
                side: const BorderSide(color: ReflexColors.chromaticYellow),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: checkAccessAndLoad,
            ),
          ] else ...[
            ElevatedButton.icon(
              key: const Key('btn_request_subscription'),
              icon: isRequestingSubscription
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.send_rounded, size: 18),
              label: Text(LocaleKeys.subscriptions_request_access.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: ReflexColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: isRequestingSubscription ? null : requestSubscription,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPracticeCardContent(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final q = currentCard!.question;
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
        );
  }
}
