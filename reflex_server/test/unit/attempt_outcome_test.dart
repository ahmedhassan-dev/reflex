import 'package:reflex_server/src/features/practice/domain/attempt_outcome.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('T-014: AttemptOutcomeCalculator & Reflex Tier Classifier', () {
    test('wrong answer gives ResultReason.wrong, interval +1d, lapses+1, ReflexTier.redNeedsWork', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.wrong,
        usedHelp: false,
        responseMs: 5000,
        expectedSeconds: 30,
        isFirstAttempt: true,
        isFirstSolveByStudent: false,
      );

      expect(outcome.reason, equals(ResultReason.wrong));
      expect(outcome.reflexTier, equals(ReflexTier.redNeedsWork));
      expect(outcome.intervalDays, equals(1));
      expect(outcome.lapsesDelta, equals(1));
      expect(outcome.isClean, isFalse);
    });

    test('correct with help gives ResultReason.correctWithHelp, interval +1d, lapses unchanged, isClean false, ReflexTier.yellowDeveloping', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: true,
        responseMs: 8000,
        expectedSeconds: 30,
        isFirstAttempt: true,
        isFirstSolveByStudent: true,
      );

      expect(outcome.reason, equals(ResultReason.correctWithHelp));
      expect(outcome.reflexTier, equals(ReflexTier.yellowDeveloping));
      expect(outcome.intervalDays, equals(1));
      expect(outcome.lapsesDelta, equals(0));
      expect(outcome.isClean, isFalse);
    });

    test('correct without help but slow gives ResultReason.correctSlow, interval +2d, isClean false, ReflexTier.yellowDeveloping', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 35000,
        expectedSeconds: 30,
        isFirstAttempt: true,
        isFirstSolveByStudent: true,
      );

      expect(outcome.reason, equals(ResultReason.correctSlow));
      expect(outcome.reflexTier, equals(ReflexTier.yellowDeveloping));
      expect(outcome.intervalDays, equals(2));
      expect(outcome.lapsesDelta, equals(0));
      expect(outcome.underExpectedTime, isFalse);
      expect(outcome.isClean, isFalse);
    });

    test('correct without help, first attempt, under time gives ResultReason.correctClean, interval +30d, isClean true, ReflexTier.greenMastered', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 12000,
        expectedSeconds: 30,
        isFirstAttempt: true,
        isFirstSolveByStudent: true,
      );

      expect(outcome.reason, equals(ResultReason.correctClean));
      expect(outcome.reflexTier, equals(ReflexTier.greenMastered));
      expect(outcome.intervalDays, equals(30));
      expect(outcome.lapsesDelta, equals(0));
      expect(outcome.underExpectedTime, isTrue);
      expect(outcome.isClean, isTrue);
    });

    test('boundary: responseMs == expectedSeconds*1000 counts as underExpectedTime', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 30000,
        expectedSeconds: 30,
        isFirstAttempt: true,
        isFirstSolveByStudent: true,
      );

      expect(outcome.underExpectedTime, isTrue);
      expect(outcome.reason, equals(ResultReason.correctClean));
      expect(outcome.reflexTier, equals(ReflexTier.greenMastered));
    });

    test('calculates correct question counter deltas on first clean attempt', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 10000,
        expectedSeconds: 20,
        isFirstAttempt: true,
        isFirstSolveByStudent: true,
      );

      final deltas = outcome.counterDeltas;
      expect(deltas.attemptCountDelta, equals(1));
      expect(deltas.attemptedStudentCountDelta, equals(1));
      expect(deltas.solvedStudentCountDelta, equals(1));
      expect(deltas.firstTrySolveCountDelta, equals(1));
      expect(deltas.underTimeSolveCountDelta, equals(1));
      expect(deltas.cleanSolveCountDelta, equals(1));
    });

    test('calculates correct question counter deltas on subsequent attempt after earlier wrong', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 15000,
        expectedSeconds: 20,
        isFirstAttempt: false,
        isFirstSolveByStudent: true,
      );

      final deltas = outcome.counterDeltas;
      expect(deltas.attemptCountDelta, equals(1));
      expect(deltas.attemptedStudentCountDelta, equals(0));
      expect(deltas.solvedStudentCountDelta, equals(1));
      expect(deltas.firstTrySolveCountDelta, equals(0));
      expect(deltas.underTimeSolveCountDelta, equals(1));
      expect(deltas.cleanSolveCountDelta, equals(0));
    });

    test('calculates correct question counter deltas on repeat solve by same student', () {
      final outcome = AttemptOutcomeCalculator.calculate(
        status: AttemptStatus.valid,
        usedHelp: false,
        responseMs: 12000,
        expectedSeconds: 20,
        isFirstAttempt: false,
        isFirstSolveByStudent: false, // Already solved previously
      );

      final deltas = outcome.counterDeltas;
      expect(deltas.attemptCountDelta, equals(1));
      expect(deltas.attemptedStudentCountDelta, equals(0));
      expect(deltas.solvedStudentCountDelta, equals(0)); // NOT incremented again
      expect(deltas.firstTrySolveCountDelta, equals(0));
      expect(deltas.underTimeSolveCountDelta, equals(1));
      expect(deltas.cleanSolveCountDelta, equals(0));
    });
  });
}
