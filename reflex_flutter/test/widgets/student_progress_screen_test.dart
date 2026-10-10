import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/analytics_repository.dart';
import 'package:reflex_flutter/presentation/features/profile/student_progress_screen.dart';
import '../test_helpers.dart';

class MockAnalyticsRepository extends Mock implements IAnalyticsRepository {}

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  late MockAnalyticsRepository mockRepo;

  setUp(() {
    mockRepo = MockAnalyticsRepository();
  });

  group('StudentProgressScreen widget tests', () {
    testWidgets('renders student metrics and clean-first-try solves correctly',
        (tester) async {
      final sampleProgress = StudentProgress(
        learnerId: 101,
        displayName: 'Amira Tariq',
        solvedCount: 18,
        cleanFirstTryCount: 14,
        avgResponseMs: 1420.0,
      );

      when(() => mockRepo.getMyProgress(any()))
          .thenAnswer((_) async => Result.success(sampleProgress));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: StudentProgressScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify student name
      expect(find.text('Amira Tariq'), findsOneWidget);

      // Verify Clean 1st Try count
      expect(find.text('14'), findsOneWidget);

      // Verify Solved count
      expect(find.text('18'), findsOneWidget);

      // Verify Latency
      expect(find.text('1420ms'), findsOneWidget);
    });
  });
}
