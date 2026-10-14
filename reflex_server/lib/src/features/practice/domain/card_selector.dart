import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Result of selecting a card for practice.
class SelectedCard {
  final Question question;
  final CardKind kind;

  const SelectedCard({
    required this.question,
    required this.kind,
  });
}

/// Domain engine selecting cards for profile practice sessions.
/// Follows spaced repetition priority:
/// 1. Due reviews first (ordered by dueAt ASC)
/// 2. Unattempted / new cards next (ordered by question.position ASC)
/// 3. Returns null when all questions are scheduled in the future.
class CardSelector {
  final IQuestionRepository questionRepository;
  final IReviewStateRepository reviewStateRepository;

  CardSelector({
    required this.questionRepository,
    required this.reviewStateRepository,
  });

  /// Selects the next card to practice for [profileId] in [courseId] at [now].
  Future<SelectedCard?> selectNextCard({
    required int profileId,
    required int courseId,
    required DateTime now,
  }) async {
    // 1. Prioritize overdue review cards
    final dueReviews = await reviewStateRepository.findDueReviews(
      profileId: profileId,
      courseId: courseId,
      now: now,
    );

    for (final review in dueReviews) {
      final question = await questionRepository.findById(review.questionId);
      if (question != null && question.courseId == courseId) {
        return SelectedCard(question: question, kind: CardKind.review);
      }
    }

    // 2. Serve new unattempted cards in position order
    final courseQuestions = await questionRepository.findByCourseId(courseId);
    for (final q in courseQuestions) {
      final reviewState = await reviewStateRepository.get(profileId, q.id!);
      if (reviewState == null) {
        return SelectedCard(question: q, kind: CardKind.newCard);
      }
    }

    // 3. Deck complete (all cards reviewed and none overdue)
    return null;
  }
}
