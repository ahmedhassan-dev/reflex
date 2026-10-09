// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:io';
import 'package:postgres/postgres.dart';

Future<void> main(List<String> args) async {
  print('🌱 Starting Reflex database seeder via direct PostgreSQL connection...');

  final connection = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 8090,
      database: 'reflex',
      username: 'postgres',
      password: 'YPMVf_v_oijIRvvFDpat6nFOF3tcQ0iw',
    ),
    settings: const ConnectionSettings(sslMode: SslMode.disable),
  );

  try {
    // 1. Ensure Course exists
    var courseResult = await connection.execute(
      Sql.named('SELECT id FROM course WHERE title = @title;'),
      parameters: {'title': 'STEM Math & Dart Mastery'},
    );

    int courseId;
    if (courseResult.isEmpty) {
      final inserted = await connection.execute(
        Sql.named('INSERT INTO course (title, subject) VALUES (@title, @subject) RETURNING id;'),
        parameters: {
          'title': 'STEM Math & Dart Mastery',
          'subject': 'Computer Science & Mathematics',
        },
      );
      courseId = inserted.first.first as int;
      print('✅ Created Course: STEM Math & Dart Mastery (ID: $courseId)');
    } else {
      courseId = courseResult.first.first as int;
      print('ℹ️ Found existing Course: STEM Math & Dart Mastery (ID: $courseId)');
    }

    // 2. Ensure Teacher exists
    final teacherAuthId = '11111111-1111-1111-1111-111111111111';
    final teacherCheck = await connection.execute(
      Sql.named('SELECT id FROM learner WHERE "authUserId" = @authId;'),
      parameters: {'authId': teacherAuthId},
    );
    if (teacherCheck.isEmpty) {
      await connection.execute(
        Sql.named('INSERT INTO learner ("authUserId", "displayName", "role") VALUES (@authId, @name, @role);'),
        parameters: {
          'authId': teacherAuthId,
          'name': 'Mr. Hassan (Teacher)',
          'role': 'teacher',
        },
      );
      print('✅ Created Teacher: Mr. Hassan (Teacher)');
    }

    // 3. Ensure 5 Students exist
    final studentNames = ['Alice', 'Bob', 'Charlie', 'Dana', 'Eman'];
    final studentIds = <int>[];
    for (var i = 0; i < studentNames.length; i++) {
      final authId = '00000000-0000-4000-8000-00000000001${i + 1}';
      final check = await connection.execute(
        Sql.named('SELECT id FROM learner WHERE "authUserId" = @authId;'),
        parameters: {'authId': authId},
      );
      if (check.isEmpty) {
        final inserted = await connection.execute(
          Sql.named('INSERT INTO learner ("authUserId", "displayName", "role") VALUES (@authId, @name, @role) RETURNING id;'),
          parameters: {
            'authId': authId,
            'name': studentNames[i],
            'role': 'student',
          },
        );
        final id = inserted.first.first as int;
        studentIds.add(id);
        print('✅ Created Student: ${studentNames[i]} (ID: $id)');
      } else {
        studentIds.add(check.first.first as int);
      }
    }

    // 4. Seed 10 Questions if not present
    final qCheck = await connection.execute(
      Sql.named('SELECT COUNT(*) FROM question WHERE "courseId" = @cId;'),
      parameters: {'cId': courseId},
    );
    final qCount = qCheck.first.first as int;

    final questionIds = <int>[];
    if (qCount == 0) {
      print('📝 Seeding 10 questions with multiple-choice options & explanations...');

      final seedQuestions = [
        // Q1: MCQ (Widgets)
        _SeedQuestion(
          position: 1,
          prompt: 'Which Flutter widget is completely immutable and cannot hold mutable state across frame rebuilds?',
          topic: 'Flutter Architecture',
          questionType: 'multipleChoice',
          points: 10,
          expectedSeconds: 12,
          topicNote: 'StatelessWidget has a final configuration and rebuilds when constructor arguments or InheritedWidgets change.',
          helpHint: 'Think about immutability and state separation.',
          options: [
            _SeedOption('StatelessWidget', true, 'Correct! StatelessWidget is an immutable blueprint.'),
            _SeedOption('StatefulWidget', false, 'StatefulWidget creates a mutable State object.'),
            _SeedOption('InheritedWidget', false, 'InheritedWidget propagates immutable data down the tree.'),
            _SeedOption('RenderObjectWidget', false, 'RenderObjectWidget inflates into mutable RenderObjects.'),
          ],
        ),
        // Q2: MCQ (Dart Basics)
        _SeedQuestion(
          position: 2,
          prompt: 'What keyword in Dart defines a collection that cannot be modified after instantiation?',
          topic: 'Dart Basics',
          questionType: 'multipleChoice',
          points: 10,
          expectedSeconds: 10,
          topicNote: 'The const keyword marks compile-time canonicalized constants that are completely immutable.',
          helpHint: 'Compile-time constant modifier.',
          options: [
            _SeedOption('const', true, 'Correct! const creates canonicalized, unmodifiable instances at compile time.'),
            _SeedOption('final', false, 'final variables can only be assigned once, but collections can still be mutated unless const.'),
            _SeedOption('var', false, 'var declares mutable variables with type inference.'),
            _SeedOption('late', false, 'late defers initialization to runtime.'),
          ],
        ),
        // Q3: Text input (Algebra)
        _SeedQuestion(
          position: 3,
          prompt: 'Solve for x: 3x + 15 = 45. What is the value of x?',
          topic: 'Algebra',
          questionType: 'textInput',
          points: 15,
          expectedSeconds: 15,
          topicNote: 'Subtract 15 from both sides (3x = 30), then divide both sides by 3 to get x = 10.',
          helpHint: 'Isolate x by subtracting 15 then dividing by 3.',
          acceptedAnswers: ['10', '10.0', 'ten', '١٠'],
        ),
        // Q4: MCQ (Geometry)
        _SeedQuestion(
          position: 4,
          prompt: 'What is the sum of interior angles in a triangle (in degrees)?',
          topic: 'Geometry',
          questionType: 'multipleChoice',
          points: 10,
          expectedSeconds: 8,
          topicNote: 'In Euclidean geometry, the sum of angles in any triangle is always exactly 180 degrees.',
          helpHint: 'Half of a full 360 rotation.',
          options: [
            _SeedOption('180°', true, 'Correct! The sum of interior angles in any triangle is 180°.'),
            _SeedOption('360°', false, '360° is the sum of angles in a quadrilateral.'),
            _SeedOption('90°', false, '90° is a right angle, not the sum of a triangle.'),
            _SeedOption('270°', false, '270° is 3/4 of a circle.'),
          ],
        ),
        // Q5: Text input (Fractions)
        _SeedQuestion(
          position: 5,
          prompt: 'Simplify the fraction 18/24 to its lowest terms in decimal form (e.g. 0.75):',
          topic: 'Fractions',
          questionType: 'textInput',
          points: 15,
          expectedSeconds: 15,
          topicNote: 'Divide numerator and denominator by 6: 18/24 = 3/4 = 0.75.',
          helpHint: 'Both 18 and 24 are divisible by 6.',
          acceptedAnswers: ['0.75', '3/4', '0,75', '٠.٧٥'],
        ),
        // Q6: MCQ (State Management)
        _SeedQuestion(
          position: 6,
          prompt: 'In the State-Controller (arch_demo) MVVM pattern, which component calls setState()?',
          topic: 'Flutter Architecture',
          questionType: 'multipleChoice',
          points: 10,
          expectedSeconds: 12,
          topicNote: 'The abstract Controller extends State<Screen> and executes setState() internally, leaving the Screen view clean.',
          helpHint: 'The abstract controller extending State.',
          options: [
            _SeedOption('The Controller class', true, 'Correct! The Controller extends State<T> and encapsulates setState().'),
            _SeedOption('The build() method', false, 'build() must be pure and never invoke setState().'),
            _SeedOption('The Model entity', false, 'Domain models are pure data objects.'),
            _SeedOption('The Repository', false, 'Repositories only handle network and persistence.'),
          ],
        ),
        // Q7: MCQ (Serverpod)
        _SeedQuestion(
          position: 7,
          prompt: 'Which protocol does Serverpod use by default for high-performance RPC and streaming endpoints?',
          topic: 'Serverpod Backend',
          questionType: 'multipleChoice',
          points: 10,
          expectedSeconds: 10,
          topicNote: 'Serverpod uses HTTP/WebSockets with JSON/binary serialization for real-time streaming and RPC.',
          helpHint: 'Real-time duplex protocol.',
          options: [
            _SeedOption('WebSockets with HTTP fallback', true, 'Correct! Serverpod leverages WebSockets for live streaming and RPC.'),
            _SeedOption('gRPC exclusively', false, 'Serverpod uses native Dart protocol serialization rather than protobuf gRPC.'),
            _SeedOption('GraphQL', false, 'Serverpod uses type-safe generated Dart RPC endpoints.'),
            _SeedOption('FTP', false, 'FTP is not used for API communication.'),
          ],
        ),
        // Q8: Text input (Algebra)
        _SeedQuestion(
          position: 8,
          prompt: 'If a rectangle has length 8 and width 6, what is its perimeter?',
          topic: 'Geometry',
          questionType: 'textInput',
          points: 10,
          expectedSeconds: 12,
          topicNote: 'Perimeter = 2 * (length + width) = 2 * (8 + 6) = 2 * 14 = 28.',
          helpHint: 'P = 2 * (l + w)',
          acceptedAnswers: ['28', '28.0', 'twenty eight', '٢٨'],
        ),
        // Q9: MCQ (Performance)
        _SeedQuestion(
          position: 9,
          prompt: 'In Reflex, which tier is assigned when a student answers correctly, on first attempt, and under expected time?',
          topic: 'Reflex Engine',
          questionType: 'multipleChoice',
          points: 15,
          expectedSeconds: 8,
          topicNote: 'Green Mastered is the highest tier, awarded only for clean, fast, first-try mastery.',
          helpHint: 'The chromatic green aura.',
          options: [
            _SeedOption('greenMastered (Green Aura)', true, 'Correct! Full mastery is clean, fast, and first try.'),
            _SeedOption('yellowDeveloping (Yellow Aura)', false, 'Yellow is given for slow or helped answers.'),
            _SeedOption('redNeedsWork (Red Aura)', false, 'Red is given for wrong answers.'),
            _SeedOption('blueIntermediate', false, 'Reflex uses a three-tier chromatic system: Red, Yellow, Green.'),
          ],
        ),
        // Q10: Text input (Dart)
        _SeedQuestion(
          position: 10,
          prompt: 'What is the name of Dart’s sealed class pattern modifier introduced in Dart 3.0?',
          topic: 'Dart Basics',
          questionType: 'textInput',
          points: 15,
          expectedSeconds: 10,
          topicNote: 'The sealed modifier enables exhaustive pattern matching with switch statements.',
          helpHint: 'sealed keyword.',
          acceptedAnswers: ['sealed', 'sealed class'],
        ),
      ];

      for (final seed in seedQuestions) {
        final insertedQ = await connection.execute(
          Sql.named('''
INSERT INTO question (
  "courseId", "position", "prompt", "topic", "questionType", "points",
  "expectedSeconds", "topicNote", "helpHint", "attemptCount",
  "attemptedStudentCount", "solvedStudentCount", "firstTrySolveCount",
  "underTimeSolveCount", "cleanSolveCount"
) VALUES (
  @cId, @pos, @prompt, @topic, @qType, @pts, @expSec, @tNote, @hHint, 0, 0, 0, 0, 0, 0
) RETURNING id;
'''),
          parameters: {
            'cId': courseId,
            'pos': seed.position,
            'prompt': seed.prompt,
            'topic': seed.topic,
            'qType': seed.questionType,
            'pts': seed.points,
            'expSec': seed.expectedSeconds,
            'tNote': seed.topicNote,
            'hHint': seed.helpHint,
          },
        );
        final qId = insertedQ.first.first as int;
        questionIds.add(qId);

        if (seed.options != null) {
          for (var optIdx = 0; optIdx < seed.options!.length; optIdx++) {
            final opt = seed.options![optIdx];
            await connection.execute(
              Sql.named('''
INSERT INTO question_option ("questionId", "position", "text", "isCorrect", "explanation")
VALUES (@qId, @pos, @text, @isCorrect, @exp);
'''),
              parameters: {
                'qId': qId,
                'pos': optIdx + 1,
                'text': opt.text,
                'isCorrect': opt.isCorrect,
                'exp': opt.explanation,
              },
            );
          }
        }

        if (seed.acceptedAnswers != null) {
          for (final ans in seed.acceptedAnswers!) {
            await connection.execute(
              Sql.named('''
INSERT INTO accepted_answer ("questionId", "normalizedText")
VALUES (@qId, @normText);
'''),
              parameters: {
                'qId': qId,
                'normText': ans,
              },
            );
          }
        }
      }
      print('✅ Successfully seeded 10 rich questions.');
    } else {
      final existingQ = await connection.execute(
        Sql.named('SELECT id FROM question WHERE "courseId" = @cId ORDER BY position;'),
        parameters: {'cId': courseId},
      );
      for (final row in existingQ) {
        questionIds.add(row.first as int);
      }
      print('ℹ️ Questions already present (${questionIds.length} found).');
    }

    // 5. Generate sample attempts for dashboard
    final attemptCheck = await connection.execute('SELECT COUNT(*) FROM attempt;');
    final attemptCount = attemptCheck.first.first as int;
    if (attemptCount == 0 && questionIds.length >= 5 && studentIds.length >= 3) {
      print('📊 Generating sample student cohort attempts for dashboard metrics...');
      final now = DateTime.now().toUtc();

      for (var sIdx = 1; sIdx < studentIds.length; sIdx++) {
        final sId = studentIds[sIdx];
        for (var qIdx = 0; qIdx < 5; qIdx++) {
          final qId = questionIds[qIdx];
          final isClean = (sIdx + qIdx) % 2 == 0;
          final status = isClean ? 'valid' : 'wrong';
          final tier = isClean ? 'greenMastered' : 'redNeedsWork';
          final latency = isClean ? 6000 : 25000;

          await connection.execute(
            Sql.named('''
INSERT INTO attempt (
  "learnerId", "questionId", "status", "responseMs", "usedHelp",
  "isFirstAttempt", "underExpectedTime", "isClean", "reflexTier", "createdAt"
) VALUES (
  @lId, @qId, @status, @respMs, @usedHelp, @firstAtt, @underTime, @clean, @tier, @created
);
'''),
            parameters: {
              'lId': sId,
              'qId': qId,
              'status': status,
              'respMs': latency,
              'usedHelp': !isClean,
              'firstAtt': true,
              'underTime': isClean,
              'clean': isClean,
              'tier': tier,
              'created': now.subtract(Duration(hours: sIdx * 2 + qIdx)),
            },
          );

          if (isClean) {
            await connection.execute(
              Sql.named('''
UPDATE question
SET "attemptCount" = "attemptCount" + 1,
    "attemptedStudentCount" = "attemptedStudentCount" + 1,
    "solvedStudentCount" = "solvedStudentCount" + 1,
    "firstTrySolveCount" = "firstTrySolveCount" + 1,
    "underTimeSolveCount" = "underTimeSolveCount" + 1,
    "cleanSolveCount" = "cleanSolveCount" + 1
WHERE id = @qId;
'''),
              parameters: {'qId': qId},
            );
          } else {
            await connection.execute(
              Sql.named('''
UPDATE question
SET "attemptCount" = "attemptCount" + 1,
    "attemptedStudentCount" = "attemptedStudentCount" + 1
WHERE id = @qId;
'''),
              parameters: {'qId': qId},
            );
          }
        }
      }
      print('✅ Sample cohort attempts generated.');
    } else {
      print('ℹ️ Attempts already present ($attemptCount found).');
    }

    print('🎉 Database seeding complete! Ready for development & demonstration.');
  } finally {
    await connection.close();
  }
  exit(0);
}

class _SeedQuestion {
  final int position;
  final String prompt;
  final String topic;
  final String questionType;
  final int points;
  final int expectedSeconds;
  final String topicNote;
  final String helpHint;
  final List<_SeedOption>? options;
  final List<String>? acceptedAnswers;

  const _SeedQuestion({
    required this.position,
    required this.prompt,
    required this.topic,
    required this.questionType,
    required this.points,
    required this.expectedSeconds,
    required this.topicNote,
    required this.helpHint,
    this.options,
    this.acceptedAnswers,
  });
}

class _SeedOption {
  final String text;
  final bool isCorrect;
  final String explanation;

  const _SeedOption(this.text, this.isCorrect, this.explanation);
}
