import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../client.dart';
import '../../../../data/repositories/question_admin_repository.dart';
import '../question_admin_screen.dart';

/// Controller for Teacher Question Editor screen following arch_demo pattern.
abstract class QuestionAdminController extends State<QuestionAdminScreen> {
  late final IQuestionAdminRepository questionRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  List<Course> courses = [];
  Course? selectedCourse;

  List<Question> questions = [];
  Question? selectedQuestion;
  bool isLoading = false;
  bool isSaving = false;
  String? errorMessage;
  String? successMessage;

  final TextEditingController topicNoteController = TextEditingController();
  final TextEditingController helpHintController = TextEditingController();

  static const int maxCharLimit = 2000;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    questionRepo = widget.repositoryOverride ?? QuestionAdminRepositoryImpl();
    loadCoursesAndQuestions();
  }

  @override
  void dispose() {
    topicNoteController.dispose();
    helpHintController.dispose();
    super.dispose();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadCoursesAndQuestions() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    if (isUserAuthenticated && !isDemoUserActive) {
      await syncUserProfileRole(Role.teacher);
    }

    final coursesRes = await questionRepo.listCourses();
    if (!mounted) return;

    if (coursesRes.isSuccess && (coursesRes.data?.isNotEmpty ?? false)) {
      courses = coursesRes.data!;
      // Find course matching current courseId or pick first
      selectedCourse = courses.firstWhere(
        (c) => c.id == courseId,
        orElse: () => courses.first,
      );
      courseId = selectedCourse!.id!;
      if (selectedCourse!.isPublic == false) {
        unawaited(loadSubscriptions());
      }
      await loadQuestions();
    } else {
      setState(() {
        courses = [];
        selectedCourse = null;
        courseId = 0;
        questions = [];
        selectedQuestion = null;
        subscriptions = [];
        topicNoteController.clear();
        helpHintController.clear();
        isLoading = false;
      });
    }
  }

  Future<void> onCourseSelected(Course course) async {
    if (course.id == null || course.id == courseId) return;
    setState(() {
      selectedCourse = course;
      courseId = course.id!;
      selectedQuestion = null;
      subscriptions = [];
      topicNoteController.clear();
      helpHintController.clear();
      successMessage = null;
      errorMessage = null;
    });
    if (course.isPublic == false) {
      unawaited(loadSubscriptions());
    }
    await loadQuestions();
  }

  Future<void> loadQuestions() async {
    if (courseId == 0 || selectedCourse == null) {
      setState(() {
        questions = [];
        selectedQuestion = null;
        isLoading = false;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final res = await questionRepo.listQuestions(courseId);
    if (!mounted) return;

    if (res.isSuccess) {
      final list = res.data ?? [];
      setState(() {
        isLoading = false;
        questions = list;
        if (list.isNotEmpty) {
          selectQuestion(list.first);
        } else {
          selectedQuestion = null;
          topicNoteController.clear();
          helpHintController.clear();
        }
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = res.error;
      });
    }
  }

  void selectQuestion(Question q) {
    setState(() {
      selectedQuestion = q;
      topicNoteController.text = q.topicNote ?? '';
      helpHintController.text = q.helpHint ?? '';
      successMessage = null;
      errorMessage = null;
    });
  }

  List<CourseSubscriptionView> subscriptions = [];
  bool isLoadingSubscriptions = false;

  Future<bool> createNewCourse({
    required String title,
    required String subject,
    List<String>? topics,
    bool isPublic = true,
  }) async {
    final res = await questionRepo.createCourse(
      title: title,
      subject: subject,
      topics: topics,
      isPublic: isPublic,
    );
    if (!mounted) return false;

    if (res.isSuccess) {
      final newCourse = res.data!;
      setState(() {
        courses.add(newCourse);
        selectedCourse = newCourse;
        courseId = newCourse.id!;
        questions = [];
        selectedQuestion = null;
        topicNoteController.clear();
        helpHintController.clear();
        successMessage = 'course_created';
      });
      return true;
    } else {
      setState(() {
        errorMessage = res.error;
      });
      return false;
    }
  }

  Future<void> toggleCourseVisibility() async {
    if (selectedCourse == null) return;
    final currentIsPublic = selectedCourse!.isPublic ?? true;
    final newIsPublic = !currentIsPublic;

    final res = await questionRepo.updateCourseVisibility(courseId, newIsPublic);
    if (!mounted) return;

    if (res.isSuccess) {
      final updated = res.data!;
      setState(() {
        selectedCourse = updated;
        final idx = courses.indexWhere((c) => c.id == updated.id);
        if (idx != -1) courses[idx] = updated;
      });
      if (!newIsPublic) {
        await loadSubscriptions();
      }
    }
  }

  Future<void> loadSubscriptions() async {
    if (selectedCourse == null) return;
    setState(() => isLoadingSubscriptions = true);

    final res = await questionRepo.listSubscriptions(courseId);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoadingSubscriptions = false;
        subscriptions = res.data ?? [];
      });
    } else {
      setState(() => isLoadingSubscriptions = false);
    }
  }

  Future<void> respondToSubscription(int subscriptionId, SubscriptionStatus status) async {
    final res = await questionRepo.respondToSubscription(subscriptionId, status);
    if (!mounted) return;

    if (res.isSuccess) {
      await loadSubscriptions();
    }
  }

  Future<bool> createNewQuestion(CreateQuestionInput input) async {
    final res = await questionRepo.createQuestion(input);
    if (!mounted) return false;

    if (res.isSuccess) {
      final created = res.data!;
      setState(() {
        questions.add(created);
        selectQuestion(created);
        successMessage = 'question_created';
      });
      return true;
    } else {
      setState(() {
        errorMessage = res.error;
      });
      return false;
    }
  }

  Future<void> saveChanges() async {
    if (selectedQuestion == null || isSaving) return;

    setState(() {
      isSaving = true;
      errorMessage = null;
      successMessage = null;
    });

    final qId = selectedQuestion!.id!;
    final note = topicNoteController.text.trim();
    final hint = helpHintController.text.trim();

    final res = await questionRepo.updateTopicNoteAndHint(
      qId,
      topicNote: note.isEmpty ? null : note,
      helpHint: hint.isEmpty ? null : hint,
    );

    if (!mounted) return;

    if (res.isSuccess) {
      final updated = res.data!;
      final idx = questions.indexWhere((q) => q.id == qId);
      if (idx != -1) {
        questions[idx] = updated;
      }
      setState(() {
        isSaving = false;
        selectedQuestion = updated;
        successMessage = 'saved';
      });
    } else {
      setState(() {
        isSaving = false;
        errorMessage = res.error;
      });
    }
  }
}
