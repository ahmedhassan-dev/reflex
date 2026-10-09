import 'package:sentry/sentry.dart';

/// Pluggable error reporting contract for the Serverpod backend.
abstract interface class ErrorReporter {
  /// Reports an exception or error with optional stack trace and contextual data.
  Future<void> recordError(
    dynamic exception, {
    StackTrace? stackTrace,
    String? reason,
    Map<String, dynamic>? context,
  });

  /// Logs an informational or warning breadcrumb/message.
  Future<void> logMessage(String message, {String? level});
}

/// No-op implementation for offline execution and unit testing.
class NoOpErrorReporter implements ErrorReporter {
  const NoOpErrorReporter();

  @override
  Future<void> recordError(
    dynamic exception, {
    StackTrace? stackTrace,
    String? reason,
    Map<String, dynamic>? context,
  }) async {}

  @override
  Future<void> logMessage(String message, {String? level}) async {}
}

/// Sentry integration for backend exception and performance telemetry.
class SentryErrorReporter implements ErrorReporter {
  final String dsn;

  SentryErrorReporter({required this.dsn});

  @override
  Future<void> recordError(
    dynamic exception, {
    StackTrace? stackTrace,
    String? reason,
    Map<String, dynamic>? context,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      hint: reason != null ? Hint.withMap({'reason': reason}) : null,
      withScope: (scope) {
        if (context != null) {
          scope.setContexts('reflex_context', context);
        }
      },
    );
  }

  @override
  Future<void> logMessage(String message, {String? level}) async {
    await Sentry.captureMessage(message);
  }
}
