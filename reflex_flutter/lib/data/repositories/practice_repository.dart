import 'package:reflex_client/reflex_client.dart';
import '../../core/result.dart';
import '../../client.dart';

abstract interface class IPracticeRepository {
  Future<Result<PracticeItem?>> serveNextCard(int courseId);
  Future<Result<HelpResult>> requestHelp(int questionId);
  Future<Result<SubmitResult>> submitAnswer(
    int questionId, {
    String? textAnswer,
    int? optionId,
  });
}

class PracticeRepositoryImpl implements IPracticeRepository {
  final Client _client;

  PracticeRepositoryImpl([Client? clientInstance])
      : _client = clientInstance ?? client;

  @override
  Future<Result<PracticeItem?>> serveNextCard(int courseId) async {
    try {
      final item = await _client.practice.serveNextCard(courseId);
      return Result.success(item);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<HelpResult>> requestHelp(int questionId) async {
    try {
      final help = await _client.practice.requestHelp(questionId);
      return Result.success(help);
    } catch (e) {
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
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
