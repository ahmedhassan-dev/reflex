import 'package:flutter_test/flutter_test.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/core/usecase.dart';

class MockUseCase implements UseCase<String, String> {
  @override
  Future<Result<String>> call(String params) async {
    if (params.isEmpty) {
      return const Failure('Input cannot be empty');
    }
    return Success('Hello, $params');
  }
}

void main() {
  group('Core: Result & UseCase', () {
    test('Success returns data and isSuccess is true', () async {
      final useCase = MockUseCase();
      final result = await useCase('Amina');

      expect(result.isSuccess, isTrue);
      expect(result.isFailure, isFalse);
      expect(result.dataOrNull, equals('Hello, Amina'));
    });

    test('Failure returns message and isFailure is true', () async {
      final useCase = MockUseCase();
      final result = await useCase('');

      expect(result.isSuccess, isFalse);
      expect(result.isFailure, isTrue);
      expect(result.dataOrNull, isNull);
      expect((result as Failure).message, equals('Input cannot be empty'));
    });
  });
}
