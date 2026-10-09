import 'package:reflex_server/src/features/practice/domain/grader.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('T-013: Answer Normalizer & Grader', () {
    group('AnswerNormalizer', () {
      test('normalizes leading/trailing and inner whitespace: "  x   y  " -> "x y"', () {
        expect(AnswerNormalizer.normalize('  x   y  '), equals('x y'));
      });

      test('lowercases text: "Paris" -> "paris"', () {
        expect(AnswerNormalizer.normalize('Paris'), equals('paris'));
      });

      test('normalizes Arabic-Indic digits: "١٢" -> "12"', () {
        expect(AnswerNormalizer.normalize('١٢'), equals('12'));
        expect(AnswerNormalizer.normalize('العدد ٥٤٣٢١'), equals('العدد 54321'));
      });

      test('removes Arabic diacritics (tashkeel): "مُعَلِّم" -> "معلم"', () {
        expect(AnswerNormalizer.normalize('مُعَلِّم'), equals('معلم'));
        expect(AnswerNormalizer.normalize('الْقَاهِرَةُ'), equals('القاهرة'));
      });

      test('normalizes empty or whitespace-only strings to empty string', () {
        expect(AnswerNormalizer.normalize(''), equals(''));
        expect(AnswerNormalizer.normalize('    '), equals(''));
      });
    });

    group('Grader.grade (Text Input)', () {
      test('case insensitivity: "Paris" matches "paris"', () {
        final status = Grader.grade(
          studentAnswer: 'Paris',
          acceptedAnswers: ['paris'],
        );
        expect(status, equals(AttemptStatus.valid));
      });

      test('Arabic diacritics match: "مُعَلِّم" matches "معلم"', () {
        final status = Grader.grade(
          studentAnswer: 'مُعَلِّم',
          acceptedAnswers: ['معلم'],
        );
        expect(status, equals(AttemptStatus.valid));
      });

      test('Arabic-Indic digits match: "١٢" matches "12"', () {
        final status = Grader.grade(
          studentAnswer: '١٢',
          acceptedAnswers: ['12'],
        );
        expect(status, equals(AttemptStatus.valid));
      });

      test('numeric equivalence: "5" matches "5.0" and "5.00"', () {
        expect(
          Grader.grade(studentAnswer: '5', acceptedAnswers: ['5.0']),
          equals(AttemptStatus.valid),
        );
        expect(
          Grader.grade(studentAnswer: '5.00', acceptedAnswers: ['5']),
          equals(AttemptStatus.valid),
        );
        expect(
          Grader.grade(studentAnswer: '0.5', acceptedAnswers: ['.5']),
          equals(AttemptStatus.valid),
        );
      });

      test('empty answer returns AttemptStatus.wrong without crashing', () {
        expect(
          Grader.grade(studentAnswer: '', acceptedAnswers: ['paris']),
          equals(AttemptStatus.wrong),
        );
        expect(
          Grader.grade(studentAnswer: '   ', acceptedAnswers: ['paris']),
          equals(AttemptStatus.wrong),
        );
        expect(
          Grader.grade(studentAnswer: 'London', acceptedAnswers: []),
          equals(AttemptStatus.wrong),
        );
      });

      test('wrong answer returns AttemptStatus.wrong', () {
        expect(
          Grader.grade(studentAnswer: 'Rome', acceptedAnswers: ['paris', 'france']),
          equals(AttemptStatus.wrong),
        );
      });
    });

    group('Grader.gradeOption (Multiple Choice)', () {
      final correctOption = QuestionOption(
        id: 1,
        questionId: 10,
        position: 0,
        text: 'Mitochondria',
        isCorrect: true,
        explanation: 'Powerhouse of the cell.',
      );

      final wrongOption = QuestionOption(
        id: 2,
        questionId: 10,
        position: 1,
        text: 'Ribosome',
        isCorrect: false,
        explanation: 'Synthesizes proteins.',
      );

      test('MCQ evaluation: returns AttemptStatus.valid when option isCorrect=true', () {
        expect(Grader.gradeOption(correctOption), equals(AttemptStatus.valid));
      });

      test('MCQ evaluation: returns AttemptStatus.wrong when option isCorrect=false', () {
        expect(Grader.gradeOption(wrongOption), equals(AttemptStatus.wrong));
      });

      test('MCQ evaluation by ID from options list', () {
        final options = [correctOption, wrongOption];
        expect(Grader.gradeOptionById(1, options), equals(AttemptStatus.valid));
        expect(Grader.gradeOptionById(2, options), equals(AttemptStatus.wrong));
        expect(Grader.gradeOptionById(999, options), equals(AttemptStatus.wrong));
      });
    });
  });
}
