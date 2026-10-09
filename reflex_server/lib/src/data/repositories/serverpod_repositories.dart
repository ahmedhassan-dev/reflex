import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'interfaces.dart';

/// Serverpod ORM implementation of [ILearnerRepository].
class ServerpodLearnerRepository implements ILearnerRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodLearnerRepository(this.session, [this.transaction]);

  @override
  Future<Learner?> findById(int id) async {
    return Learner.db.findById(session, id, transaction: transaction);
  }

  @override
  Future<Learner?> findByAuthUserId(UuidValue authUserId) async {
    return Learner.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId),
      transaction: transaction,
    );
  }

  @override
  Future<Learner> save(Learner learner) async {
    if (learner.id != null) {
      return Learner.db.updateRow(session, learner, transaction: transaction);
    }
    return Learner.db.insertRow(session, learner, transaction: transaction);
  }

  @override
  Future<List<Learner>> listAll() async {
    return Learner.db.find(session, transaction: transaction);
  }
}

/// Serverpod ORM implementation of [ICourseRepository].
class ServerpodCourseRepository implements ICourseRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodCourseRepository(this.session, [this.transaction]);

  @override
  Future<Course?> findById(int id) async {
    return Course.db.findById(session, id, transaction: transaction);
  }

  @override
  Future<List<Course>> listAll() async {
    return Course.db.find(session, transaction: transaction);
  }

  @override
  Future<Course> save(Course course) async {
    if (course.id != null) {
      return Course.db.updateRow(session, course, transaction: transaction);
    }
    return Course.db.insertRow(session, course, transaction: transaction);
  }
}

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

/// Serverpod ORM implementation of [IAttemptRepository].
class ServerpodAttemptRepository implements IAttemptRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodAttemptRepository(this.session, [this.transaction]);

  @override
  Future<Attempt> insert(Attempt attempt) async {
    return Attempt.db.insertRow(session, attempt, transaction: transaction);
  }

  @override
  Future<bool> hasPriorAttempt(int learnerId, int questionId) async {
    final count = await Attempt.db.count(
      session,
      where: (t) => t.learnerId.equals(learnerId) & t.questionId.equals(questionId),
      transaction: transaction,
    );
    return count > 0;
  }

  @override
  Future<bool> hasLearnerSolvedQuestion(int learnerId, int questionId) async {
    final count = await Attempt.db.count(
      session,
      where: (t) =>
          t.learnerId.equals(learnerId) &
          t.questionId.equals(questionId) &
          t.status.equals(AttemptStatus.valid),
      transaction: transaction,
    );
    return count > 0;
  }

  @override
  Future<List<Attempt>> listAttemptsByLearner(int learnerId) async {
    return Attempt.db.find(
      session,
      where: (t) => t.learnerId.equals(learnerId),
      orderBy: (t) => t.createdAt,
      transaction: transaction,
    );
  }

  @override
  Future<List<Attempt>> listAttemptsForCourse(int courseId) async {
    final questions = await Question.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
      transaction: transaction,
    );
    final qIds = questions.map((q) => q.id!).toSet();
    if (qIds.isEmpty) return [];

    return Attempt.db.find(
      session,
      where: (t) => t.questionId.inSet(qIds),
      orderBy: (t) => t.createdAt,
      transaction: transaction,
    );
  }
}

/// Serverpod ORM implementation of [IReviewStateRepository].
class ServerpodReviewStateRepository implements IReviewStateRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodReviewStateRepository(this.session, [this.transaction]);

  @override
  Future<ReviewState?> get(int learnerId, int questionId) async {
    return ReviewState.db.findFirstRow(
      session,
      where: (t) => t.learnerId.equals(learnerId) & t.questionId.equals(questionId),
      transaction: transaction,
    );
  }

  @override
  Future<ReviewState> upsert(ReviewState state) async {
    final existing = await get(state.learnerId, state.questionId);
    if (existing != null) {
      final updated = state.copyWith(id: existing.id);
      return ReviewState.db.updateRow(session, updated, transaction: transaction);
    }
    return ReviewState.db.insertRow(session, state, transaction: transaction);
  }

  @override
  Future<List<ReviewState>> findDueReviews({
    required int learnerId,
    required int courseId,
    required DateTime now,
  }) async {
    final questions = await Question.db.find(
      session,
      where: (t) => t.courseId.equals(courseId),
      transaction: transaction,
    );
    final qIds = questions.map((q) => q.id!).toSet();
    if (qIds.isEmpty) return [];

    return ReviewState.db.find(
      session,
      where: (t) =>
          t.learnerId.equals(learnerId) &
          t.questionId.inSet(qIds) &
          (t.dueAt <= now),
      orderBy: (t) => t.dueAt,
      transaction: transaction,
    );
  }

  @override
  Future<List<ReviewState>> listByLearner(int learnerId) async {
    return ReviewState.db.find(
      session,
      where: (t) => t.learnerId.equals(learnerId),
      transaction: transaction,
    );
  }

  @override
  Future<void> markServed(int learnerId, int questionId, DateTime servedAt) async {
    final existing = await get(learnerId, questionId);
    if (existing != null) {
      await ReviewState.db.updateRow(
        session,
        existing.copyWith(lastServedAt: servedAt),
        transaction: transaction,
      );
    }
  }
}

/// Serverpod ORM implementation of [IDemoClockRepository].
class ServerpodDemoClockRepository implements IDemoClockRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodDemoClockRepository(this.session, [this.transaction]);

  @override
  Future<int> getOffsetDays() async {
    final clock = await DemoClock.db.findFirstRow(session, transaction: transaction);
    return clock?.offsetDays ?? 0;
  }

  @override
  Future<void> setOffsetDays(int offsetDays) async {
    final clock = await DemoClock.db.findFirstRow(session, transaction: transaction);
    if (clock != null) {
      await DemoClock.db.updateRow(
        session,
        clock.copyWith(offsetDays: offsetDays),
        transaction: transaction,
      );
    } else {
      await DemoClock.db.insertRow(
        session,
        DemoClock(offsetDays: offsetDays),
        transaction: transaction,
      );
    }
  }
}
