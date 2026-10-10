import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Mandatory Topic Note Gate Widget.
///
/// Prominently displays the teacher's concept note after submission.
/// Keeps the Continue button strictly disabled until the student explicitly
/// acknowledges that they have read and understood the note.
class TopicNoteGateWidget extends StatefulWidget {
  final String? topicNote;
  final bool isAcknowledged;
  final ValueChanged<bool> onAcknowledgeChanged;
  final VoidCallback onContinue;

  const TopicNoteGateWidget({
    super.key,
    required this.topicNote,
    required this.isAcknowledged,
    required this.onAcknowledgeChanged,
    required this.onContinue,
  });

  @override
  State<TopicNoteGateWidget> createState() => _TopicNoteGateWidgetState();
}

class _TopicNoteGateWidgetState extends State<TopicNoteGateWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final hasNote = widget.topicNote != null && widget.topicNote!.trim().isNotEmpty;
    final canContinue = !hasNote || widget.isAcknowledged;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hasNote) ...[
          Container(
            padding: const EdgeInsetsDirectional.all(16),
            decoration: BoxDecoration(
              color: ReflexColors.primary.withValues(alpha: isDark ? 0.12 : 0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ReflexColors.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.menu_book_rounded,
                      color: ReflexColors.primary,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        LocaleKeys.practice_note_gate_title.tr(),
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: ReflexColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  widget.topicNote!,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(),
                InkWell(
                  key: const Key('note_gate_checkbox_tile'),
                  onTap: () {
                    widget.onAcknowledgeChanged(!widget.isAcknowledged);
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Checkbox(
                          key: const Key('note_gate_checkbox'),
                          value: widget.isAcknowledged,
                          onChanged: (val) {
                            widget.onAcknowledgeChanged(val ?? false);
                          },
                          activeColor: ReflexColors.primary,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            LocaleKeys.practice_note_gate_acknowledge.tr(),
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: widget.isAcknowledged
                                  ? ReflexColors.primary
                                  : theme.textTheme.bodyMedium?.color,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
        ElevatedButton(
          key: const Key('practice_continue_button'),
          onPressed: canContinue ? widget.onContinue : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: ReflexColors.primary,
            foregroundColor: Colors.white,
            disabledBackgroundColor: isDark
                ? ReflexColors.darkBorder.withValues(alpha: 0.5)
                : ReflexColors.lightBorder.withValues(alpha: 0.5),
            disabledForegroundColor: isDark
                ? ReflexColors.textMutedDark
                : ReflexColors.textMutedLight,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: canContinue ? 2 : 0,
          ),
          child: Text(
            LocaleKeys.practice_continue_button.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        if (hasNote && !widget.isAcknowledged) ...[
          const SizedBox(height: 8),
          Text(
            LocaleKeys.practice_must_acknowledge_note.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ],
    );
  }
}
