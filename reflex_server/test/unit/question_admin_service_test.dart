import 'package:test/test.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/features/questions/services/question_admin_service.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-021: QuestionAdminService (Teacher Topic Notes & Hints)', () {
    late FakeQuestionRepository questionRepo;
    late FakeCourseRepository courseRepo;
    late FakeQuestionOptionRepository optionRepo;
    late FakeAcceptedAnswerRepository acceptedAnswerRepo;
    late QuestionAdminService service;

    setUp(() async {
      questionRepo = FakeQuestionRepository();
      courseRepo = FakeCourseRepository();
      optionRepo = FakeQuestionOptionRepository();
      acceptedAnswerRepo = FakeAcceptedAnswerRepository();

      service = QuestionAdminService(
        questionRepo: questionRepo,
        courseRepo: courseRepo,
        optionRepo: optionRepo,
        acceptedAnswerRepo: acceptedAnswerRepo,
      );

      await courseRepo.save(Course(
        id: 1,
        title: 'Flutter Mastery',
        subject: 'Mobile Development',
      ));

      await questionRepo.save(Question(
        id: 1,
        courseId: 1,
        position: 1,
        prompt: 'Widget immutability in Flutter',
        topic: 'Widgets',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 15,
        topicNote: 'Initial note',
        helpHint: 'Initial hint',
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));
    });

    test('updateTopicNoteAndHint trims text and updates question', () async {
      final updated = await service.updateTopicNoteAndHint(
        questionId: 1,
        topicNote: '   Updated topic note explaining StatelessWidget.   ',
        helpHint: '   Look at the fields.   ',
      );

      expect(updated.topicNote, equals('Updated topic note explaining StatelessWidget.'));
      expect(updated.helpHint, equals('Look at the fields.'));

      final fromDb = await questionRepo.findById(1);
      expect(fromDb!.topicNote, equals('Updated topic note explaining StatelessWidget.'));
      expect(fromDb.helpHint, equals('Look at the fields.'));
    });

    test('updateTopicNoteAndHint with empty or whitespace string sets fields to null', () async {
      final updated = await service.updateTopicNoteAndHint(
        questionId: 1,
        topicNote: '   ',
        helpHint: '',
      );

      expect(updated.topicNote, isNull);
      expect(updated.helpHint, isNull);

      final fromDb = await questionRepo.findById(1);
      expect(fromDb!.topicNote, isNull);
      expect(fromDb.helpHint, isNull);
    });

    test('updateTopicNoteAndHint throws ValidationException if topicNote exceeds 2000 chars', () async {
      final longNote = 'A' * 2001;

      expect(
        () => service.updateTopicNoteAndHint(questionId: 1, topicNote: longNote),
        throwsA(isA<ValidationException>()),
      );
    });

    test('updateTopicNoteAndHint throws ValidationException if helpHint exceeds 2000 chars', () async {
      final longHint = 'B' * 2001;

      expect(
        () => service.updateTopicNoteAndHint(questionId: 1, helpHint: longHint),
        throwsA(isA<ValidationException>()),
      );
    });

    test('updateTopicNoteAndHint throws QuestionNotFoundException if question does not exist', () async {
      expect(
        () => service.updateTopicNoteAndHint(questionId: 999, topicNote: 'Valid note'),
        throwsA(isA<QuestionNotFoundException>()),
      );
    });

    test('createCourse creates course with trimmed title and subject', () async {
      final course = await service.createCourse(
        title: '   Math 101   ',
        subject: '   Mathematics   ',
        topics: ['Algebra', 'Calculus', ' '],
      );

      expect(course.title, equals('Math 101'));
      expect(course.subject, equals('Mathematics'));
      expect(course.topics, equals(['Algebra', 'Calculus']));
      expect(course.id, isNotNull);

      final list = await service.listCourses();
      expect(list.length, equals(2));
    });

    test('createCourse rejects empty title or subject', () async {
      expect(
        () => service.createCourse(title: '  ', subject: 'Math'),
        throwsA(isA<ValidationException>()),
      );
      expect(
        () => service.createCourse(title: 'Math', subject: '  '),
        throwsA(isA<ValidationException>()),
      );
    });

    test('createQuestion adds multiple choice question with options', () async {
      final input = CreateQuestionInput(
        courseId: 1,
        prompt: 'What is 2 + 2?',
        topic: 'Arithmetic',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 10,
        topicNote: 'Basic addition.',
        helpHint: 'Count fingers.',
        options: [
          CreateOptionInput(text: '4', isCorrect: true, explanation: 'Correct answer'),
          CreateOptionInput(text: '5', isCorrect: false, explanation: 'Incorrect'),
        ],
      );

      final created = await service.createQuestion(input);
      expect(created.id, isNotNull);
      expect(created.prompt, equals('What is 2 + 2?'));
      expect(created.position, equals(2)); // Position 1 already exists

      final opts = await optionRepo.getOptionsForQuestion(created.id!);
      expect(opts.length, equals(2));
      expect(opts.first.text, equals('4'));
      expect(opts.first.isCorrect, isTrue);
    });

    test('createQuestion adds text input question with accepted answers', () async {
      final input = CreateQuestionInput(
        courseId: 1,
        prompt: 'Capital of France?',
        topic: 'Geography',
        questionType: QuestionType.textInput,
        points: 15,
        expectedSeconds: 12,
        acceptedAnswers: ['paris', 'Paris '],
      );

      final created = await service.createQuestion(input);
      expect(created.id, isNotNull);
      expect(created.questionType, equals(QuestionType.textInput));

      final answers = await acceptedAnswerRepo.getByQuestionId(created.id!);
      expect(answers.length, equals(2));
      expect(answers.first.normalizedText, equals('paris'));
    });

    test('listCourses with teacherId isolates courses per teacher', () async {
      await courseRepo.save(Course(
        id: 10,
        title: 'Teacher 1 Course',
        subject: 'CS',
        teacherId: 1,
      ));
      await courseRepo.save(Course(
        id: 20,
        title: 'Teacher 2 Course',
        subject: 'Math',
        teacherId: 2,
      ));

      final teacher1Courses = await service.listCourses(teacherId: 1);
      expect(teacher1Courses.any((c) => c.id == 10), isTrue);
      expect(teacher1Courses.any((c) => c.id == 20), isFalse);

      final teacher2Courses = await service.listCourses(teacherId: 2);
      expect(teacher2Courses.any((c) => c.id == 20), isTrue);
      expect(teacher2Courses.any((c) => c.id == 10), isFalse);
    });

    test('createQuestion blocks teacher from modifying other teachers course', () async {
      await courseRepo.save(Course(
        id: 50,
        title: 'Teacher 1 Private Deck',
        subject: 'Algorithms',
        teacherId: 1,
      ));

      final input = CreateQuestionInput(
        courseId: 50,
        prompt: 'What is quicksort?',
        topic: 'Sorting',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 10,
      );

      // Teacher 2 tries to add a question to Teacher 1's course
      expect(
        () => service.createQuestion(input, teacherId: 2),
        throwsA(isA<CourseAccessDeniedException>()),
      );

      // Teacher 1 succeeds
      final created = await service.createQuestion(input, teacherId: 1);
      expect(created.id, isNotNull);
    });

    test('updateTopicNoteAndHint blocks teacher from editing another teachers question', () async {
      await courseRepo.save(Course(
        id: 60,
        title: 'Teacher 1 Bio',
        subject: 'Science',
        teacherId: 1,
      ));
      await questionRepo.save(Question(
        id: 99,
        courseId: 60,
        position: 1,
        prompt: 'Cell structure',
        topic: 'Biology',
        questionType: QuestionType.textInput,
        points: 10,
        expectedSeconds: 10,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));

      // Teacher 2 tries to edit note
      expect(
        () => service.updateTopicNoteAndHint(
          questionId: 99,
          topicNote: 'Hacked note',
          teacherId: 2,
        ),
        throwsA(isA<CourseAccessDeniedException>()),
      );

      // Teacher 1 succeeds
      final updated = await service.updateTopicNoteAndHint(
        questionId: 99,
        topicNote: 'Teacher 1 approved note',
        teacherId: 1,
      );
      expect(updated.topicNote, equals('Teacher 1 approved note'));
    });
  });
}
