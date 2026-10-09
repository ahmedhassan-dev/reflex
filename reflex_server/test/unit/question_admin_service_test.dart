import 'package:test/test.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/features/questions/services/question_admin_service.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-021: QuestionAdminService (Teacher Topic Notes & Hints)', () {
    late FakeQuestionRepository questionRepo;
    late QuestionAdminService service;

    setUp(() async {
      questionRepo = FakeQuestionRepository();
      service = QuestionAdminService(questionRepo: questionRepo);

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
  });
}
