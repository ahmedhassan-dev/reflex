import 'result.dart';

/// Base interface for all domain use cases executing asynchronous actions.
abstract interface class UseCase<T, Params> {
  Future<Result<T>> call(Params params);
}

/// Parameter sentinel for use cases requiring no arguments.
class NoParams {
  const NoParams();
}
