import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/serverpod_repositories.dart';
import 'package:reflex_server/src/features/auth/services/auth_provisioning_service.dart';
import 'package:reflex_server/src/features/analytics/services/cohort_stats_service.dart';
import 'package:reflex_server/src/features/demo_clock/services/demo_clock_service.dart';
import 'package:reflex_server/src/features/practice/services/practice_service.dart';
import 'package:reflex_server/src/features/questions/services/question_admin_service.dart';

/// Central dependency injection container for Serverpod requests.
class AppContainer {
  final Session session;

  AppContainer(this.session);

  ServerpodLearnerRepository get learnerRepo => ServerpodLearnerRepository(session);
  ServerpodCourseRepository get courseRepo => ServerpodCourseRepository(session);
  ServerpodQuestionRepository get questionRepo => ServerpodQuestionRepository(session);
  ServerpodQuestionOptionRepository get optionRepo => ServerpodQuestionOptionRepository(session);
  ServerpodAcceptedAnswerRepository get acceptedAnswerRepo => ServerpodAcceptedAnswerRepository(session);
  ServerpodAttemptRepository get attemptRepo => ServerpodAttemptRepository(session);
  ServerpodReviewStateRepository get reviewStateRepo => ServerpodReviewStateRepository(session);
  ServerpodDemoClockRepository get demoClockRepo => ServerpodDemoClockRepository(session);
  ServerpodCourseSubscriptionRepository get courseSubscriptionRepo =>
      ServerpodCourseSubscriptionRepository(session);

  Future<Clock> getEffectiveClock() async {
    final offsetDays = await demoClockRepo.getOffsetDays();
    return DemoClockService(
      baseClock: const SystemClock(),
      initialOffsetDays: offsetDays,
    );
  }

  Future<PracticeService> getPracticeService() async {
    final clock = await getEffectiveClock();
    return PracticeService(
      questionRepo: questionRepo,
      optionRepo: optionRepo,
      acceptedAnswerRepo: acceptedAnswerRepo,
      attemptRepo: attemptRepo,
      reviewStateRepo: reviewStateRepo,
      courseRepo: courseRepo,
      subscriptionRepo: courseSubscriptionRepo,
      clock: clock,
    );
  }

  Future<CohortStatsService> getCohortStatsService() async {
    final clock = await getEffectiveClock();
    return CohortStatsService(
      learnerRepo: learnerRepo,
      questionRepo: questionRepo,
      attemptRepo: attemptRepo,
      reviewStateRepo: reviewStateRepo,
      clock: clock,
    );
  }

  CohortStatsService get cohortStatsService => CohortStatsService(
        learnerRepo: learnerRepo,
        questionRepo: questionRepo,
        attemptRepo: attemptRepo,
        reviewStateRepo: reviewStateRepo,
      );

  QuestionAdminService get questionAdminService => QuestionAdminService(
        questionRepo: questionRepo,
        courseRepo: courseRepo,
        optionRepo: optionRepo,
        acceptedAnswerRepo: acceptedAnswerRepo,
        subscriptionRepo: courseSubscriptionRepo,
        learnerRepo: learnerRepo,
      );

  AuthProvisioningService get authProvisioningService => AuthProvisioningService(
        learnerRepo: learnerRepo,
      );

  /// Resolves the active [Learner] profile for the session.
  /// If the caller is authenticated, maps their auth user.
  /// If unauthenticated (e.g. during live demonstration/judging), resolves or creates a demo student.
  Future<Learner> resolveCurrentLearner({
    String? defaultDisplayName,
    Role defaultRole = Role.student,
  }) async {
    final auth = session.authenticated;
    if (auth != null) {
      return authProvisioningService.ensureLearnerForSession(session);
    }

    final demoAuthId = defaultRole == Role.teacher
        ? UuidValue.fromString('00000000-0000-4000-8000-000000000022')
        : UuidValue.fromString('00000000-0000-4000-8000-000000000011');
    final existing = await learnerRepo.findByAuthUserId(demoAuthId);
    if (existing != null) return existing;

    return learnerRepo.save(Learner(
      authUserId: demoAuthId,
      displayName: defaultDisplayName ??
          (defaultRole == Role.teacher ? 'Mr. Hassan (Teacher)' : 'Alice (Student)'),
      role: defaultRole,
    ));
  }
}
