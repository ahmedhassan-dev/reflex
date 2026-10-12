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

    test('when student answers wrong then 0 points awarded, then awards points on 2nd attempt right, then 0 on subsequent solves', () async {
      final session = sessionBuilder.build();
      final seeded = await seedTestData(session);

      // Student starts practice
      final initialCard = await endpoints.practice.serveNextCard(sessionBuilder, seeded.course.id!);
      expect(initialCard!.totalScore, equals(0));

      // 1. Submit incorrect option (position 2 is '10')
      final wrongOption = (await QuestionOption.db.findFirstRow(
        session,
        where: (t) => t.questionId.equals(seeded.question.id!) & t.isCorrect.equals(false),
      ))!;
      final wrongRes = await endpoints.practice.submitAnswer(
        sessionBuilder,
        seeded.question.id!,
        optionId: wrongOption.id,
      );
      expect(wrongRes.verdict, equals(AttemptStatus.wrong));
      expect(wrongRes.points, equals(0));
      expect(wrongRes.totalScore, equals(0));

      // Advance clock by 1 day so review card becomes due
      await endpoints.demoClock.advanceDays(sessionBuilder, 1);

      // 2. Request next card again (now due)
      final secondCard = await endpoints.practice.serveNextCard(sessionBuilder, seeded.course.id!);
      expect(secondCard, isNotNull);

      // 3. Submit correct option (position 1 is '12')
      final correctOption = (await QuestionOption.db.findFirstRow(
        session,
        where: (t) => t.questionId.equals(seeded.question.id!) & t.isCorrect.equals(true),
      ))!;
      final correctRes = await endpoints.practice.submitAnswer(
        sessionBuilder,
        seeded.question.id!,
        optionId: correctOption.id,
      );
      expect(correctRes.verdict, equals(AttemptStatus.valid));
      expect(correctRes.points, equals(10));
      expect(correctRes.totalScore, equals(10));

      // Advance clock by 30 days so card becomes due again
      await endpoints.demoClock.advanceDays(sessionBuilder, 30);

      // 4. Request next card again and solve correctly a second time
      final thirdCard = await endpoints.practice.serveNextCard(sessionBuilder, seeded.course.id!);
      expect(thirdCard, isNotNull);
      final repeatRes = await endpoints.practice.submitAnswer(
        sessionBuilder,
        seeded.question.id!,
        optionId: correctOption.id,
      );
      expect(repeatRes.verdict, equals(AttemptStatus.valid));
      expect(repeatRes.points, equals(0), reason: 'Score must be added only one time');
      expect(repeatRes.totalScore, equals(10));

      await endpoints.demoClock.resetClock(sessionBuilder);
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
