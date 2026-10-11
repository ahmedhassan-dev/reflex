import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Endpoint managing active flashcard practice, hints, and answer submissions.
class PracticeEndpoint extends Endpoint {
  /// Lists all courses available for practice.
  Future<List<Course>> listCourses(Session session) async {
    final container = AppContainer(session);
    return container.courseRepo.listAll();
  }

  /// Serves the next card due for spaced repetition review or the next unattempted card.
  Future<PracticeItem?> serveNextCard(Session session, int courseId) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    final practiceService = await container.getPracticeService();

    return practiceService.serveNextCard(
      learnerId: learner.id!,
      courseId: courseId,
    );
  }

  /// Requests a help hint for the currently served card.
  Future<HelpResult> requestHelp(Session session, int questionId) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    final practiceService = await container.getPracticeService();

    return practiceService.requestHelp(
      learnerId: learner.id!,
      questionId: questionId,
    );
  }

  /// Submits an answer for the currently served question.
  Future<SubmitResult> submitAnswer(
    Session session,
    int questionId, {
    String? textAnswer,
    int? optionId,
  }) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    final practiceService = await container.getPracticeService();

    return practiceService.submitAnswer(
      learnerId: learner.id!,
      questionId: questionId,
      textAnswer: textAnswer,
      optionId: optionId,
    );
  }

  /// Requests subscription to a private course.
  Future<CourseSubscription> requestCourseSubscription(
    Session session,
    int courseId,
  ) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    final practiceService = await container.getPracticeService();
    return practiceService.requestSubscription(
      learnerId: learner.id!,
      courseId: courseId,
    );
  }

  /// Checks subscription status of active learner for a course.
  Future<SubscriptionStatus?> getCourseSubscriptionStatus(
    Session session,
    int courseId,
  ) async {
    final container = AppContainer(session);
    final learner = await container.resolveCurrentLearner();
    final practiceService = await container.getPracticeService();
    return practiceService.getSubscriptionStatus(
      learnerId: learner.id!,
      courseId: courseId,
    );
  }
}
