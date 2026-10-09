import 'package:test/test.dart';
import 'package:reflex_server/src/core/monitoring/error_reporter.dart';

void main() {
  group('T-030: ErrorReporter Abstraction', () {
    test('NoOpErrorReporter executes safely without throwing', () async {
      const reporter = NoOpErrorReporter();

      await expectLater(
        reporter.recordError(
          Exception('Simulated test exception'),
          stackTrace: StackTrace.current,
          reason: 'Unit testing',
          context: {'userId': 123},
        ),
        completes,
      );

      await expectLater(
        reporter.logMessage('Informational breadcrumb', level: 'info'),
        completes,
      );
    });

    test('SentryErrorReporter instantiates with valid configuration', () {
      final reporter = SentryErrorReporter(dsn: 'https://fake@sentry.io/123');
      expect(reporter.dsn, equals('https://fake@sentry.io/123'));
    });
  });
}
