import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Endpoint delivering cohort-wide insights and individual student learning progress.
class AnalyticsEndpoint extends Endpoint {
  /// Returns aggregated cohort metrics for teacher dashboard and question analytics.
  Future<CohortSummary> getCohortSummary(Session session, int courseId) async {
    final container = AppContainer(session);
    return container.cohortStatsService.getCohortSummary(courseId: courseId);
  }

  /// Returns progress metrics for the currently active student.
  Future<StudentProgress> getMyProgress(Session session, int courseId) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    return container.cohortStatsService.getStudentProgress(
      learnerId: learner.id!,
      courseId: courseId,
    );
  }
}
