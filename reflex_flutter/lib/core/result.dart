/// Standard result wrapper for safe error handling without throwing unchecked exceptions.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(String message, [Object? cause]) = Failure<T>;

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get dataOrNull => switch (this) {
        Success(:final data) => data,
        Failure() => null,
      };

  T? get data => dataOrNull;

  String? get error => switch (this) {
        Success() => null,
        Failure(:final message) => message,
      };
}

/// Represents a successful computation returning [data].
final class Success<T> extends Result<T> {
  @override
  final T data;
  const Success(this.data);
}

/// Represents a failed computation with a human-readable [message] and optional [cause].
final class Failure<T> extends Result<T> {
  final String message;
  final Object? cause;
  const Failure(this.message, [this.cause]);
}
