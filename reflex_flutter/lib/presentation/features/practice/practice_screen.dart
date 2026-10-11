import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/practice_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import 'controller/practice_controller.dart';
import 'widgets/deck_complete_widget.dart';
import 'widgets/practice_card_content_widget.dart';
import 'widgets/practice_course_selector_header.dart';
import 'widgets/private_course_gate_widget.dart';

/// Adaptive Practice Screen for reflex-based spaced repetition learning.
///
/// Follows the arch_demo pattern: widget markup is isolated here, while
/// all state management and action logic lives in [PracticeController].
class PracticeScreen extends StatefulWidget {
  final IPracticeRepository? repositoryOverride;
  final int? initialCourseId;

  const PracticeScreen({
    super.key,
    this.repositoryOverride,
    this.initialCourseId,
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
            PracticeCourseSelectorHeader(
              courses: courses,
              selectedCourse: selectedCourse,
              courseId: courseId,
              onCourseSelected: onCourseSelected,
            ),
            if (isPrivateAccessRestricted)
              PrivateCourseGateWidget(
                subscriptionStatus: subscriptionStatus,
                isRequestingSubscription: isRequestingSubscription,
                onRequestSubscription: requestSubscription,
                onRefresh: checkAccessAndLoad,
              )
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
              PracticeCardContentWidget(
                card: currentCard!,
                submitResult: submitResult,
                isSubmitting: isSubmitting,
                selectedOptionId: selectedOptionId,
                textAnswerController: textAnswerController,
                isNoteAcknowledged: isNoteAcknowledged,
                isRequestingHelp: isRequestingHelp,
                errorMessage: errorMessage,
                onSelectOption: selectOption,
                onSubmitAnswer: submitAnswer,
                onRequestHelp: requestHelp,
                onAcknowledgeNote: setNoteAcknowledged,
                onContinue: continueToNextCard,
              ),
          ],
        ),
      ),
    );
  }
}
