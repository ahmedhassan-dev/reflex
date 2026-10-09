import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Administrative service for teachers to manage question notes and hints.
class QuestionAdminService {
  final IQuestionRepository questionRepo;

  QuestionAdminService({required this.questionRepo});

  /// Updates teacher topic explanation note and student help hint.
  ///
  /// - Trims whitespace
  /// - Enforces maximum length of 2000 characters
  /// - Converts empty or whitespace-only strings to null
  Future<Question> updateTopicNoteAndHint({
    required int questionId,
    String? topicNote,
    String? helpHint,
  }) async {
    final existing = await questionRepo.findById(questionId);
    if (existing == null) {
      throw QuestionNotFoundException(questionId);
    }

    String? sanitizedNote;
    if (topicNote != null) {
      final trimmed = topicNote.trim();
      if (trimmed.length > 2000) {
        throw const ValidationException('Topic note cannot exceed 2000 characters.');
      }
      sanitizedNote = trimmed.isEmpty ? null : trimmed;
    } else {
      sanitizedNote = existing.topicNote;
    }

    String? sanitizedHint;
    if (helpHint != null) {
      final trimmed = helpHint.trim();
      if (trimmed.length > 2000) {
        throw const ValidationException('Help hint cannot exceed 2000 characters.');
      }
      sanitizedHint = trimmed.isEmpty ? null : trimmed;
    } else {
      sanitizedHint = existing.helpHint;
    }

    final updated = existing.copyWith(
      topicNote: sanitizedNote,
      helpHint: sanitizedHint,
    );

    return questionRepo.save(updated);
  }
}
