/// Standard result wrapper for safe error handling without throwing unchecked exceptions.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };
}

/// Represents a successful computation returning [data].
final class Success<T> extends Result<T> {
  final T data;
  const Success(this.data);
}

/// Represents a failed computation with a human-readable [message] and optional [exception].
final class Failure<T> extends Result<T> {
  final String message;
  final Object? error;
  const Failure(this.message, [this.error]);
}
