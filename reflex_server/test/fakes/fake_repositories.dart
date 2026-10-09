import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

class FakeLearnerRepository implements ILearnerRepository {
  final Map<int, Learner> _storage = {};
  int _nextId = 1;

  @override
  Future<Learner?> findById(int id) async => _storage[id];

  @override
  Future<Learner?> findByAuthUserId(UuidValue authUserId) async {
    for (final learner in _storage.values) {
      if (learner.authUserId == authUserId) return learner;
    }
    return null;
  }

  @override
  Future<Learner> save(Learner learner) async {
    final id = learner.id ?? _nextId++;
    final saved = learner.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<List<Learner>> listAll() async => _storage.values.toList();
}

class FakeCourseRepository implements ICourseRepository {
  final Map<int, Course> _storage = {};
  int _nextId = 1;

  @override
  Future<Course?> findById(int id) async => _storage[id];

  @override
  Future<List<Course>> listAll() async => _storage.values.toList();

  @override
  Future<Course> save(Course course) async {
    final id = course.id ?? _nextId++;
    final saved = course.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }
}

class FakeQuestionRepository implements IQuestionRepository {
  final Map<int, Question> _storage = {};
  int _nextId = 1;

  @override
  Future<Question?> findById(int id) async => _storage[id];

  @override
  Future<List<Question>> findByCourseId(int courseId) async {
    final list = _storage.values.where((q) => q.courseId == courseId).toList();
    list.sort((a, b) => a.position.compareTo(b.position));
    return list;
  }

  @override
  Future<Question> save(Question question) async {
    final id = question.id ?? _nextId++;
    final saved = question.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<void> updateTopicNoteAndHint(int questionId, {String? topicNote, String? helpHint}) async {
    final q = _storage[questionId];
    if (q != null) {
      _storage[questionId] = q.copyWith(
        topicNote: topicNote ?? q.topicNote,
        helpHint: helpHint ?? q.helpHint,
      );
    }
  }

  @override
  Future<void> applyCounterDeltas(int questionId, QuestionCounterDeltas deltas) async {
    final q = _storage[questionId];
    if (q != null) {
      _storage[questionId] = q.copyWith(
        attemptCount: q.attemptCount + deltas.attemptCountDelta,
        attemptedStudentCount: q.attemptedStudentCount + deltas.attemptedStudentCountDelta,
        solvedStudentCount: q.solvedStudentCount + deltas.solvedStudentCountDelta,
        firstTrySolveCount: q.firstTrySolveCount + deltas.firstTrySolveCountDelta,
        underTimeSolveCount: q.underTimeSolveCount + deltas.underTimeSolveCountDelta,
        cleanSolveCount: q.cleanSolveCount + deltas.cleanSolveCountDelta,
      );
    }
  }
}

class FakeQuestionOptionRepository implements IQuestionOptionRepository {
  final Map<int, QuestionOption> _storage = {};
  int _nextId = 1;

  @override
  Future<List<QuestionOption>> getOptionsForQuestion(int questionId) async {
    final list = _storage.values.where((o) => o.questionId == questionId).toList();
    list.sort((a, b) => a.position.compareTo(b.position));
    return list;
  }

  @override
  Future<QuestionOption?> getById(int optionId) async => _storage[optionId];

  @override
  Future<QuestionOption> save(QuestionOption option) async {
    final id = option.id ?? _nextId++;
    final saved = option.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<void> saveAll(List<QuestionOption> options) async {
    for (final opt in options) {
      await save(opt);
    }
  }
}

class FakeAcceptedAnswerRepository implements IAcceptedAnswerRepository {
  final Map<int, AcceptedAnswer> _storage = {};
  int _nextId = 1;

  @override
  Future<List<AcceptedAnswer>> getByQuestionId(int questionId) async {
    return _storage.values.where((a) => a.questionId == questionId).toList();
  }

  @override
  Future<AcceptedAnswer> save(AcceptedAnswer answer) async {
    final id = answer.id ?? _nextId++;
    final saved = answer.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<void> saveAll(List<AcceptedAnswer> answers) async {
    for (final ans in answers) {
      await save(ans);
    }
  }
}

class FakeAttemptRepository implements IAttemptRepository {
  final List<Attempt> _attempts = [];
  int _nextId = 1;

  @override
  Future<Attempt> insert(Attempt attempt) async {
    final id = attempt.id ?? _nextId++;
    final saved = attempt.copyWith(id: id);
    _attempts.add(saved);
    return saved;
  }

  @override
  Future<bool> hasPriorAttempt(int learnerId, int questionId) async {
    return _attempts.any((a) => a.learnerId == learnerId && a.questionId == questionId);
  }

  @override
  Future<bool> hasLearnerSolvedQuestion(int learnerId, int questionId) async {
    return _attempts.any(
      (a) => a.learnerId == learnerId && a.questionId == questionId && a.status == AttemptStatus.valid,
    );
  }

  @override
  Future<List<Attempt>> listAttemptsByLearner(int learnerId) async {
    return _attempts.where((a) => a.learnerId == learnerId).toList();
  }

  @override
  Future<List<Attempt>> listAttemptsForCourse(int courseId) async {
    return List.unmodifiable(_attempts);
  }
}

class FakeReviewStateRepository implements IReviewStateRepository {
  final Map<String, ReviewState> _storage = {};
  int _nextId = 1;

  String _key(int learnerId, int questionId) => '$learnerId-$questionId';

  @override
  Future<ReviewState?> get(int learnerId, int questionId) async {
    return _storage[_key(learnerId, questionId)];
  }

  @override
  Future<ReviewState> upsert(ReviewState state) async {
    final id = state.id ?? _nextId++;
    final saved = state.copyWith(id: id);
    _storage[_key(state.learnerId, state.questionId)] = saved;
    return saved;
  }

  @override
  Future<List<ReviewState>> findDueReviews({
    required int learnerId,
    required int courseId,
    required DateTime now,
  }) async {
    final list = _storage.values
        .where((r) => r.learnerId == learnerId && !r.dueAt.isAfter(now))
        .toList();
    list.sort((a, b) => a.dueAt.compareTo(b.dueAt));
    return list;
  }

  @override
  Future<List<ReviewState>> listByLearner(int learnerId) async {
    return _storage.values.where((r) => r.learnerId == learnerId).toList();
  }

  @override
  Future<void> markServed(int learnerId, int questionId, DateTime servedAt) async {
    final key = _key(learnerId, questionId);
    final existing = _storage[key];
    if (existing != null) {
      _storage[key] = existing.copyWith(lastServedAt: servedAt);
    }
  }
}

class FakeDemoClockRepository implements IDemoClockRepository {
  int _offsetDays = 0;

  @override
  Future<int> getOffsetDays() async => _offsetDays;

  @override
  Future<void> setOffsetDays(int offsetDays) async {
    _offsetDays = offsetDays;
  }
}
