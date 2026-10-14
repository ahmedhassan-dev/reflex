import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Endpoint delivering cohort-wide insights and individual student learning progress.
class AnalyticsEndpoint extends Endpoint {
  /// Returns aggregated cohort metrics for teacher dashboard and question analytics.
  Future<CohortSummary> getCohortSummary(Session session, int courseId) async {
    final container = AppContainer(session);
    final stats = await container.getCohortStatsService();
    return stats.getCohortSummary(courseId: courseId);
  }

  /// Returns progress metrics for the currently active student.
  Future<StudentProgress> getMyProgress(Session session, int courseId) async {
    final container = AppContainer(session);
    final profile = await container.resolveCurrentProfile();
    final stats = await container.getCohortStatsService();
    return stats.getStudentProgress(
      profileId: profile.id!,
      courseId: courseId,
    );
  }
}
