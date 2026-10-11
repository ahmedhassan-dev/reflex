import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Repository interface for Learner entities.
abstract interface class ILearnerRepository {
  Future<Learner?> findById(int id);
  Future<Learner?> findByAuthUserId(UuidValue authUserId);
  Future<Learner> save(Learner learner);
  Future<List<Learner>> listAll();
}

/// Repository interface for Course entities.
abstract interface class ICourseRepository {
  Future<Course?> findById(int id);
  Future<List<Course>> listAll();
  Future<List<Course>> listByTeacher(int teacherId);
  Future<Course> save(Course course);
}

/// Repository interface for CourseSubscription entities.
abstract interface class ICourseSubscriptionRepository {
  Future<CourseSubscription?> findByCourseAndStudent(int courseId, int studentId);
  Future<List<CourseSubscription>> listByCourse(int courseId);
  Future<List<CourseSubscription>> listByStudent(int studentId);
  Future<CourseSubscription?> findById(int id);
  Future<CourseSubscription> save(CourseSubscription subscription);
}

/// Repository interface for Question entities and atomic counter operations.
abstract interface class IQuestionRepository {
  Future<Question?> findById(int id);
  Future<List<Question>> findByCourseId(int courseId);
  Future<Question> save(Question question);
  Future<void> updateTopicNoteAndHint(int questionId, {String? topicNote, String? helpHint});
  Future<void> applyCounterDeltas(int questionId, QuestionCounterDeltas deltas);
}

/// Repository interface for Multiple Choice Question options.
abstract interface class IQuestionOptionRepository {
  Future<List<QuestionOption>> getOptionsForQuestion(int questionId);
  Future<QuestionOption?> getById(int optionId);
  Future<QuestionOption> save(QuestionOption option);
  Future<void> saveAll(List<QuestionOption> options);
}

/// Repository interface for text-input AcceptedAnswer entities.
abstract interface class IAcceptedAnswerRepository {
  Future<List<AcceptedAnswer>> getByQuestionId(int questionId);
  Future<AcceptedAnswer> save(AcceptedAnswer answer);
  Future<void> saveAll(List<AcceptedAnswer> answers);
}

/// Repository interface for recording and inspecting student Attempts.
abstract interface class IAttemptRepository {
  Future<Attempt> insert(Attempt attempt);
  Future<bool> hasPriorAttempt(int learnerId, int questionId);
  Future<bool> hasLearnerSolvedQuestion(int learnerId, int questionId);
  Future<List<Attempt>> listAttemptsByLearner(int learnerId);
  Future<List<Attempt>> listAttemptsForCourse(int courseId);
}

/// Repository interface for spaced repetition ReviewState entities.
abstract interface class IReviewStateRepository {
  Future<ReviewState?> get(int learnerId, int questionId);
  Future<ReviewState> upsert(ReviewState state);
  Future<List<ReviewState>> findDueReviews({
    required int learnerId,
    required int courseId,
    required DateTime now,
  });
  Future<List<ReviewState>> listByLearner(int learnerId);
  Future<void> markServed(int learnerId, int questionId, DateTime servedAt);
}

/// Repository interface for persisting DemoClock offset days.
abstract interface class IDemoClockRepository {
  Future<int> getOffsetDays();
  Future<void> setOffsetDays(int offsetDays);
}
