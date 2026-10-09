import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'test_tools/serverpod_test_tools.dart';

Future<({Course course, Question question})> seedConcurrencyTestData(Session session) async {
  final course = await Course.db.insertRow(
    session,
    Course(
      title: 'Concurrency Benchmark Course',
      subject: 'Math',
    ),
  );

  final question = await Question.db.insertRow(
    session,
    Question(
      courseId: course.id!,
      position: 1,
      prompt: 'What is 6 x 7?',
      topic: 'Multiplication',
      questionType: QuestionType.textInput,
      points: 10,
      expectedSeconds: 10,
      helpHint: 'Think of 6 x 6 + 6.',
      topicNote: 'Multiplication is repeated addition.',
      attemptCount: 0,
      attemptedStudentCount: 0,
      solvedStudentCount: 0,
      firstTrySolveCount: 0,
      underTimeSolveCount: 0,
      cleanSolveCount: 0,
    ),
  );

  await AcceptedAnswer.db.insertRow(
    session,
    AcceptedAnswer(
      questionId: question.id!,
      normalizedText: '42',
    ),
  );

  return (course: course, question: question);
}

void main() {
  withServerpod('Given Concurrent Student Submissions (T-025)', rollbackDatabase: RollbackDatabase.disabled, (sessionBuilder, endpoints) {
    test('when 10 students submit concurrently then atomic counters match attempt rows with zero drift', () async {
      final session = sessionBuilder.build();
      final seeded = await seedConcurrencyTestData(session);
      const studentCount = 10;

      // 1. Create sessions and serve cards for 10 distinct students
      final studentSessions = <TestSessionBuilder>[];
      for (var i = 1; i <= studentCount; i++) {
        final padded = i.toString().padLeft(2, '0');
        final authId = '00000000-0000-4000-8000-0000000000$padded';
        final studentSession = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo(
            authId,
            {AppScopes.student},
          ),
        );
        studentSessions.add(studentSession);

        // Serve next card to initialize ReviewState & stamp lastServedAt
        final card = await endpoints.practice.serveNextCard(studentSession, seeded.course.id!);
        expect(card, isNotNull);
        expect(card!.question.id, equals(seeded.question.id!));
      }

      // 2. Submit 10 answers concurrently via Future.wait
      final submitFutures = List.generate(studentCount, (i) {
        return endpoints.practice.submitAnswer(
          studentSessions[i],
          seeded.question.id!,
          textAnswer: '42',
        );
      });

      final results = await Future.wait(submitFutures);
      expect(results.length, equals(studentCount));
      for (final res in results) {
        expect(res.verdict, equals(AttemptStatus.valid));
      }

      // 3. Query Question atomic counters and verify exact invariant
      final refreshedQ = await Question.db.findById(session, seeded.question.id!);
      expect(refreshedQ, isNotNull);
      expect(refreshedQ!.attemptCount, equals(studentCount),
          reason: 'Raw SQL atomic counter must increment by exactly 10 without race condition loss');
      expect(refreshedQ.attemptedStudentCount, equals(studentCount));
      expect(refreshedQ.solvedStudentCount, equals(studentCount));
      expect(refreshedQ.cleanSolveCount, equals(studentCount));

      // 4. Assert invariant: attemptCount exactly equals COUNT(*) FROM attempt WHERE questionId = id
      final actualAttemptRows = await Attempt.db.count(
        session,
        where: (t) => t.questionId.equals(seeded.question.id!),
      );
      expect(refreshedQ.attemptCount, equals(actualAttemptRows),
          reason: 'Counter invariant must strictly match persisted row count');
    });
  });
}
