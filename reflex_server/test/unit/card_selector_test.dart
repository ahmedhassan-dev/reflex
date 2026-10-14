import 'package:reflex_server/src/features/practice/domain/card_selector.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';
import '../fakes/fake_repositories.dart';

void main() {
  group('T-017: Card Selector & Review Queue Engine', () {
    late FakeQuestionRepository questionRepo;
    late FakeReviewStateRepository reviewStateRepo;
    late CardSelector cardSelector;
    final now = DateTime.utc(2026, 10, 9, 12, 0, 0);

    setUp(() async {
      questionRepo = FakeQuestionRepository();
      reviewStateRepo = FakeReviewStateRepository();
      cardSelector = CardSelector(
        questionRepository: questionRepo,
        reviewStateRepository: reviewStateRepo,
      );

      // Seed 3 questions in course 1
      await questionRepo.save(Question(
        id: 1,
        courseId: 1,
        position: 1,
        prompt: 'Q1 (First position)',
        topic: 'Math',
        questionType: QuestionType.multipleChoice,
        points: 5,
        expectedSeconds: 15,
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
        prompt: 'Q2 (Second position)',
        topic: 'Math',
        questionType: QuestionType.textInput,
        points: 5,
        expectedSeconds: 15,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));

      await questionRepo.save(Question(
        id: 3,
        courseId: 1,
        position: 3,
        prompt: 'Q3 (Third position)',
        topic: 'Math',
        questionType: QuestionType.multipleChoice,
        points: 5,
        expectedSeconds: 15,
        attemptCount: 0,
        attemptedStudentCount: 0,
        solvedStudentCount: 0,
        firstTrySolveCount: 0,
        underTimeSolveCount: 0,
        cleanSolveCount: 0,
      ));
    });

    test('returns new unattempted card by question.position ascending when no reviews are due', () async {
      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 1,
        now: now,
      );

      expect(card, isNotNull);
      expect(card!.question.id, equals(1));
      expect(card.kind, equals(CardKind.newCard));
    });

    test('orders new cards by question.position ascending', () async {
      // Mark Q1 as attempted with review in future
      await reviewStateRepo.upsert(ReviewState(
        profileId: 10,
        questionId: 1,
        dueAt: now.add(const Duration(days: 1)),
        intervalDays: 1,
        lapses: 0,
        helpUsed: false,
      ));

      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 1,
        now: now,
      );

      expect(card, isNotNull);
      expect(card!.question.id, equals(2));
      expect(card.kind, equals(CardKind.newCard));
    });

    test('returns overdue review card first before any new cards', () async {
      // Q2 has a review state that is OVERDUE (due 2 hours ago)
      await reviewStateRepo.upsert(ReviewState(
        profileId: 10,
        questionId: 2,
        dueAt: now.subtract(const Duration(hours: 2)),
        intervalDays: 1,
        lapses: 1,
        helpUsed: false,
      ));

      // Q1 is completely new (unattempted), but Q2 is due for review
      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 1,
        now: now,
      );

      expect(card, isNotNull);
      expect(card!.question.id, equals(2));
      expect(card.kind, equals(CardKind.review));
    });

    test('orders multiple overdue review cards by dueAt ascending', () async {
      // Q1 due 1 hour ago
      await reviewStateRepo.upsert(ReviewState(
        profileId: 10,
        questionId: 1,
        dueAt: now.subtract(const Duration(hours: 1)),
        intervalDays: 1,
        lapses: 0,
        helpUsed: false,
      ));

      // Q2 due 5 hours ago (more overdue)
      await reviewStateRepo.upsert(ReviewState(
        profileId: 10,
        questionId: 2,
        dueAt: now.subtract(const Duration(hours: 5)),
        intervalDays: 1,
        lapses: 0,
        helpUsed: false,
      ));

      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 1,
        now: now,
      );

      expect(card, isNotNull);
      expect(card!.question.id, equals(2)); // More overdue served first
      expect(card.kind, equals(CardKind.review));
    });

    test('returns null when all cards are scheduled in the future (deck complete)', () async {
      for (var qId = 1; qId <= 3; qId++) {
        await reviewStateRepo.upsert(ReviewState(
          profileId: 10,
          questionId: qId,
          dueAt: now.add(Duration(days: qId)),
          intervalDays: qId,
          lapses: 0,
          helpUsed: false,
        ));
      }

      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 1,
        now: now,
      );

      expect(card, isNull);
    });

    test('returns null when course has no questions', () async {
      final card = await cardSelector.selectNextCard(
        profileId: 10,
        courseId: 999, // Empty course
        now: now,
      );

      expect(card, isNull);
    });
  });
}
