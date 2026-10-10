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
      );

      expect(course.title, equals('Math 101'));
      expect(course.subject, equals('Mathematics'));
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
  });
}
