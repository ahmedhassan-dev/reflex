import 'package:reflex_server/src/data/repositories/interfaces.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// Pure domain calculator for attempt points and total student scores.
class ScoreCalculator {
  /// Calculates points to award for the current attempt.
  ///
  /// Points are awarded strictly once: only if the attempt is valid and
  /// the profile has not previously solved this question.
  static int calculateAwardedPoints({
    required AttemptStatus status,
    required bool hasLearnerSolvedBefore,
    required int questionPoints,
  }) {
    if (status != AttemptStatus.valid) {
      return 0;
    }
    if (hasLearnerSolvedBefore) {
      return 0;
    }
    return questionPoints;
  }

  /// Calculates the cumulative score for a profile.
  ///
  /// The total score is the sum of points for distinct questions that the
  /// profile has solved at least once with a valid verdict.
  static Future<int> calculateTotalScore({
    required IAttemptRepository attemptRepo,
    required IQuestionRepository questionRepo,
    required int profileId,
    int? courseId,
  }) async {
    final attempts = await attemptRepo.listAttemptsByProfile(profileId);
    final solvedQuestionIds = attempts
        .where((a) => a.status == AttemptStatus.valid)
        .map((a) => a.questionId)
        .toSet();

    if (solvedQuestionIds.isEmpty) return 0;

    if (courseId != null) {
      final questions = await questionRepo.findByCourseId(courseId);
      return questions
          .where((q) => q.id != null && solvedQuestionIds.contains(q.id))
          .fold<int>(0, (int sum, Question q) => sum + q.points);
    } else {
      int total = 0;
      for (final qId in solvedQuestionIds) {
        final q = await questionRepo.findById(qId);
        if (q != null) total += q.points;
      }
      return total;
    }
  }
}
