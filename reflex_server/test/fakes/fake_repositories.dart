import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

export 'fake_question_repositories.dart';

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
  Future<void> delete(Learner learner) async {
    _storage.remove(learner.id);
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
  Future<List<Course>> listByTeacher(int teacherId) async =>
      _storage.values.where((c) => c.teacherId == teacherId).toList();

  @override
  Future<Course> save(Course course) async {
    final id = course.id ?? _nextId++;
    if (id >= _nextId) _nextId = id + 1;
    final saved = course.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<void> unassignTeacher(int teacherId) async {
    for (final key in _storage.keys.toList()) {
      if (_storage[key]!.teacherId == teacherId) {
        _storage[key] = _storage[key]!.copyWith(teacherId: null);
      }
    }
  }
}

class FakeCourseSubscriptionRepository implements ICourseSubscriptionRepository {
  final Map<int, CourseSubscription> _storage = {};
  int _nextId = 1;

  @override
  Future<CourseSubscription?> findByCourseAndStudent(int courseId, int studentId) async {
    return _storage.values.cast<CourseSubscription?>().firstWhere(
          (s) => s?.courseId == courseId && s?.studentId == studentId,
          orElse: () => null,
        );
  }

  @override
  Future<List<CourseSubscription>> listByCourse(int courseId) async {
    return _storage.values.where((s) => s.courseId == courseId).toList();
  }

  @override
  Future<List<CourseSubscription>> listByStudent(int studentId) async {
    return _storage.values.where((s) => s.studentId == studentId).toList();
  }

  @override
  Future<CourseSubscription?> findById(int id) async => _storage[id];

  @override
  Future<CourseSubscription> save(CourseSubscription subscription) async {
    final id = subscription.id ?? _nextId++;
    if (id >= _nextId) _nextId = id + 1;
    final saved = subscription.copyWith(id: id);
    _storage[id] = saved;
    return saved;
  }

  @override
  Future<void> deleteByStudentId(int studentId) async {
    _storage.removeWhere((_, sub) => sub.studentId == studentId);
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
  Future<void> deleteByLearnerId(int learnerId) async {
    _attempts.removeWhere((a) => a.learnerId == learnerId);
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

  @override
  Future<void> deleteByLearnerId(int learnerId) async {
    _storage.removeWhere((key, _) => key.startsWith('$learnerId-'));
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
