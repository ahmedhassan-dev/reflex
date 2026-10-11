import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../analytics_screen.dart';

/// Controller for Teacher Analytics Dashboard following arch_demo pattern.
abstract class AnalyticsController extends State<AnalyticsScreen> {
  late final IAnalyticsRepository analyticsRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  List<Course> courses = [];
  Course? selectedCourse;
  CohortSummary? summary;
  bool isLoading = false;
  String? errorMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
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
    } catch (_) {
      // Gracefully handle unmocked or failing listCourses
    }

    await loadSummary();
  }

  void onSelectCourse(Course course) {
    if (selectedCourse?.id != course.id) {
      setState(() {
        selectedCourse = course;
        courseId = course.id!;
      });
      loadSummary();
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
}
