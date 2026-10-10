import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/practice_repository.dart';
import '../practice_screen.dart';
import '../widgets/help_bottom_sheet.dart';

/// Practice screen controller following the arch_demo State-Controller pattern.
///
/// Contains state management, Serverpod repository interactions, and UI handlers
/// with zero widget markup.
abstract class PracticeController extends State<PracticeScreen> {
  late final IPracticeRepository practiceRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  PracticeItem? currentCard;
  bool isLoading = false;
  bool isSubmitting = false;
  bool isRequestingHelp = false;
  String? errorMessage;

  int? selectedOptionId;
  final TextEditingController textAnswerController = TextEditingController();

  SubmitResult? submitResult;
  bool isNoteAcknowledged = false;
  bool isDeckComplete = false;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    practiceRepo = widget.repositoryOverride ?? PracticeRepositoryImpl();
    loadNextCard();
  }

  @override
  void dispose() {
    textAnswerController.dispose();
    super.dispose();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadNextCard() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
      submitResult = null;
      selectedOptionId = null;
      textAnswerController.clear();
      isNoteAcknowledged = false;
      isDeckComplete = false;
    });

    final result = await practiceRepo.serveNextCard(courseId);
    if (!mounted) return;

    if (result.isSuccess) {
      setState(() {
        isLoading = false;
        if (result.data != null) {
          currentCard = result.data;
          isDeckComplete = false;
        } else {
          currentCard = null;
          isDeckComplete = true;
        }
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = result.error;
      });
    }
  }

  void selectOption(int optionId) {
    if (submitResult != null) return;
    setState(() {
      selectedOptionId = optionId;
    });
  }

  Future<void> submitAnswer() async {
    if (currentCard == null || isSubmitting || submitResult != null) return;

    final isMcq = currentCard!.question.questionType == QuestionType.multipleChoice;
    final textAns = textAnswerController.text.trim();

    if (isMcq && selectedOptionId == null) return;
    if (!isMcq && textAns.isEmpty) return;

    setState(() {
      isSubmitting = true;
      errorMessage = null;
    });

    final res = await practiceRepo.submitAnswer(
      currentCard!.question.id,
      textAnswer: isMcq ? null : textAns,
      optionId: isMcq ? selectedOptionId : null,
    );

    if (!mounted) return;

    if (res.isSuccess) {
      final data = res.data!;
      setState(() {
        isSubmitting = false;
        submitResult = data;
        // If there is no topic note, automatically mark acknowledged
        if (data.topicNote == null || data.topicNote!.trim().isEmpty) {
          isNoteAcknowledged = true;
        } else {
          isNoteAcknowledged = false;
        }
      });
    } else {
      setState(() {
        isSubmitting = false;
        errorMessage = res.error;
      });
    }
  }

  Future<void> requestHelp() async {
    if (currentCard == null || isRequestingHelp || submitResult != null) return;

    setState(() {
      isRequestingHelp = true;
      errorMessage = null;
    });

    final res = await practiceRepo.requestHelp(currentCard!.question.id);
    if (!mounted) return;

    setState(() {
      isRequestingHelp = false;
    });

    if (res.isSuccess && res.data != null) {
      await HelpBottomSheet.show(context, res.data!);
    } else {
      setState(() {
        errorMessage = res.error;
      });
    }
  }

  void setNoteAcknowledged(bool acknowledged) {
    setState(() {
      isNoteAcknowledged = acknowledged;
    });
  }

  Future<void> continueToNextCard() async {
    await loadNextCard();
  }
}
