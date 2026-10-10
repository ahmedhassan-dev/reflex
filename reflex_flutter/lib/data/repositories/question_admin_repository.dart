import 'package:reflex_client/reflex_client.dart';
import '../../core/result.dart';
import '../../client.dart';

abstract interface class IQuestionAdminRepository {
  Future<Result<List<Question>>> listQuestions(int courseId);
  Future<Result<Question>> updateTopicNoteAndHint(
    int questionId, {
    String? topicNote,
    String? helpHint,
  });
}

class QuestionAdminRepositoryImpl implements IQuestionAdminRepository {
  final Client _client;

  QuestionAdminRepositoryImpl([Client? clientInstance])
      : _client = clientInstance ?? client;

  @override
  Future<Result<List<Question>>> listQuestions(int courseId) async {
    try {
      final list = await _client.questionAdmin.listQuestions(courseId);
      return Result.success(list);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Question>> updateTopicNoteAndHint(
    int questionId, {
    String? topicNote,
    String? helpHint,
  }) async {
    try {
      final updated = await _client.questionAdmin.updateTopicNoteAndHint(
        questionId,
        topicNote: topicNote,
        helpHint: helpHint,
      );
      return Result.success(updated);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
