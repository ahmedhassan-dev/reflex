import 'package:reflex_client/reflex_client.dart';
import '../../core/result.dart';
import '../../client.dart';

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
      final list = await _client.questionAdmin.listCourses();
      return Result.success(list);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<CohortSummary>> getCohortSummary(int courseId) async {
    try {
      final summary = await _client.analytics.getCohortSummary(courseId);
      return Result.success(summary);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<StudentProgress>> getMyProgress(int courseId) async {
    try {
      final progress = await _client.analytics.getMyProgress(courseId);
      return Result.success(progress);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
