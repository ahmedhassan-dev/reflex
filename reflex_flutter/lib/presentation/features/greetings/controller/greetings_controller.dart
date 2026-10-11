import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../../../client.dart';
import '../greetings_screen.dart';

/// All business logic for the Greetings screen following the arch_demo controller pattern.
///
/// Contains zero widgets — only state variables, lifecycle management, and action methods
/// that update the UI using native [setState].
abstract class GreetingsController extends State<GreetingsScreen> {
  // ── UI state ─────────────────────────────────────────────────────────────────
  String? resultMessage;
  String? errorMessage;
  bool isLoading = false;
  final TextEditingController nameController = TextEditingController();

  // ── Lifecycle ────────────────────────────────────────────────────────────────
  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  // ── Actions ──────────────────────────────────────────────────────────────────
  Future<void> callHello() async {
    final name = nameController.text.trim();
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final result = await client.greeting.hello(name);
      if (!mounted) return;
      setState(() {
        resultMessage = result.message;
        isLoading = false;
      });
    } catch (e, st) {
      debugPrint('[GreetingsController.callHello] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      if (!mounted) return;
      setState(() {
        errorMessage = '$e';
        isLoading = false;
      });
    }
  }
}
