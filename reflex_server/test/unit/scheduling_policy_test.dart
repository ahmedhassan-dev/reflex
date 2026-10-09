import 'package:reflex_server/src/features/practice/domain/scheduling_policy.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:test/test.dart';

void main() {
  group('T-015: Scheduling Policy Engine', () {
    late LegacyFixedIntervalPolicy policy;
    final baseTime = DateTime.utc(2026, 10, 9, 12, 0, 0);

    setUp(() {
      policy = const LegacyFixedIntervalPolicy();
    });

    test('LegacyFixedIntervalPolicy schedules wrong answer +1 day', () {
      expect(policy.intervalDays(ResultReason.wrong), equals(1));
      expect(
        policy.nextDue(baseTime, ResultReason.wrong),
        equals(baseTime.add(const Duration(days: 1))),
      );
    });

    test('LegacyFixedIntervalPolicy schedules helped answer +1 day', () {
      expect(policy.intervalDays(ResultReason.correctWithHelp), equals(1));
      expect(
        policy.nextDue(baseTime, ResultReason.correctWithHelp),
        equals(baseTime.add(const Duration(days: 1))),
      );
    });

    test('LegacyFixedIntervalPolicy schedules slow answer +2 days', () {
      expect(policy.intervalDays(ResultReason.correctSlow), equals(2));
      expect(
        policy.nextDue(baseTime, ResultReason.correctSlow),
        equals(baseTime.add(const Duration(days: 2))),
      );
    });

    test('LegacyFixedIntervalPolicy schedules clean answer +30 days', () {
      expect(policy.intervalDays(ResultReason.correctClean), equals(30));
      expect(
        policy.nextDue(baseTime, ResultReason.correctClean),
        equals(baseTime.add(const Duration(days: 30))),
      );
    });
  });
}
