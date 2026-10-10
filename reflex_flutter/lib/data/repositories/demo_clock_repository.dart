import 'package:reflex_client/reflex_client.dart';
import '../../core/result.dart';
import '../../client.dart';

abstract interface class IDemoClockRepository {
  Future<Result<int>> getOffsetDays();
  Future<Result<int>> advanceDays(int days);
  Future<Result<void>> resetClock();
}

class DemoClockRepositoryImpl implements IDemoClockRepository {
  final Client _client;

  DemoClockRepositoryImpl([Client? clientInstance])
      : _client = clientInstance ?? client;

  @override
  Future<Result<int>> getOffsetDays() async {
    try {
      final offset = await _client.demoClock.getOffsetDays();
      return Result.success(offset);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<int>> advanceDays(int days) async {
    try {
      final newOffset = await _client.demoClock.advanceDays(days);
      return Result.success(newOffset);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<void>> resetClock() async {
    try {
      await _client.demoClock.resetClock();
      return const Result.success(null);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
