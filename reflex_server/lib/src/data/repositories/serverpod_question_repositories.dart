import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'interfaces.dart';

/// Serverpod ORM implementation of [IQuestionRepository].
class ServerpodQuestionRepository implements IQuestionRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodQuestionRepository(this.session, [this.transaction]);

  @override
  Future<Question?> findById(int id) async {
    return Question.db.findById(session, id, transaction: transaction);
  }

  @override
  Future<List<Question>> findByCourseId(int courseId) async {
    return Question.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
      orderBy: (t) => t.position,
      transaction: transaction,
    );
  }

  @override
  Future<Question> save(Question question) async {
    if (question.id != null) {
      return Question.db.updateRow(session, question, transaction: transaction);
    }
    return Question.db.insertRow(session, question, transaction: transaction);
  }

  @override
  Future<void> updateTopicNoteAndHint(
    int questionId, {
    String? topicNote,
    String? helpHint,
  }) async {
    final existing = await findById(questionId);
    if (existing == null) return;

    final updated = existing.copyWith(
      topicNote: topicNote,
      helpHint: helpHint,
    );
    await save(updated);
  }

  @override
  Future<void> applyCounterDeltas(
    int questionId,
    QuestionCounterDeltas deltas,
  ) async {
    const query = '''
UPDATE question
SET "attemptCount" = "attemptCount" + @dAttemptCount,
    "attemptedStudentCount" = "attemptedStudentCount" + @dAttemptedStudentCount,
    "solvedStudentCount" = "solvedStudentCount" + @dSolvedStudentCount,
    "firstTrySolveCount" = "firstTrySolveCount" + @dFirstTrySolveCount,
    "underTimeSolveCount" = "underTimeSolveCount" + @dUnderTimeSolveCount,
    "cleanSolveCount" = "cleanSolveCount" + @dCleanSolveCount
WHERE id = @id;
''';

    await session.db.unsafeExecute(
      query,
      parameters: QueryParameters.named({
        'dAttemptCount': deltas.attemptCountDelta,
        'dAttemptedStudentCount': deltas.attemptedStudentCountDelta,
        'dSolvedStudentCount': deltas.solvedStudentCountDelta,
        'dFirstTrySolveCount': deltas.firstTrySolveCountDelta,
        'dUnderTimeSolveCount': deltas.underTimeSolveCountDelta,
        'dCleanSolveCount': deltas.cleanSolveCountDelta,
        'id': questionId,
      }),
      transaction: transaction,
    );
  }
}

/// Serverpod ORM implementation of [IQuestionOptionRepository].
class ServerpodQuestionOptionRepository implements IQuestionOptionRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodQuestionOptionRepository(this.session, [this.transaction]);

  @override
  Future<List<QuestionOption>> getOptionsForQuestion(int questionId) async {
    return QuestionOption.db.find(
      session,
      where: (t) => t.questionId.equals(questionId),
      orderBy: (t) => t.position,
      transaction: transaction,
    );
  }

  @override
  Future<QuestionOption?> getById(int optionId) async {
    return QuestionOption.db.findById(session, optionId, transaction: transaction);
  }

  @override
  Future<QuestionOption> save(QuestionOption option) async {
    if (option.id != null) {
      return QuestionOption.db.updateRow(session, option, transaction: transaction);
    }
    return QuestionOption.db.insertRow(session, option, transaction: transaction);
  }

  @override
  Future<void> saveAll(List<QuestionOption> options) async {
    for (final opt in options) {
      await save(opt);
    }
  }
}

/// Serverpod ORM implementation of [IAcceptedAnswerRepository].
class ServerpodAcceptedAnswerRepository implements IAcceptedAnswerRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodAcceptedAnswerRepository(this.session, [this.transaction]);

  @override
  Future<List<AcceptedAnswer>> getByQuestionId(int questionId) async {
    return AcceptedAnswer.db.find(
      session,
      where: (t) => t.questionId.equals(questionId),
      transaction: transaction,
    );
  }

  @override
  Future<AcceptedAnswer> save(AcceptedAnswer answer) async {
    if (answer.id != null) {
      return AcceptedAnswer.db.updateRow(session, answer, transaction: transaction);
    }
    return AcceptedAnswer.db.insertRow(session, answer, transaction: transaction);
  }

  @override
  Future<void> saveAll(List<AcceptedAnswer> answers) async {
    for (final ans in answers) {
      await save(ans);
    }
  }
}
