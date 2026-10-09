import 'package:reflex_server/src/core/clock/clock.dart';

/// Service allowing simulated advancement of time for judging and demonstration.
class DemoClockService implements Clock {
  final Clock _baseClock;
  int _offsetDays;

  DemoClockService({
    Clock? baseClock,
    int initialOffsetDays = 0,
  })  : _baseClock = baseClock ?? const SystemClock(),
        _offsetDays = initialOffsetDays;

  /// Current simulated offset in days.
  int get offsetDays => _offsetDays;

  @override
  DateTime now() {
    final baseNow = _baseClock.now();
    return baseNow.add(Duration(days: _offsetDays));
  }

  /// Advance the demo clock forward by [days].
  void advanceDays(int days) {
    if (days < 0) {
      throw ArgumentError.value(days, 'days', 'Cannot advance time backwards.');
    }
    _offsetDays += days;
  }

  /// Set the offset to a specific number of days.
  void setOffsetDays(int days) {
    if (days < 0) {
      throw ArgumentError.value(days, 'days', 'Offset days cannot be negative.');
    }
    _offsetDays = days;
  }

  /// Reset the simulated offset back to 0.
  void reset() {
    _offsetDays = 0;
  }
}
