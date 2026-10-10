import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/demo_clock_repository.dart';
import 'package:reflex_flutter/presentation/features/demo_clock/widgets/demo_clock_widget.dart';
import '../test_helpers.dart';

class MockDemoClockRepository extends Mock implements IDemoClockRepository {}

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  late MockDemoClockRepository mockRepo;

  setUp(() {
    mockRepo = MockDemoClockRepository();
  });

  group('DemoClockWidget tests', () {
    testWidgets('tapping +1 Day calls demo clock advanceDays(1)', (tester) async {
      when(() => mockRepo.getOffsetDays())
          .thenAnswer((_) async => const Result.success(0));
      when(() => mockRepo.advanceDays(1))
          .thenAnswer((_) async => const Result.success(1));

      bool clockShiftedCalled = false;

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: DemoClockWidget(
            repositoryOverride: mockRepo,
            onClockShifted: () {
              clockShiftedCalled = true;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify widget rendered
      expect(find.byType(DemoClockWidget), findsOneWidget);
      expect(find.text('+0 d (', skipOffstage: false), findsNothing);

      // Tap +1 Day chip
      final chip1d = find.byKey(const Key('demo_clock_1d'));
      expect(chip1d, findsOneWidget);
      await tester.tap(chip1d);
      await tester.pumpAndSettle();

      // Verify advanceDays(1) was invoked
      verify(() => mockRepo.advanceDays(1)).called(1);
      expect(clockShiftedCalled, isTrue);
    });
  });
}
