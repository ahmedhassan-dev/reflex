/// Clock interface for time abstraction across the Reflex application.
abstract interface class Clock {
  /// Returns the current time.
  DateTime now();
}

/// Production clock using system time in UTC.
class SystemClock implements Clock {
  const SystemClock();

  @override
  DateTime now() => DateTime.now().toUtc();
}

/// Fake clock for unit testing and deterministic simulation.
class FakeClock implements Clock {
  DateTime _current;

  FakeClock([DateTime? initial])
      : _current = initial ?? DateTime.utc(2026, 10, 9, 0, 0, 0);

  @override
  DateTime now() => _current;

  /// Set the current fake time to [dateTime].
  void setNow(DateTime dateTime) {
    _current = dateTime;
  }

  /// Advance the clock forward by [duration].
  void advance(Duration duration) {
    _current = _current.add(duration);
  }

  /// Convenience helper to advance the clock forward by [days].
  void advanceDays(int days) {
    advance(Duration(days: days));
  }
}
