import 'package:reflex_client/reflex_client.dart';
import '../../core/result.dart';
import '../../client.dart';

abstract interface class IQuestionAdminRepository {
  Future<Result<List<Course>>> listCourses();
  Future<Result<Course>> createCourse({
    required String title,
    required String subject,
    List<String>? topics,
    bool isPublic = true,
  });
  Future<Result<Course>> updateCourseVisibility(int courseId, bool isPublic);
  Future<Result<List<CourseSubscriptionView>>> listSubscriptions(int courseId);
  Future<Result<CourseSubscription>> respondToSubscription(
    int subscriptionId,
    SubscriptionStatus status,
  );
  Future<Result<List<Question>>> listQuestions(int courseId);
  Future<Result<Question>> createQuestion(CreateQuestionInput input);
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
  Future<Result<List<Course>>> listCourses() async {
    try {
      final list = await _client.questionAdmin.listCourses();
      return Result.success(list);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Course>> createCourse({
    required String title,
    required String subject,
    List<String>? topics,
    bool isPublic = true,
  }) async {
    try {
      final course = await _client.questionAdmin.createCourse(
        title: title,
        subject: subject,
        topics: topics,
        isPublic: isPublic,
      );
      return Result.success(course);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Course>> updateCourseVisibility(int courseId, bool isPublic) async {
    try {
      final course = await _client.questionAdmin.updateCourseVisibility(
        courseId: courseId,
        isPublic: isPublic,
      );
      return Result.success(course);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<CourseSubscriptionView>>> listSubscriptions(int courseId) async {
    try {
      final list = await _client.questionAdmin.listSubscriptions(courseId);
      return Result.success(list);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<CourseSubscription>> respondToSubscription(
    int subscriptionId,
    SubscriptionStatus status,
  ) async {
    try {
      final sub = await _client.questionAdmin.respondToSubscription(
        subscriptionId: subscriptionId,
        status: status,
      );
      return Result.success(sub);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

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
  Future<Result<Question>> createQuestion(CreateQuestionInput input) async {
    try {
      final question = await _client.questionAdmin.createQuestion(input);
      return Result.success(question);
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
