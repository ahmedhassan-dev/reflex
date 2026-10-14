import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Administrative service for teachers to manage courses, questions, notes, and hints.
class QuestionAdminService {
  final IQuestionRepository questionRepo;
  final ICourseRepository? courseRepo;
  final IQuestionOptionRepository? optionRepo;
  final IAcceptedAnswerRepository? acceptedAnswerRepo;
  final ICourseSubscriptionRepository? subscriptionRepo;
  final IProfileRepository? profileRepo;

  QuestionAdminService({
    required this.questionRepo,
    this.courseRepo,
    this.optionRepo,
    this.acceptedAnswerRepo,
    this.subscriptionRepo,
    this.profileRepo,
  });

  /// Lists all available courses.
  Future<List<Course>> listCourses() async {
    if (courseRepo == null) return [];
    return courseRepo!.listAll();
  }

  /// Creates a new course with teacher association and visibility.
  Future<Course> createCourse({
    required String title,
    required String subject,
    List<String>? topics,
    int? teacherId,
    String? teacherName,
    bool isPublic = true,
  }) async {
    final trimmedTitle = title.trim();
    final trimmedSubject = subject.trim();
    if (trimmedTitle.isEmpty) {
      throw const ValidationException('Course title cannot be empty.');
    }
    if (trimmedSubject.isEmpty) {
      throw const ValidationException('Course subject cannot be empty.');
    }
    if (courseRepo == null) {
      throw const ValidationException('Course repository is not configured.');
    }

    final cleanedTopics = topics
        ?.map((t) => t.trim())
        .where((t) => t.isNotEmpty)
        .toList();

    final newCourse = Course(
      title: trimmedTitle,
      subject: trimmedSubject,
      topics: cleanedTopics == null || cleanedTopics.isEmpty ? null : cleanedTopics,
      teacherId: teacherId,
      teacherName: teacherName,
      isPublic: isPublic,
    );
    return courseRepo!.save(newCourse);
  }

  /// Updates course visibility (public vs private).
  Future<Course> updateCourseVisibility({
    required int courseId,
    required bool isPublic,
  }) async {
    if (courseRepo == null) {
      throw const ValidationException('Course repository is not configured.');
    }
    final course = await courseRepo!.findById(courseId);
    if (course == null) throw CourseNotFoundException(courseId);

    final updated = course.copyWith(isPublic: isPublic);
    return courseRepo!.save(updated);
  }

  /// Lists subscription requests for a given course.
  Future<List<CourseSubscriptionView>> listSubscriptions(int courseId) async {
    if (subscriptionRepo == null || courseRepo == null) return [];
    final course = await courseRepo!.findById(courseId);
    if (course == null) throw CourseNotFoundException(courseId);

    final subs = await subscriptionRepo!.listByCourse(courseId);
    final allProfiles = profileRepo != null ? await profileRepo!.listAll() : <Profile>[];
    final profileMap = {for (final l in allProfiles) l.id: l.displayName};

    return subs.map((s) {
      return CourseSubscriptionView(
        id: s.id!,
        courseId: courseId,
        courseTitle: course.title,
        studentId: s.studentId,
        studentName: profileMap[s.studentId] ?? 'Student #${s.studentId}',
        status: s.status,
        requestedAt: s.requestedAt,
        decidedAt: s.decidedAt,
      );
    }).toList();
  }

  /// Accepts or rejects a student's course subscription request.
  Future<CourseSubscription> respondToSubscription({
    required int subscriptionId,
    required SubscriptionStatus status,
  }) async {
    if (subscriptionRepo == null) {
      throw const ValidationException('Subscription repository is not configured.');
    }
    final sub = await subscriptionRepo!.findById(subscriptionId);
    if (sub == null) {
      throw const ValidationException('Subscription not found.');
    }
    final updated = sub.copyWith(
      status: status,
      decidedAt: DateTime.now(),
    );
    return subscriptionRepo!.save(updated);
  }

  /// Creates a new question within a course with optional options or accepted answers.
  Future<Question> createQuestion(CreateQuestionInput input) async {
    final prompt = input.prompt.trim();
    final topic = input.topic.trim();
    if (prompt.isEmpty) {
      throw const ValidationException('Question prompt cannot be empty.');
    }
    if (topic.isEmpty) {
      throw const ValidationException('Topic cannot be empty.');
    }
    if (courseRepo != null) {
      final course = await courseRepo!.findById(input.courseId);
      if (course == null) {
        throw ValidationException('Course with id ${input.courseId} not found.');
      }
    }

    // Determine next position in this course
    final existingQuestions = await questionRepo.findByCourseId(input.courseId);
    final nextPosition = existingQuestions.isEmpty
        ? 1
        : (existingQuestions.map((q) => q.position).reduce((a, b) => a > b ? a : b) + 1);

    String? sanitizedNote;
    if (input.topicNote != null) {
      final t = input.topicNote!.trim();
      if (t.length > 2000) {
        throw const ValidationException('Topic note cannot exceed 2000 characters.');
      }
      sanitizedNote = t.isEmpty ? null : t;
    }

    String? sanitizedHint;
    if (input.helpHint != null) {
      final h = input.helpHint!.trim();
      if (h.length > 2000) {
        throw const ValidationException('Help hint cannot exceed 2000 characters.');
      }
      sanitizedHint = h.isEmpty ? null : h;
    }

    final question = Question(
      courseId: input.courseId,
      position: nextPosition,
      prompt: prompt,
      topic: topic,
      questionType: input.questionType,
      points: input.points > 0 ? input.points : 10,
      expectedSeconds: input.expectedSeconds > 0 ? input.expectedSeconds : 15,
      topicNote: sanitizedNote,
      helpHint: sanitizedHint,
      attemptCount: 0,
      attemptedStudentCount: 0,
      solvedStudentCount: 0,
      firstTrySolveCount: 0,
      underTimeSolveCount: 0,
      cleanSolveCount: 0,
    );

    final savedQuestion = await questionRepo.save(question);

    // Save options if multiple choice
    if (input.questionType == QuestionType.multipleChoice &&
        input.options != null &&
        optionRepo != null) {
      for (var i = 0; i < input.options!.length; i++) {
        final opt = input.options![i];
        final optText = opt.text.trim();
        if (optText.isNotEmpty) {
          await optionRepo!.save(QuestionOption(
            questionId: savedQuestion.id!,
            position: i + 1,
            text: optText,
            isCorrect: opt.isCorrect,
            explanation: opt.explanation?.trim().isEmpty ?? true ? null : opt.explanation!.trim(),
          ));
        }
      }
    }

    // Save accepted answers if text input
    if (input.questionType == QuestionType.textInput &&
        input.acceptedAnswers != null &&
        acceptedAnswerRepo != null) {
      for (final ans in input.acceptedAnswers!) {
        final trimmed = ans.trim();
        if (trimmed.isNotEmpty) {
          await acceptedAnswerRepo!.save(AcceptedAnswer(
            questionId: savedQuestion.id!,
            normalizedText: trimmed.toLowerCase(),
          ));
        }
      }
    }

    return savedQuestion;
  }

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
