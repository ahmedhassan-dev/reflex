import 'dart:async';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../../../../data/repositories/question_admin_repository.dart';
import '../analytics_screen.dart';

/// Controller for Teacher Analytics Dashboard following arch_demo pattern.
abstract class AnalyticsController extends State<AnalyticsScreen> {
  late final IAnalyticsRepository analyticsRepo;
  IQuestionAdminRepository? questionRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  List<Course> courses = [];
  Course? selectedCourse;
  CohortSummary? summary;
  List<CourseSubscriptionView> subscriptions = [];
  bool isLoading = false;
  bool isLoadingSubscriptions = false;
  String? errorMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
    if (widget.questionRepositoryOverride != null) {
      questionRepo = widget.questionRepositoryOverride;
    } else {
      try {
        questionRepo = QuestionAdminRepositoryImpl();
      } catch (_) {
        questionRepo = null;
      }
    }
    loadCoursesAndSummary();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadCoursesAndSummary() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final coursesRes = await analyticsRepo.listCourses();
      if (!mounted) return;

      if (coursesRes.isSuccess && (coursesRes.data?.isNotEmpty ?? false)) {
        courses = coursesRes.data!;
        selectedCourse = courses.firstWhere(
          (c) => c.id == courseId,
          orElse: () => courses.first,
        );
        courseId = selectedCourse!.id ?? 1;
      }
    } catch (e, st) {
      debugPrint('[AnalyticsController.loadCoursesAndSummary] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }

    await Future.wait([
      loadSummary(),
      loadSubscriptions(),
    ]);
  }

  void onSelectCourse(Course course) {
    if (selectedCourse?.id != course.id) {
      setState(() {
        selectedCourse = course;
        courseId = course.id!;
      });
      loadSummary();
      loadSubscriptions();
    }
  }

  Future<void> loadSummary() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final res = await analyticsRepo.getCohortSummary(courseId);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoading = false;
        summary = res.data;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = res.error;
      });
    }
  }

  Future<void> loadSubscriptions() async {
    final repo = questionRepo;
    if (selectedCourse == null || repo == null) return;
    setState(() => isLoadingSubscriptions = true);

    try {
      final res = await repo.listSubscriptions(courseId);
      if (!mounted) return;
      setState(() {
        isLoadingSubscriptions = false;
        if (res.isSuccess) {
          subscriptions = res.data ?? [];
        }
      });
    } catch (e, st) {
      debugPrint('[AnalyticsController.loadSubscriptions] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (mounted) {
        setState(() => isLoadingSubscriptions = false);
      }
    }
  }

  Future<void> respondToSubscription(int subscriptionId, SubscriptionStatus status) async {
    final repo = questionRepo;
    if (repo == null) return;
    try {
      final res = await repo.respondToSubscription(subscriptionId, status);
      if (!mounted) return;

      if (res.isSuccess) {
        await loadSubscriptions();
        await loadSummary();
      }
    } catch (e, st) {
      debugPrint('[AnalyticsController.respondToSubscription] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }
}
