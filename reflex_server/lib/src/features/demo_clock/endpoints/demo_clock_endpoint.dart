import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/di/app_container.dart';

/// Endpoint managing simulated time advancement for live demonstrations and testing.
class DemoClockEndpoint extends Endpoint {
  /// Returns current simulated offset in days.
  Future<int> getOffsetDays(Session session) async {
    final container = AppContainer(session);
    return container.demoClockRepo.getOffsetDays();
  }

  /// Sets the simulated offset to a specific number of days.
  Future<int> setOffsetDays(Session session, int offsetDays) async {
    final container = AppContainer(session);
    await container.demoClockRepo.setOffsetDays(offsetDays);
    return offsetDays;
  }

  /// Advances the simulated time forward by [days].
  Future<int> advanceDays(Session session, int days) async {
    final container = AppContainer(session);
    final current = await container.demoClockRepo.getOffsetDays();
    final updated = current + days;
    await container.demoClockRepo.setOffsetDays(updated);
    return updated;
  }

  /// Resets the simulated clock back to current real-world time.
  Future<void> resetClock(Session session) async {
    final container = AppContainer(session);
    await container.demoClockRepo.setOffsetDays(0);
  }
}
