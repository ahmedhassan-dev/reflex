import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
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
  List<Course> courses = [];
  Course? selectedCourse;
  SubscriptionStatus? subscriptionStatus;
  bool isPrivateAccessRestricted = false;
  bool isRequestingSubscription = false;

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
    if (widget.initialCourseId != null) {
      courseId = widget.initialCourseId!;
    }
    practiceRepo = widget.repositoryOverride ?? PracticeRepositoryImpl();
    initCoursesAndCards();
  }

  @override
  void didUpdateWidget(covariant PracticeScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialCourseId != null &&
        widget.initialCourseId != oldWidget.initialCourseId &&
        widget.initialCourseId != courseId) {
      final found =
          courses.where((c) => c.id == widget.initialCourseId).firstOrNull;
      if (found != null) {
        onCourseSelected(found);
      } else {
        courseId = widget.initialCourseId!;
        checkAccessAndLoad();
      }
    }
  }

  @override
  void dispose() {
    textAnswerController.dispose();
    super.dispose();
  }

  // ── Course & Access Handling ───────────────────────────────────────────────
  Future<void> initCoursesAndCards() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final coursesRes = await practiceRepo.listCourses();
      if (coursesRes.isSuccess && (coursesRes.data?.isNotEmpty ?? false)) {
        courses = coursesRes.data!;
        selectedCourse = courses.firstWhere(
          (c) => c.id == courseId,
          orElse: () => courses.first,
        );
        courseId = selectedCourse!.id ?? 1;
      }
    } catch (e, st) {
      debugPrint('[PracticeController.initCoursesAndCards] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }

    await checkAccessAndLoad();
  }

  Future<void> onCourseSelected(Course course) async {
    if (course.id == null || course.id == courseId) return;
    setState(() {
      selectedCourse = course;
      courseId = course.id!;
      currentCard = null;
      submitResult = null;
      selectedOptionId = null;
      textAnswerController.clear();
      isNoteAcknowledged = false;
      isDeckComplete = false;
      subscriptionStatus = null;
      isPrivateAccessRestricted = false;
      errorMessage = null;
    });

    await checkAccessAndLoad();
  }

  Future<void> checkAccessAndLoad() async {
    if (selectedCourse != null && (selectedCourse!.isPublic == false)) {
      try {
        final statusRes = await practiceRepo.getCourseSubscriptionStatus(courseId);
        if (statusRes.isSuccess) {
          subscriptionStatus = statusRes.data;
          if (subscriptionStatus != SubscriptionStatus.accepted) {
            setState(() {
              isLoading = false;
              isPrivateAccessRestricted = true;
            });
            return;
          }
        }
      } catch (e, st) {
        debugPrint('[PracticeController.checkAccessAndLoad] error: $e\n$st');
        unawaited(Sentry.captureException(e, stackTrace: st));
      }
    }

    setState(() {
      isPrivateAccessRestricted = false;
    });
    await loadNextCard();
  }

  Future<void> requestSubscription() async {
    if (isRequestingSubscription) return;
    setState(() {
      isRequestingSubscription = true;
      errorMessage = null;
    });

    final res = await practiceRepo.requestCourseSubscription(courseId);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isRequestingSubscription = false;
        subscriptionStatus = res.data?.status ?? SubscriptionStatus.pending;
        isPrivateAccessRestricted = true;
      });
    } else {
      setState(() {
        isRequestingSubscription = false;
        errorMessage = res.error;
      });
    }
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
        isPrivateAccessRestricted = false;
        if (result.data != null) {
          currentCard = result.data;
          isDeckComplete = false;
        } else {
          currentCard = null;
          isDeckComplete = true;
        }
      });
    } else {
      final err = result.error ?? '';
      if (err.toLowerCase().contains('private') || err.contains('CourseAccessDeniedException')) {
        setState(() {
          isLoading = false;
          isPrivateAccessRestricted = true;
          errorMessage = err;
        });
      } else {
        setState(() {
          isLoading = false;
          errorMessage = err;
        });
      }
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
