import 'package:reflex_server/src/generated/protocol.dart';

/// Atomic delta updates for the 6 Question counters.
class QuestionCounterDeltas {
  final int attemptCountDelta;
  final int attemptedStudentCountDelta;
  final int solvedStudentCountDelta;
  final int firstTrySolveCountDelta;
  final int underTimeSolveCountDelta;
  final int cleanSolveCountDelta;

  const QuestionCounterDeltas({
    required this.attemptCountDelta,
    required this.attemptedStudentCountDelta,
    required this.solvedStudentCountDelta,
    required this.firstTrySolveCountDelta,
    required this.underTimeSolveCountDelta,
    required this.cleanSolveCountDelta,
  });
}

/// Structured outcome of evaluating a learner practice attempt.
class AttemptOutcome {
  final AttemptStatus status;
  final ResultReason reason;
  final ReflexTier reflexTier;
  final int intervalDays;
  final int lapsesDelta;
  final bool underExpectedTime;
  final bool isClean;
  final QuestionCounterDeltas counterDeltas;

  const AttemptOutcome({
    required this.status,
    required this.reason,
    required this.reflexTier,
    required this.intervalDays,
    required this.lapsesDelta,
    required this.underExpectedTime,
    required this.isClean,
    required this.counterDeltas,
  });
}

/// Pure domain calculator evaluating attempt outcomes and chromatic Reflex tiers.
class AttemptOutcomeCalculator {
  /// Evaluates an attempt and returns all derived outcomes, scheduling deltas, and counter deltas.
  static AttemptOutcome calculate({
    required AttemptStatus status,
    required bool usedHelp,
    required int responseMs,
    required int expectedSeconds,
    required bool isFirstAttempt,
    required bool isFirstSolveByStudent,
  }) {
    final expectedMs = expectedSeconds * 1000;
    final underExpectedTime = responseMs <= expectedMs;

    final ResultReason reason;
    final ReflexTier reflexTier;
    final int intervalDays;
    final int lapsesDelta;
    final bool isClean;

    if (status == AttemptStatus.wrong) {
      reason = ResultReason.wrong;
      reflexTier = ReflexTier.redNeedsWork;
      intervalDays = 1;
      lapsesDelta = 1;
      isClean = false;
    } else {
      // Valid submission
      if (usedHelp) {
        reason = ResultReason.correctWithHelp;
        reflexTier = ReflexTier.yellowDeveloping;
        intervalDays = 1;
        lapsesDelta = 0;
        isClean = false;
      } else if (!underExpectedTime) {
        reason = ResultReason.correctSlow;
        reflexTier = ReflexTier.yellowDeveloping;
        intervalDays = 2;
        lapsesDelta = 0;
        isClean = false;
      } else {
        // Fast and without help
        if (isFirstAttempt) {
          reason = ResultReason.correctClean;
          reflexTier = ReflexTier.greenMastered;
          intervalDays = 30;
          lapsesDelta = 0;
          isClean = true;
        } else {
          // Solved fast without help, but after earlier attempts
          reason = ResultReason.correctClean;
          reflexTier = ReflexTier.greenMastered;
          intervalDays = 30;
          lapsesDelta = 0;
          isClean = false;
        }
      }
    }

    final deltas = QuestionCounterDeltas(
      attemptCountDelta: 1,
      attemptedStudentCountDelta: isFirstAttempt ? 1 : 0,
      solvedStudentCountDelta: (status == AttemptStatus.valid && isFirstSolveByStudent) ? 1 : 0,
      firstTrySolveCountDelta: (status == AttemptStatus.valid && isFirstAttempt) ? 1 : 0,
      underTimeSolveCountDelta: (status == AttemptStatus.valid && underExpectedTime) ? 1 : 0,
      cleanSolveCountDelta: isClean ? 1 : 0,
    );

    return AttemptOutcome(
      status: status,
      reason: reason,
      reflexTier: reflexTier,
      intervalDays: intervalDays,
      lapsesDelta: lapsesDelta,
      underExpectedTime: underExpectedTime,
      isClean: isClean,
      counterDeltas: deltas,
    );
  }
}
