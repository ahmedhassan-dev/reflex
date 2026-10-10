import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/question_admin_repository.dart';
import 'package:reflex_flutter/presentation/features/question_admin/question_admin_screen.dart';
import '../test_helpers.dart';

class MockQuestionAdminRepository extends Mock implements IQuestionAdminRepository {}

void main() {
  setUpAll(() async {
    await initTestLocalization();
  });

  late MockQuestionAdminRepository mockRepo;

  setUp(() {
    mockRepo = MockQuestionAdminRepository();
  });

  group('QuestionAdminScreen widget tests', () {
    testWidgets('teacher can edit and save topic note and guided hint', (tester) async {
      final sampleQuestion = Question(
        id: 7,
        courseId: 1,
        position: 1,
        prompt: 'Explain conservation of momentum in collisions.',
        topic: 'Physics',
        questionType: QuestionType.textInput,
        points: 10,
        expectedSeconds: 8,
        topicNote: 'Initial concept note',
        helpHint: 'Initial hint',
        attemptCount: 12,
        attemptedStudentCount: 4,
        solvedStudentCount: 3,
        firstTrySolveCount: 2,
        underTimeSolveCount: 1,
        cleanSolveCount: 1,
      );

      final updatedQuestion = Question(
        id: 7,
        courseId: 1,
        position: 1,
        prompt: 'Explain conservation of momentum in collisions.',
        topic: 'Physics',
        questionType: QuestionType.textInput,
        points: 10,
        expectedSeconds: 8,
        topicNote: 'Updated concept note: P_total is conserved.',
        helpHint: 'Updated hint: elastic vs inelastic.',
        attemptCount: 12,
        attemptedStudentCount: 4,
        solvedStudentCount: 3,
        firstTrySolveCount: 2,
        underTimeSolveCount: 1,
        cleanSolveCount: 1,
      );

      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([sampleQuestion]));
      when(() => mockRepo.updateTopicNoteAndHint(
            7,
            topicNote: 'Updated concept note: P_total is conserved.',
            helpHint: 'Updated hint: elastic vs inelastic.',
          )).thenAnswer((_) async => Result.success(updatedQuestion));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify question is loaded and fields populated
      expect(find.text('Initial concept note'), findsOneWidget);
      expect(find.text('Initial hint'), findsOneWidget);

      // Enter updated topic note
      final noteFieldFinder = find.byKey(const Key('topic_note_input'));
      await tester.enterText(noteFieldFinder, 'Updated concept note: P_total is conserved.');

      // Enter updated help hint
      final hintFieldFinder = find.byKey(const Key('help_hint_input'));
      await tester.enterText(hintFieldFinder, 'Updated hint: elastic vs inelastic.');

      // Tap Save button
      final saveButtonFinder = find.byKey(const Key('save_question_button'));
      await tester.ensureVisible(saveButtonFinder);
      await tester.tap(saveButtonFinder);
      await tester.pumpAndSettle();

      // Verify repo was called with the updated note and hint
      verify(() => mockRepo.updateTopicNoteAndHint(
            7,
            topicNote: 'Updated concept note: P_total is conserved.',
            helpHint: 'Updated hint: elastic vs inelastic.',
          )).called(1);

      // Verify success feedback is shown
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });
  });
}
