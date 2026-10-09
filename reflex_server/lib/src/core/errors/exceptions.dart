/// Domain exceptions for the Reflex application.
sealed class ReflexException implements Exception {
  final String message;
  const ReflexException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// Thrown when a learner attempts to submit an answer to a card that has already been answered.
class CardAlreadyAnsweredException extends ReflexException {
  const CardAlreadyAnsweredException([super.message = 'This practice card has already been answered.']);
}

/// Thrown when a learner attempts to submit an answer but no active card is currently served.
class NoActiveCardException extends ReflexException {
  const NoActiveCardException([super.message = 'No active practice card found for this learner.']);
}

/// Thrown when a question requested by ID cannot be found.
class QuestionNotFoundException extends ReflexException {
  final int questionId;
  const QuestionNotFoundException(this.questionId, [String? message])
      : super(message ?? 'Question with id $questionId was not found.');
}

/// Thrown when a course requested by ID cannot be found.
class CourseNotFoundException extends ReflexException {
  final int courseId;
  const CourseNotFoundException(this.courseId, [String? message])
      : super(message ?? 'Course with id $courseId was not found.');
}

/// Thrown when an option selected for an MCQ does not belong to the question.
class InvalidOptionException extends ReflexException {
  final int optionId;
  const InvalidOptionException(this.optionId, [String? message])
      : super(message ?? 'Option id $optionId is not valid for this question.');
}

/// Thrown when a caller lacks the required permission or authentication scope.
class UnauthorizedException extends ReflexException {
  const UnauthorizedException([super.message = 'User is not authorized to perform this action.']);
}

/// Thrown when an idempotent submission conflict or duplicate submission is detected.
class DuplicateSubmissionException extends ReflexException {
  const DuplicateSubmissionException([super.message = 'Duplicate submission detected.']);
}

/// Thrown when input data fails domain validation rules.
class ValidationException extends ReflexException {
  const ValidationException([super.message = 'Validation failed.']);
}
