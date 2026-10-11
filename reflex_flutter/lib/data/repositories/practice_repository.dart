import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../core/result.dart';
import '../../client.dart';

abstract interface class IPracticeRepository {
  Future<Result<List<Course>>> listCourses();
  Future<Result<PracticeItem?>> serveNextCard(int courseId);
  Future<Result<HelpResult>> requestHelp(int questionId);
  Future<Result<SubmitResult>> submitAnswer(
    int questionId, {
    String? textAnswer,
    int? optionId,
  });
  Future<Result<CourseSubscription>> requestCourseSubscription(int courseId);
  Future<Result<SubscriptionStatus?>> getCourseSubscriptionStatus(int courseId);
}

class PracticeRepositoryImpl implements IPracticeRepository {
  final Client _client;

  PracticeRepositoryImpl([Client? clientInstance])
      : _client = clientInstance ?? client;

  @override
  Future<Result<List<Course>>> listCourses() async {
    try {
      final list = await _client.practice.listCourses();
      return Result.success(list);
    } catch (e, st) {
      debugPrint('[PracticeRepository.listCourses] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<PracticeItem?>> serveNextCard(int courseId) async {
    try {
      final item = await _client.practice.serveNextCard(courseId);
      return Result.success(item);
    } catch (e, st) {
      debugPrint('[PracticeRepository.serveNextCard] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<HelpResult>> requestHelp(int questionId) async {
    try {
      final help = await _client.practice.requestHelp(questionId);
      return Result.success(help);
    } catch (e, st) {
      debugPrint('[PracticeRepository.requestHelp] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<SubmitResult>> submitAnswer(
    int questionId, {
    String? textAnswer,
    int? optionId,
  }) async {
    try {
      final result = await _client.practice.submitAnswer(
        questionId,
        textAnswer: textAnswer,
        optionId: optionId,
      );
      return Result.success(result);
    } catch (e, st) {
      debugPrint('[PracticeRepository.submitAnswer] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<CourseSubscription>> requestCourseSubscription(int courseId) async {
    try {
      final sub = await _client.practice.requestCourseSubscription(courseId);
      return Result.success(sub);
    } catch (e, st) {
      debugPrint('[PracticeRepository.requestCourseSubscription] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<SubscriptionStatus?>> getCourseSubscriptionStatus(int courseId) async {
    try {
      final status = await _client.practice.getCourseSubscriptionStatus(courseId);
      return Result.success(status);
    } catch (e, st) {
      debugPrint('[PracticeRepository.getCourseSubscriptionStatus] error: $e\n$st');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return Result.failure(e.toString());
    }
  }
}
