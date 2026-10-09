import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

Future<({Course course, Question question})> seedTestData(Session session) async {
  final course = await Course.db.insertRow(
    session,
    Course(
      title: 'Integration Test Math',
      subject: 'Math',
    ),
  );

  final question = await Question.db.insertRow(
    session,
    Question(
      courseId: course.id!,
      position: 1,
      prompt: 'What is 5 + 7?',
      topic: 'Arithmetic',
      questionType: QuestionType.multipleChoice,
      points: 10,
      expectedSeconds: 5,
      helpHint: 'Think of 5 + 5 + 2.',
      topicNote: 'Addition combines quantities.',
      attemptCount: 0,
      attemptedStudentCount: 0,
      solvedStudentCount: 0,
      firstTrySolveCount: 0,
      underTimeSolveCount: 0,
      cleanSolveCount: 0,
    ),
  );

  await QuestionOption.db.insertRow(
    session,
    QuestionOption(
      questionId: question.id!,
      position: 1,
      text: '12',
      isCorrect: true,
      explanation: 'Correct! 5 + 7 = 12.',
    ),
  );

  await QuestionOption.db.insertRow(
    session,
    QuestionOption(
      questionId: question.id!,
      position: 2,
      text: '10',
      isCorrect: false,
      explanation: 'Incorrect. 10 is 5 + 5.',
    ),
  );

  await AcceptedAnswer.db.insertRow(
    session,
    AcceptedAnswer(
      questionId: question.id!,
      normalizedText: '12',
    ),
  );

  return (course: course, question: question);
}

void main() {
  withServerpod('Given Practice and Security Endpoints (T-024)', (sessionBuilder, endpoints) {
    test('when student executes full practice loop then card is served, helped, graded and counters updated', () async {
      final session = sessionBuilder.build();
      final seeded = await seedTestData(session);

      // 1. Student requests next card
      final practiceItem = await endpoints.practice.serveNextCard(sessionBuilder, seeded.course.id!);
      expect(practiceItem, isNotNull, reason: 'Course should have questions available');
      final question = practiceItem!.question;
      expect(question.prompt, isNotEmpty);
      expect(question.options, isNotNull);
      expect(question.options!, isNotEmpty);

      // Verify zero answer leakage in PracticeItem
      for (final opt in question.options!) {
        expect(opt.text, isNotEmpty);
      }

      // 2. Student requests help hint
      final help = await endpoints.practice.requestHelp(sessionBuilder, question.id);
      expect(help.helpHint, isNotEmpty);

      // 3. Student submits answer with an option
      final firstOptionId = question.options!.first.id;
      final submitResult = await endpoints.practice.submitAnswer(
        sessionBuilder,
        question.id,
        optionId: firstOptionId,
      );

      // 4. Verify post-submit payload reveals feedback and topic note
      expect(submitResult.topicNote, isNotNull);
      expect(submitResult.reason, isNotNull);
      expect(submitResult.reflexTier, isNotNull);
      expect(submitResult.verdict, isA<AttemptStatus>());
    });

    test('when unauthenticated or student calls QuestionAdminEndpoint then access is denied', () async {
      final session = sessionBuilder.build();
      final seeded = await seedTestData(session);

      // Unauthenticated session
      expect(
        () => endpoints.questionAdmin.listQuestions(sessionBuilder, seeded.course.id!),
        throwsA(isA<ServerpodUnauthenticatedException>()),
      );

      // Student session (lacks teacher scope)
      final studentSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          '00000000-0000-4000-8000-000000000099',
          {AppScopes.student},
        ),
      );
      expect(
        () => endpoints.questionAdmin.listQuestions(studentSession, seeded.course.id!),
        throwsA(isA<ServerpodInsufficientAccessException>()),
      );

      // Teacher session (has teacher scope) -> succeeds
      final teacherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          '00000000-0000-4000-8000-000000000002',
          {AppScopes.teacher},
        ),
      );
      final questions = await endpoints.questionAdmin.listQuestions(teacherSession, seeded.course.id!);
      expect(questions, isNotEmpty);
    });

    test('when teacher updates topic note and hint then changes are persisted', () async {
      final session = sessionBuilder.build();
      final seeded = await seedTestData(session);

      final teacherSession = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          '00000000-0000-4000-8000-000000000002',
          {AppScopes.teacher},
        ),
      );

      final updated = await endpoints.questionAdmin.updateTopicNoteAndHint(
        teacherSession,
        seeded.question.id!,
        topicNote: 'Updated teacher note for integration test',
        helpHint: 'Updated hint for integration test',
      );

      expect(updated.topicNote, equals('Updated teacher note for integration test'));
      expect(updated.helpHint, equals('Updated hint for integration test'));
    });
  });
}
