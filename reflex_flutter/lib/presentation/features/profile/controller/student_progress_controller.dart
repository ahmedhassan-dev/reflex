import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../student_progress_screen.dart';

/// Controller for Student Progress / Profile Screen following arch_demo pattern.
abstract class StudentProgressController extends State<StudentProgressScreen> {
  late final IAnalyticsRepository analyticsRepo;

  // ── State variables ────────────────────────────────────────────────────────
  List<Course> courses = [];
  Course? selectedCourse;
  StudentProgress? progress;
  bool isLoading = false;
  String? errorMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
    loadCoursesAndProgress();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadCoursesAndProgress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final coursesRes = await analyticsRepo.listCourses();
    if (!mounted) return;

    if (coursesRes.isSuccess) {
      final list = coursesRes.data ?? [];
      courses = list;
      if (selectedCourse == null || !list.any((c) => c.id == selectedCourse?.id)) {
        selectedCourse = list.firstOrNull;
      }
    }

    await _fetchProgressForSelectedCourse();
  }

  Future<void> selectCourse(Course course) async {
    if (selectedCourse?.id == course.id) return;
    setState(() {
      selectedCourse = course;
    });
    await loadProgress();
  }

  Future<void> loadProgress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    await _fetchProgressForSelectedCourse();
  }

  Future<void> _fetchProgressForSelectedCourse() async {
    final targetCourseId = selectedCourse?.id ?? 1;
    final res = await analyticsRepo.getMyProgress(targetCourseId);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoading = false;
        progress = res.data;
      });
    } else {
      setState(() {
        isLoading = false;
        errorMessage = res.error;
      });
    }
  }
}
