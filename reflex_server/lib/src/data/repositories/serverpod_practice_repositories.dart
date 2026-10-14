import 'package:serverpod/serverpod.dart';
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

  @override
  Future<void> delete(Learner learner) async {
    await Learner.db.deleteRow(session, learner, transaction: transaction);
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
  Future<void> deleteByLearnerId(int learnerId) async {
    await Attempt.db.deleteWhere(
      session,
      where: (t) => t.learnerId.equals(learnerId),
      transaction: transaction,
    );
  }

  @override
  Future<bool> hasPriorAttempt(int learnerId, int questionId) async {
    final count = await Attempt.db.count(
      session,
      where: (t) =>
          t.learnerId.equals(learnerId) & t.questionId.equals(questionId),
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
      where: (t) =>
          t.learnerId.equals(learnerId) & t.questionId.equals(questionId),
      transaction: transaction,
    );
  }

  @override
  Future<ReviewState> upsert(ReviewState state) async {
    final existing = await get(state.learnerId, state.questionId);
    if (existing != null) {
      final updated = state.copyWith(id: existing.id);
      return ReviewState.db
          .updateRow(session, updated, transaction: transaction);
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
  Future<void> markServed(
      int learnerId, int questionId, DateTime servedAt) async {
    final existing = await get(learnerId, questionId);
    if (existing != null) {
      await ReviewState.db.updateRow(
        session,
        existing.copyWith(lastServedAt: servedAt),
        transaction: transaction,
      );
    }
  }

  @override
  Future<void> deleteByLearnerId(int learnerId) async {
    await ReviewState.db.deleteWhere(
      session,
      where: (t) => t.learnerId.equals(learnerId),
      transaction: transaction,
    );
  }
}

/// Serverpod ORM implementation of [IDemoClockRepository].
class ServerpodDemoClockRepository implements IDemoClockRepository {
  final Session session;
  final Transaction? transaction;

  const ServerpodDemoClockRepository(this.session, [this.transaction]);

  @override
  Future<int> getOffsetDays() async {
    final clock =
        await DemoClock.db.findFirstRow(session, transaction: transaction);
    return clock?.offsetDays ?? 0;
  }

  @override
  Future<void> setOffsetDays(int offsetDays) async {
    final clock =
        await DemoClock.db.findFirstRow(session, transaction: transaction);
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
