import 'package:reflex_server/src/features/practice/domain/score_calculator.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('ScoreCalculator Domain Unit Tests', () {
    test('calculateAwardedPoints returns 0 when attempt is wrong', () {
      final points = ScoreCalculator.calculateAwardedPoints(
        status: AttemptStatus.wrong,
        hasLearnerSolvedBefore: false,
        questionPoints: 10,
      );
      expect(points, equals(0));
    });

    test('calculateAwardedPoints returns question points on first valid solve', () {
      final points = ScoreCalculator.calculateAwardedPoints(
        status: AttemptStatus.valid,
        hasLearnerSolvedBefore: false,
        questionPoints: 10,
      );
      expect(points, equals(10));
    });

    test('calculateAwardedPoints returns 0 when already solved before', () {
      final points = ScoreCalculator.calculateAwardedPoints(
        status: AttemptStatus.valid,
        hasLearnerSolvedBefore: true,
        questionPoints: 10,
      );
      expect(points, equals(0));
    });

    test('calculateTotalScore aggregates points only once per solved question', () async {
      final attemptRepo = FakeAttemptRepository();
      final questionRepo = FakeQuestionRepository();

      await questionRepo.save(Question(
        id: 1,
        courseId: 1,
        position: 1,
        prompt: 'Q1',
        topic: 'Dart',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 10,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));
      await questionRepo.save(Question(
        id: 2,
        courseId: 1,
        position: 2,
        prompt: 'Q2',
        topic: 'Flutter',
        questionType: QuestionType.multipleChoice,
        points: 20,
        expectedSeconds: 15,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));

      // Initially 0
      final score0 = await ScoreCalculator.calculateTotalScore(
        attemptRepo: attemptRepo,
        questionRepo: questionRepo,
        profileId: 1,
        courseId: 1,
      );
      expect(score0, equals(0));

      // Wrong attempt on Q1 -> still 0
      await attemptRepo.insert(Attempt(
        profileId: 1,
        questionId: 1,
        status: AttemptStatus.wrong,
        responseMs: 1200,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.redNeedsWork,
        createdAt: DateTime.now(),
      ));
      final scoreAfterWrong = await ScoreCalculator.calculateTotalScore(
        attemptRepo: attemptRepo,
        questionRepo: questionRepo,
        profileId: 1,
        courseId: 1,
      );
      expect(scoreAfterWrong, equals(0));

      // Correct attempt on Q1 -> 10
      await attemptRepo.insert(Attempt(
        profileId: 1,
        questionId: 1,
        status: AttemptStatus.valid,
        responseMs: 1100,
        usedHelp: false,
        isFirstAttempt: false,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.yellowDeveloping,
        createdAt: DateTime.now(),
      ));
      final scoreAfterFirstCorrect = await ScoreCalculator.calculateTotalScore(
        attemptRepo: attemptRepo,
        questionRepo: questionRepo,
        profileId: 1,
        courseId: 1,
      );
      expect(scoreAfterFirstCorrect, equals(10));

      // Another correct attempt on Q1 -> still 10 (points added only once)
      await attemptRepo.insert(Attempt(
        profileId: 1,
        questionId: 1,
        status: AttemptStatus.valid,
        responseMs: 800,
        usedHelp: false,
        isFirstAttempt: false,
        underExpectedTime: true,
        isClean: false,
        reflexTier: ReflexTier.greenMastered,
        createdAt: DateTime.now(),
      ));
      final scoreAfterSecondCorrect = await ScoreCalculator.calculateTotalScore(
        attemptRepo: attemptRepo,
        questionRepo: questionRepo,
        profileId: 1,
        courseId: 1,
      );
      expect(scoreAfterSecondCorrect, equals(10));

      // Correct attempt on Q2 -> 10 + 20 = 30
      await attemptRepo.insert(Attempt(
        profileId: 1,
        questionId: 2,
        status: AttemptStatus.valid,
        responseMs: 900,
        usedHelp: false,
        isFirstAttempt: true,
        underExpectedTime: true,
        isClean: true,
        reflexTier: ReflexTier.greenMastered,
        createdAt: DateTime.now(),
      ));
      final scoreAfterQ2 = await ScoreCalculator.calculateTotalScore(
        attemptRepo: attemptRepo,
        questionRepo: questionRepo,
        profileId: 1,
        courseId: 1,
      );
      expect(scoreAfterQ2, equals(30));
    });
  });
}
