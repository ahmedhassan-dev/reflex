import 'package:reflex_server/src/core/clock/clock.dart';
import 'package:reflex_server/src/features/demo_clock/services/demo_clock_service.dart';
import 'package:test/test.dart';

void main() {
  group('T-012: Clock & DemoClock Abstraction', () {
    test('SystemClock returns DateTime close to actual time', () {
      final clock = SystemClock();
      final before = DateTime.now();
      final clockNow = clock.now();
      final after = DateTime.now();

      expect(clockNow.isAfter(before.subtract(const Duration(seconds: 1))), isTrue);
      expect(clockNow.isBefore(after.add(const Duration(seconds: 1))), isTrue);
    });

    test('FakeClock allows manual setNow and advance', () {
      final initial = DateTime.utc(2026, 10, 9, 10, 0, 0);
      final fake = FakeClock(initial);

      expect(fake.now(), equals(initial));

      fake.advance(const Duration(hours: 2, minutes: 30));
      expect(fake.now(), equals(DateTime.utc(2026, 10, 9, 12, 30, 0)));

      fake.advanceDays(3);
      expect(fake.now(), equals(DateTime.utc(2026, 10, 12, 12, 30, 0)));

      final newTime = DateTime.utc(2026, 12, 1, 0, 0, 0);
      fake.setNow(newTime);
      expect(fake.now(), equals(newTime));
    });

    test('DemoClockService adds offsetDays to underlying clock', () {
      final base = FakeClock(DateTime.utc(2026, 10, 9, 12, 0, 0));
      final demoClock = DemoClockService(baseClock: base, initialOffsetDays: 0);

      expect(demoClock.now(), equals(DateTime.utc(2026, 10, 9, 12, 0, 0)));
      expect(demoClock.offsetDays, equals(0));

      demoClock.advanceDays(5);
      expect(demoClock.offsetDays, equals(5));
      expect(demoClock.now(), equals(DateTime.utc(2026, 10, 14, 12, 0, 0)));

      demoClock.advanceDays(25);
      expect(demoClock.offsetDays, equals(30));
      expect(demoClock.now(), equals(DateTime.utc(2026, 11, 8, 12, 0, 0)));
    });

    test('DemoClockService reset resets offsetDays back to 0', () {
      final base = FakeClock(DateTime.utc(2026, 10, 9, 12, 0, 0));
      final demoClock = DemoClockService(baseClock: base, initialOffsetDays: 14);

      expect(demoClock.offsetDays, equals(14));
      demoClock.reset();
      expect(demoClock.offsetDays, equals(0));
      expect(demoClock.now(), equals(DateTime.utc(2026, 10, 9, 12, 0, 0)));
    });
  });
}
