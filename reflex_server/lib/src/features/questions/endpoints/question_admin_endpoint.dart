import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Endpoint allowing teachers to inspect questions, update topic notes, and manage hints.
class QuestionAdminEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  @override
  Set<Scope> get requiredScopes => {AppScopes.teacher};

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
