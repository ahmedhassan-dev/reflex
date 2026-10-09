import 'package:flutter/material.dart';

abstract final class ReflexColors {
  // ── Surface & Background ──────────────────────────────────────────────────
  static const darkBackground = Color(0xFF0B0F19);
  static const darkSurface    = Color(0xFF131B2E);
  static const darkCard       = Color(0xFF1E293B);
  static const darkBorder     = Color(0xFF334155);

  static const lightBackground = Color(0xFFF8FAFC);
  static const lightSurface    = Color(0xFFFFFFFF);
  static const lightCard       = Color(0xFFF1F5F9);
  static const lightBorder     = Color(0xFFCBD5E1);

  // ── Primary Brand ─────────────────────────────────────────────────────────
  static const primary       = Color(0xFF6366F1);
  static const primaryDark   = Color(0xFF4F46E5);
  static const accent        = Color(0xFF8B5CF6);

  // ── Chromatic Reflex Feedback Auras ───────────────────────────────────────
  /// Red: incorrect answer (Needs work)
  static const chromaticRed    = Color(0xFFEF4444);
  /// Yellow: correct with help or slow response (Developing)
  static const chromaticYellow = Color(0xFFF59E0B);
  /// Green: clean solve on first attempt under expected time (Mastered)
  static const chromaticGreen  = Color(0xFF10B981);

  // ── Text colors ───────────────────────────────────────────────────────────
  static const textPrimaryDark   = Color(0xFFF8FAFC);
  static const textSecondaryDark = Color(0xFF94A3B8);
  static const textMutedDark     = Color(0xFF64748B);

  static const textPrimaryLight   = Color(0xFF0F172A);
  static const textSecondaryLight = Color(0xFF475569);
  static const textMutedLight     = Color(0xFF94A3B8);
}
