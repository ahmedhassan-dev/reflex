import 'package:reflex_server/src/generated/protocol.dart';

/// Strategy interface for scheduling spaced repetition review intervals.
abstract interface class SchedulingPolicy {
  /// Calculates the next due [DateTime] given a baseline [now] and the attempt [reason].
  DateTime nextDue(DateTime now, ResultReason reason);

  /// Returns the interval in days for a given [reason].
  int intervalDays(ResultReason reason);
}

/// Spaced repetition policy implementing the Reflex / Iron Man fixed interval progression:
/// - Wrong: +1 day
/// - Correct with help: +1 day
/// - Correct slow: +2 days
/// - Correct clean: +30 days
class LegacyFixedIntervalPolicy implements SchedulingPolicy {
  const LegacyFixedIntervalPolicy();

  @override
  int intervalDays(ResultReason reason) {
    switch (reason) {
      case ResultReason.wrong:
        return 1;
      case ResultReason.correctWithHelp:
        return 1;
      case ResultReason.correctSlow:
        return 2;
      case ResultReason.correctClean:
        return 30;
    }
  }

  @override
  DateTime nextDue(DateTime now, ResultReason reason) {
    final days = intervalDays(reason);
    return now.add(Duration(days: days));
  }
}
