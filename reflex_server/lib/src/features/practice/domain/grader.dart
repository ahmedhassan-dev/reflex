import 'package:reflex_server/src/generated/protocol.dart';

/// Helper to normalize strings for robust, localization-friendly comparison.
class AnswerNormalizer {
  static final RegExp _whitespaceRegex = RegExp(r'\s+');
  static final RegExp _arabicTashkeelRegex = RegExp(r'[\u064B-\u065F\u0670\u0640]');

  static const Map<String, String> _arabicDigitsMap = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9',
    '۰': '0',
    '۱': '1',
    '۲': '2',
    '۳': '3',
    '۴': '4',
    '۵': '5',
    '۶': '6',
    '۷': '7',
    '۸': '8',
    '۹': '9',
  };

  /// Normalizes a text answer:
  /// - Strips leading/trailing whitespace and compresses inner whitespace
  /// - Converts to lowercase
  /// - Replaces Arabic-Indic and Eastern Arabic digits with standard ASCII digits
  /// - Removes Arabic tashkeel / diacritics and tatweel
  static String normalize(String raw) {
    if (raw.isEmpty) return '';

    var result = raw.trim().toLowerCase();
    if (result.isEmpty) return '';

    // Collapse multiple whitespace
    result = result.replaceAll(_whitespaceRegex, ' ');

    // Normalize Arabic digits
    final buffer = StringBuffer();
    for (final char in result.split('')) {
      buffer.write(_arabicDigitsMap[char] ?? char);
    }
    result = buffer.toString();

    // Strip Arabic diacritics
    result = result.replaceAll(_arabicTashkeelRegex, '');

    return result.trim();
  }
}

/// Grader evaluating learner submissions for both text-input and multiple-choice questions.
class Grader {
  /// Grades a text submission against a list of accepted answers.
  static AttemptStatus grade({
    required String studentAnswer,
    required List<String> acceptedAnswers,
  }) {
    final normStudent = AnswerNormalizer.normalize(studentAnswer);
    if (normStudent.isEmpty || acceptedAnswers.isEmpty) {
      return AttemptStatus.wrong;
    }

    final studentNum = double.tryParse(normStudent);

    for (final accepted in acceptedAnswers) {
      final normAccepted = AnswerNormalizer.normalize(accepted);
      if (normStudent == normAccepted) {
        return AttemptStatus.valid;
      }

      // Check numeric equivalence if both represent numbers
      if (studentNum != null) {
        final acceptedNum = double.tryParse(normAccepted);
        if (acceptedNum != null && studentNum == acceptedNum) {
          return AttemptStatus.valid;
        }
      }
    }

    return AttemptStatus.wrong;
  }

  /// Grades a multiple-choice question option directly.
  static AttemptStatus gradeOption(QuestionOption option) {
    return option.isCorrect ? AttemptStatus.valid : AttemptStatus.wrong;
  }

  /// Grades a multiple-choice selection by option ID against a question's options list.
  static AttemptStatus gradeOptionById(int selectedOptionId, List<QuestionOption> options) {
    for (final opt in options) {
      if (opt.id == selectedOptionId) {
        return gradeOption(opt);
      }
    }
    return AttemptStatus.wrong;
  }
}
