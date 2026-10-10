import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../../data/repositories/analytics_repository.dart';
import '../analytics_screen.dart';

/// Controller for Teacher Analytics Dashboard following arch_demo pattern.
abstract class AnalyticsController extends State<AnalyticsScreen> {
  late final IAnalyticsRepository analyticsRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int courseId = 1;
  CohortSummary? summary;
  bool isLoading = false;
  String? errorMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    analyticsRepo = widget.repositoryOverride ?? AnalyticsRepositoryImpl();
    loadSummary();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
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
