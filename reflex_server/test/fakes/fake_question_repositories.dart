import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

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
    if (id >= _nextId) _nextId = id + 1;
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
