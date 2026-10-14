import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../client.dart';
import '../../core/result.dart';

import '../../core/storage/role_preferences.dart';

abstract interface class IAnalyticsRepository {
  Future<Result<List<Course>>> listCourses();
  Future<Result<CohortSummary>> getCohortSummary(int courseId);
  Future<Result<StudentProgress>> getMyProgress(int courseId);
}

class AnalyticsRepositoryImpl implements IAnalyticsRepository {
  final Client _client;

  AnalyticsRepositoryImpl([Client? clientInstance])
      : _client = clientInstance ?? client;

  @override
  Future<Result<List<Course>>> listCourses() async {
    try {
      final role = await RolePreferences.getSavedRole();
      final isTeacher = role == Role.teacher;
      final list = isTeacher
          ? await _client.questionAdmin.listCourses()
          : await _client.practice.listCourses();
      return Result.success(list);
    } catch (e, st) {
      debugPrint('[AnalyticsRepository.listCourses] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<CohortSummary>> getCohortSummary(int courseId) async {
    try {
      final summary = await _client.analytics.getCohortSummary(courseId);
      return Result.success(summary);
    } catch (e, st) {
      debugPrint('[AnalyticsRepository.getCohortSummary] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<StudentProgress>> getMyProgress(int courseId) async {
    try {
      final progress = await _client.analytics.getMyProgress(courseId);
      return Result.success(progress);
    } catch (e, st) {
      debugPrint('[AnalyticsRepository.getMyProgress] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }
}
