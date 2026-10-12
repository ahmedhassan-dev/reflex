import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Practice action widget providing the Continue to Next Card action.
///
/// Teacher explanations are displayed via the top toast banner.
class TopicNoteGateWidget extends StatelessWidget {
  final String? topicNote;
  final bool isAcknowledged;
  final ValueChanged<bool>? onAcknowledgeChanged;
  final VoidCallback onContinue;

  const TopicNoteGateWidget({
    super.key,
    this.topicNote,
    this.isAcknowledged = true,
    this.onAcknowledgeChanged,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          key: const Key('practice_continue_button'),
          onPressed: onContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: ReflexColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 2,
          ),
          child: Text(
            LocaleKeys.practice_continue_button.tr(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
