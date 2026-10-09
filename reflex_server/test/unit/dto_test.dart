import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('T-011: Protocol DTOs & Domain Exceptions', () {
    test('QuestionOptionView contains only id and text (zero answer leakage)', () {
      final option = QuestionOptionView(id: 1, text: 'Photosynthesis');
      expect(option.id, equals(1));
      expect(option.text, equals('Photosynthesis'));

      final json = option.toJson();
      expect(json.containsKey('id'), isTrue);
      expect(json.containsKey('text'), isTrue);
      expect(json.containsKey('isCorrect'), isFalse);
      expect(json.containsKey('explanation'), isFalse);
    });

    test('OptionExplanationView contains full explanation details for post-submit', () {
      final explanation = OptionExplanationView(
        optionId: 42,
        text: 'Mitochondria',
        isCorrect: true,
        explanation: 'Known as the powerhouse of the cell.',
      );

      expect(explanation.optionId, equals(42));
      expect(explanation.text, equals('Mitochondria'));
      expect(explanation.isCorrect, isTrue);
      expect(explanation.explanation, contains('powerhouse'));

      final json = explanation.toJson();
      expect(json['optionId'], equals(42));
      expect(json['isCorrect'], isTrue);
      expect(json['explanation'], contains('powerhouse'));
    });

    test('QuestionView never leaks answerKey, acceptedAnswers, or topicNote', () {
      final qView = QuestionView(
        id: 101,
        prompt: 'What organelle produces ATP?',
        topic: 'Cell Biology',
        questionType: QuestionType.multipleChoice,
        points: 10,
        expectedSeconds: 30,
        hasHelpHint: true,
        options: [
          QuestionOptionView(id: 1, text: 'Ribosome'),
          QuestionOptionView(id: 2, text: 'Mitochondria'),
        ],
      );

      final json = qView.toJson();
      expect(json['id'], equals(101));
      expect(json['topic'], equals('Cell Biology'));
      expect(json['options'], isNotNull);
      expect(json.containsKey('answerKey'), isFalse);
      expect(json.containsKey('acceptedAnswer'), isFalse);
      expect(json.containsKey('topicNote'), isFalse);
      expect(json.containsKey('helpHint'), isFalse);
    });

    test('SubmitResult serializes ResultReason, ReflexTier, and topicNote', () {
      final now = DateTime.now();
      final result = SubmitResult(
        verdict: AttemptStatus.valid,
        reason: ResultReason.correctClean,
        reflexTier: ReflexTier.greenMastered,
        points: 15,
        responseMs: 4200,
        nextDueAt: now.add(const Duration(days: 30)),
        topicNote: 'Remember: ATP synthase occurs on inner membrane.',
        selectedOptionExplanation: 'Correct! Mitochondria generate ATP.',
        optionExplanations: [
          OptionExplanationView(
            optionId: 1,
            text: 'Ribosome',
            isCorrect: false,
            explanation: 'Ribosomes synthesize proteins, not ATP.',
          ),
          OptionExplanationView(
            optionId: 2,
            text: 'Mitochondria',
            isCorrect: true,
            explanation: 'Correct! Mitochondria generate ATP.',
          ),
        ],
      );

      expect(result.verdict, equals(AttemptStatus.valid));
      expect(result.reason, equals(ResultReason.correctClean));
      expect(result.reflexTier, equals(ReflexTier.greenMastered));
      expect(result.topicNote, contains('ATP synthase'));
      expect(result.optionExplanations?.length, equals(2));

      final json = result.toJson();
      expect(json['verdict'], equals('valid'));
      expect(json['reason'], equals('correctClean'));
      expect(json['reflexTier'], equals('greenMastered'));
      expect(json['topicNote'], contains('ATP synthase'));
    });

    test('PracticeItem bundles QuestionView and CardKind correctly', () {
      final item = PracticeItem(
        question: QuestionView(
          id: 5,
          prompt: '2 + 2 = ?',
          topic: 'Math',
          questionType: QuestionType.textInput,
          points: 5,
          expectedSeconds: 15,
          hasHelpHint: false,
        ),
        kind: CardKind.review,
      );

      expect(item.kind, equals(CardKind.review));
      expect(item.question.id, equals(5));
      expect(item.question.options, isNull);
    });

    test('HelpResult returns hint text', () {
      final help = HelpResult(helpHint: 'Think about photosynthesis.');
      expect(help.helpHint, equals('Think about photosynthesis.'));
      expect(help.toJson()['helpHint'], equals('Think about photosynthesis.'));
    });

    test('CohortSummary bundles TopicMastery, QuestionInsight, and StudentProgress', () {
      final summary = CohortSummary(
        mastery: [
          TopicMastery(topic: 'Fractions', masteryRate: 0.85),
        ],
        questions: [
          QuestionInsight(
            questionId: 1,
            prompt: '1/2 + 1/4',
            topic: 'Fractions',
            questionType: QuestionType.multipleChoice,
            attemptCount: 20,
            solvedStudentCount: 18,
            firstTrySolveCount: 15,
            underTimeSolveCount: 16,
            cleanSolveCount: 14,
            firstTryRate: 0.75,
            cleanRate: 0.70,
            avgResponseMs: 5200.0,
          ),
        ],
        students: [
          StudentProgress(
            learnerId: 10,
            displayName: 'Amina',
            solvedCount: 18,
            cleanFirstTryCount: 14,
            avgResponseMs: 4800.0,
          ),
        ],
      );

      expect(summary.mastery.first.topic, equals('Fractions'));
      expect(summary.questions.first.cleanSolveCount, equals(14));
      expect(summary.students.first.displayName, equals('Amina'));
    });

    test('Domain exceptions hierarchy and message formatting', () {
      expect(
        const CardAlreadyAnsweredException().toString(),
        contains('CardAlreadyAnsweredException'),
      );
      expect(
        const NoActiveCardException().toString(),
        contains('NoActiveCardException'),
      );
      expect(
        const QuestionNotFoundException(99).toString(),
        contains('Question with id 99 was not found'),
      );
      expect(
        const CourseNotFoundException(3).toString(),
        contains('Course with id 3 was not found'),
      );
      expect(
        const InvalidOptionException(77).toString(),
        contains('Option id 77 is not valid'),
      );
      expect(
        const UnauthorizedException().toString(),
        contains('UnauthorizedException'),
      );
      expect(
        const DuplicateSubmissionException().toString(),
        contains('DuplicateSubmissionException'),
      );
    });
  });
}
