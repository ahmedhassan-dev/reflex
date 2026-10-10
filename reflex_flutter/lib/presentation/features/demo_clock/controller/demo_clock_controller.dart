import 'package:flutter/material.dart';
import '../../../../data/repositories/demo_clock_repository.dart';
import '../widgets/demo_clock_widget.dart';

/// Controller managing Demo Clock time machine state and actions.
abstract class DemoClockController extends State<DemoClockWidget> {
  late final IDemoClockRepository clockRepo;

  // ── State variables ────────────────────────────────────────────────────────
  int offsetDays = 0;
  bool isLoading = false;
  String? statusMessage;

  // ── Lifecycle ──────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    clockRepo = widget.repositoryOverride ?? DemoClockRepositoryImpl();
    fetchOffset();
  }

  // ── Actions ────────────────────────────────────────────────────────────────
  Future<void> fetchOffset() async {
    final res = await clockRepo.getOffsetDays();
    if (!mounted) return;
    if (res.isSuccess) {
      setState(() {
        offsetDays = res.data ?? 0;
      });
    }
  }

  Future<void> advance(int days) async {
    setState(() {
      isLoading = true;
    });

    final res = await clockRepo.advanceDays(days);
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoading = false;
        offsetDays = res.data ?? (offsetDays + days);
        statusMessage = '+$days d';
      });
      widget.onClockShifted?.call();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> reset() async {
    setState(() {
      isLoading = true;
    });

    final res = await clockRepo.resetClock();
    if (!mounted) return;

    if (res.isSuccess) {
      setState(() {
        isLoading = false;
        offsetDays = 0;
        statusMessage = 'Reset';
      });
      widget.onClockShifted?.call();
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
