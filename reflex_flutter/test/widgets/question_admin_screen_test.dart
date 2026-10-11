import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:reflex_client/reflex_client.dart';
import 'package:reflex_flutter/core/result.dart';
import 'package:reflex_flutter/data/repositories/question_admin_repository.dart';
import 'package:reflex_flutter/presentation/features/question_admin/question_admin_screen.dart';
import '../test_helpers.dart';

class MockQuestionAdminRepository extends Mock implements IQuestionAdminRepository {}

class FakeCreateQuestionInput extends Fake implements CreateQuestionInput {}

void main() {
  setUpAll(() async {
    registerFallbackValue(FakeCreateQuestionInput());
    await initTestLocalization();
  });

  late MockQuestionAdminRepository mockRepo;

  setUp(() {
    mockRepo = MockQuestionAdminRepository();
    when(() => mockRepo.listCourses()).thenAnswer(
      (_) async => Result.success([
        Course(id: 1, title: 'STEM Math', subject: 'Math'),
      ]),
    );
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

    testWidgets('teacher can open dialog and create a new course with topics', (tester) async {
      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([]));
      when(() => mockRepo.createCourse(
            title: any(named: 'title'),
            subject: any(named: 'subject'),
            topics: any(named: 'topics'),
            isPublic: any(named: 'isPublic'),
          )).thenAnswer((_) async => Result.success(
            Course(id: 2, title: 'Calculus Advanced', subject: 'Math', topics: ['Algebra'], isPublic: true),
          ));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "New Course" button
      final addCourseBtn = find.byKey(const Key('btn_add_course'));
      expect(addCourseBtn, findsOneWidget);
      await tester.tap(addCourseBtn);
      await tester.pumpAndSettle();

      // Verify visibility switch is present
      expect(find.byKey(const Key('switch_course_visibility')), findsOneWidget);

      // Enter Title, Subject, and Tag
      await tester.enterText(find.byKey(const Key('input_new_course_title')), 'Calculus Advanced');
      await tester.enterText(find.byKey(const Key('input_new_course_subject')), 'Math');
      await tester.enterText(find.byKey(const Key('input_new_course_topic')), 'Algebra');
      await tester.tap(find.byKey(const Key('btn_add_topic_to_course')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('chip_dialog_topic_Algebra')), findsOneWidget);

      // Tap Confirm Create
      await tester.tap(find.byKey(const Key('btn_confirm_create_course')));
      await tester.pumpAndSettle();

      verify(() => mockRepo.createCourse(
            title: 'Calculus Advanced',
            subject: 'Math',
            topics: ['Algebra'],
            isPublic: true,
          )).called(1);
    });

    testWidgets('course topics are rendered as chips for selected course', (tester) async {
      when(() => mockRepo.listCourses()).thenAnswer(
        (_) async => Result.success([
          Course(id: 1, title: 'STEM Math', subject: 'Math', topics: ['Geometry', 'Vectors']),
        ]),
      );
      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([]));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('chip_course_topic_Geometry')), findsOneWidget);
      expect(find.byKey(const Key('chip_course_topic_Vectors')), findsOneWidget);
    });

    testWidgets('teacher can open bottom sheet and create a new question', (tester) async {
      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([]));
      when(() => mockRepo.createQuestion(any()))
          .thenAnswer((_) async => Result.success(Question(
                id: 15,
                courseId: 1,
                position: 1,
                prompt: 'What is Newton second law?',
                topic: 'Physics',
                questionType: QuestionType.multipleChoice,
                points: 10,
                expectedSeconds: 15,
                attemptCount: 0,
                attemptedStudentCount: 0,
                solvedStudentCount: 0,
                firstTrySolveCount: 0,
                underTimeSolveCount: 0,
                cleanSolveCount: 0,
              )));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap "New Question" button
      final addQBtn = find.byKey(const Key('btn_add_question'));
      expect(addQBtn, findsOneWidget);
      await tester.tap(addQBtn);
      await tester.pumpAndSettle();

      // Enter Prompt and Topic
      await tester.enterText(find.byKey(const Key('input_question_prompt')), 'What is Newton second law?');
      await tester.enterText(find.byKey(const Key('input_question_topic')), 'Physics');

      // Tap Confirm Create
      final confirmBtn = find.byKey(const Key('btn_confirm_create_question'));
      await tester.ensureVisible(confirmBtn);
      await tester.tap(confirmBtn);
      await tester.pumpAndSettle();

      verify(() => mockRepo.createQuestion(any())).called(1);
    });

    testWidgets('teacher can toggle course visibility', (tester) async {
      when(() => mockRepo.listCourses()).thenAnswer(
        (_) async => Result.success([
          Course(id: 1, title: 'STEM Math', subject: 'Math', isPublic: true),
        ]),
      );
      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([]));
      when(() => mockRepo.updateCourseVisibility(1, false))
          .thenAnswer((_) async => Result.success(
                Course(id: 1, title: 'STEM Math', subject: 'Math', isPublic: false),
              ));
      when(() => mockRepo.listSubscriptions(1))
          .thenAnswer((_) async => Result.success([]));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final toggleChip = find.byKey(const Key('chip_course_visibility_toggle'));
      expect(toggleChip, findsOneWidget);
      await tester.tap(toggleChip);
      await tester.pumpAndSettle();

      verify(() => mockRepo.updateCourseVisibility(1, false)).called(1);
    });

    testWidgets('teacher can open subscriptions sheet and accept pending student', (tester) async {
      when(() => mockRepo.listCourses()).thenAnswer(
        (_) async => Result.success([
          Course(id: 2, title: 'Private Math', subject: 'Math', isPublic: false, teacherName: 'Dr. Euler'),
        ]),
      );
      when(() => mockRepo.listQuestions(any()))
          .thenAnswer((_) async => Result.success([]));
      when(() => mockRepo.listSubscriptions(2)).thenAnswer(
        (_) async => Result.success([
          CourseSubscriptionView(
            id: 101,
            courseId: 2,
            courseTitle: 'Private Math',
            studentId: 5,
            studentName: 'Alice Student',
            status: SubscriptionStatus.pending,
            requestedAt: DateTime.now(),
          ),
        ]),
      );
      when(() => mockRepo.respondToSubscription(101, SubscriptionStatus.accepted))
          .thenAnswer((_) async => Result.success(CourseSubscription(
                id: 101,
                courseId: 2,
                studentId: 5,
                status: SubscriptionStatus.accepted,
                requestedAt: DateTime.now(),
              )));

      await tester.pumpWidget(
        createLocalizedTestWidget(
          child: QuestionAdminScreen(
            repositoryOverride: mockRepo,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify subscriptions button exists
      final subBtn = find.byKey(const Key('btn_manage_subscriptions'));
      expect(subBtn, findsOneWidget);
      await tester.tap(subBtn);
      await tester.pumpAndSettle();

      // Student name should be visible
      expect(find.text('Student: Alice Student'), findsOneWidget);

      // Tap Accept button
      final acceptBtn = find.byKey(const Key('btn_accept_sub_101'));
      expect(acceptBtn, findsOneWidget);
      await tester.tap(acceptBtn);
      await tester.pumpAndSettle();

      verify(() => mockRepo.respondToSubscription(101, SubscriptionStatus.accepted)).called(1);
    });
  });
}
