import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../student_progress_screen.dart';

/// Controller for Student Progress / Profile Screen following arch_demo pattern.
abstract class StudentProgressController extends State<StudentProgressScreen> {
  late final IAnalyticsRepository analyticsRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  StudentProgress? progress;
  bool isLoading = false;
  String? errorMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
    loadProgress();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> loadProgress() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final res = await analyticsRepo.getMyProgress(courseId);
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
