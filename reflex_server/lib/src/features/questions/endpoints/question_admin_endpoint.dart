import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Endpoint allowing teachers to inspect questions, create courses/questions, update topic notes, and manage hints.
class QuestionAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.teacher};

  /// Lists all courses.
  Future<List<Course>> listCourses(Session session) async {
    final container = AppContainer(session);
    return container.questionAdminService.listCourses();
  }

  /// Creates a new course.
  Future<Course> createCourse(
    Session session, {
    required String title,
    required String subject,
    List<String>? topics,
    bool isPublic = true,
  }) async {
    final container = AppContainer(session);
    final teacher = await container.resolveCurrentProfile(
      defaultDisplayName: 'Mr. Hassan (Teacher)',
      defaultRole: Role.teacher,
    );
    return container.questionAdminService.createCourse(
      title: title,
      subject: subject,
      topics: topics,
      teacherId: teacher.id,
      teacherName: teacher.displayName,
      isPublic: isPublic,
    );
  }

  /// Updates course visibility (public vs private).
  Future<Course> updateCourseVisibility(
    Session session, {
    required int courseId,
    required bool isPublic,
  }) async {
    final container = AppContainer(session);
    return container.questionAdminService.updateCourseVisibility(
      courseId: courseId,
      isPublic: isPublic,
    );
  }

  /// Lists student subscription requests for a course.
  Future<List<CourseSubscriptionView>> listSubscriptions(
    Session session,
    int courseId,
  ) async {
    final container = AppContainer(session);
    return container.questionAdminService.listSubscriptions(courseId);
  }

  /// Accepts or rejects a student's course subscription request.
  Future<CourseSubscription> respondToSubscription(
    Session session, {
    required int subscriptionId,
    required SubscriptionStatus status,
  }) async {
    final container = AppContainer(session);
    return container.questionAdminService.respondToSubscription(
      subscriptionId: subscriptionId,
      status: status,
    );
  }

  /// Creates a new question with options or accepted answers.
  Future<Question> createQuestion(
    Session session,
    CreateQuestionInput input,
  ) async {
    final container = AppContainer(session);
    return container.questionAdminService.createQuestion(input);
  }

  /// Updates teacher topic explanation note and help hint for a question.
  Future<Question> updateTopicNoteAndHint(
    Session session,
    int questionId, {
    String? topicNote,
    String? helpHint,
  }) async {
    final container = AppContainer(session);
    return container.questionAdminService.updateTopicNoteAndHint(
      questionId: questionId,
      topicNote: topicNote,
      helpHint: helpHint,
    );
  }

  /// Lists all questions belonging to a course.
  Future<List<Question>> listQuestions(Session session, int courseId) async {
    final container = AppContainer(session);
    return container.questionRepo.findByCourseId(courseId);
  }
}
