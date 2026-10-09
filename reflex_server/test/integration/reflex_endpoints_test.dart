import 'package:test/test.dart';
import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Given Reflex Fullstack Endpoints', (sessionBuilder, endpoints) {
    test('when interacting with demoClock endpoint then offset can be adjusted and reset', () async {
      final initialOffset = await endpoints.demoClock.getOffsetDays(sessionBuilder);
      expect(initialOffset, equals(0));

      final advanced = await endpoints.demoClock.advanceDays(sessionBuilder, 3);
      expect(advanced, equals(3));

      final fetched = await endpoints.demoClock.getOffsetDays(sessionBuilder);
      expect(fetched, equals(3));

      await endpoints.demoClock.resetClock(sessionBuilder);
      final resetOffset = await endpoints.demoClock.getOffsetDays(sessionBuilder);
      expect(resetOffset, equals(0));
    });

    test('when querying empty course analytics then summary returns empty lists gracefully', () async {
      final summary = await endpoints.analytics.getCohortSummary(sessionBuilder, 999);
      expect(summary.questions, isEmpty);
      expect(summary.students, isEmpty);
      expect(summary.mastery, isEmpty);
    });
  });
}
