// ignore_for_file: avoid_print, depend_on_referenced_packages
import 'dart:convert';
import 'dart:io';
import 'package:postgres/postgres.dart';

Future<void> main(List<String> args) async {
  print('🌱 Starting Reflex database seeder with rich courses, topics, questions & cohort data...');

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
    // 1. Ensure Teacher exists (Mr. Hassan)
    final teacherAuthId = '00000000-0000-4000-8000-000000000001';
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
    } else {
      print('ℹ️ Teacher Mr. Hassan verified in database.');
    }

    // 2. Ensure 5 Students exist (Alice, Bob, Charlie, Dana, Eman)
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

    // 3. Define 3 Rich Diverse Courses with Topics, Questions, and Rationales
    final coursesToSeed = [
      // -----------------------------------------------------------------------
      // COURSE 1: STEM Math & Dart Mastery
      // -----------------------------------------------------------------------
      _SeedCourse(
        title: 'STEM Math & Dart Mastery',
        subject: 'Computer Science & Mathematics',
        topics: [
          'Flutter Architecture',
          'Dart Basics',
          'Algebra',
          'Geometry',
          'Fractions',
          'State Management',
          'Serverpod Backend',
          'Reflex Engine',
        ],
        questions: [
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
        ],
      ),

      // -----------------------------------------------------------------------
      // COURSE 2: Physics: Mechanics & Kinematics
      // -----------------------------------------------------------------------
      _SeedCourse(
        title: 'Physics: Mechanics & Kinematics',
        subject: 'Physics',
        topics: [
          'Kinematics',
          'Newtonian Dynamics',
          'Work & Kinetic Energy',
          'Momentum & Collisions',
          'Circular Motion',
        ],
        questions: [
          _SeedQuestion(
            position: 1,
            prompt: 'An object is thrown vertically upwards with initial velocity 20 m/s. What is its velocity at the peak of its trajectory?',
            topic: 'Kinematics',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 8,
            topicNote: 'At the peak of vertical flight, vertical velocity v_y = 0 m/s before changing direction downward, while gravitational acceleration remains constant at 9.8 m/s².',
            helpHint: 'Consider what happens to the velocity right as the object stops ascending.',
            options: [
              _SeedOption('0 m/s', true, 'Correct! At maximum height, instantaneous vertical velocity is exactly zero.'),
              _SeedOption('9.8 m/s', false, 'Incorrect: 9.8 m/s² is acceleration due to gravity, not velocity.'),
              _SeedOption('20 m/s', false, 'Incorrect: 20 m/s was the initial launch velocity at ground level.'),
              _SeedOption('-9.8 m/s', false, 'Incorrect: That represents downward acceleration.'),
            ],
          ),
          _SeedQuestion(
            position: 2,
            prompt: 'According to Newton’s Second Law, if a 5 kg mass experiences a net force of 35 N, what is its acceleration in m/s²?',
            topic: 'Newtonian Dynamics',
            questionType: 'textInput',
            points: 15,
            expectedSeconds: 10,
            topicNote: 'From Newton’s Second Law (F = m * a), acceleration is a = F / m = 35 / 5 = 7 m/s².',
            helpHint: 'Use the formula a = F / m.',
            acceptedAnswers: ['7', '7.0', 'seven', '٧'],
          ),
          _SeedQuestion(
            position: 3,
            prompt: 'Which mechanical energy quantity is directly proportional to the square of an object’s velocity?',
            topic: 'Work & Kinetic Energy',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 10,
            topicNote: 'Kinetic energy is given by KE = 1/2 m v², meaning doubling the speed quadruples the kinetic energy.',
            helpHint: 'Formula involves 1/2 m v².',
            options: [
              _SeedOption('Kinetic Energy', true, 'Correct! KE = 1/2 m v² scales quadratically with speed.'),
              _SeedOption('Gravitational Potential Energy', false, 'Incorrect: GPE = m g h scales linearly with height.'),
              _SeedOption('Elastic Potential Energy', false, 'Incorrect: Elastic energy depends on spring displacement.'),
              _SeedOption('Linear Momentum', false, 'Incorrect: Momentum p = m v scales linearly with velocity.'),
            ],
          ),
          _SeedQuestion(
            position: 4,
            prompt: 'In a closed, isolated physical system with no net external forces, what happens to total linear momentum?',
            topic: 'Momentum & Collisions',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 10,
            topicNote: 'The Law of Conservation of Momentum dictates that total momentum remains constant across all collisions.',
            helpHint: 'Conservation principle.',
            options: [
              _SeedOption('It remains constant and conserved', true, 'Correct! Total momentum before equals total momentum after.'),
              _SeedOption('It is converted entirely into heat', false, 'Incorrect: Mechanical energy may dissipate, but momentum is always conserved.'),
              _SeedOption('It always decreases to zero', false, 'Incorrect: Momentum does not decay in an isolated system.'),
              _SeedOption('It fluctuates with velocity', false, 'Incorrect: Vector sum of momentum remains invariant.'),
            ],
          ),
          _SeedQuestion(
            position: 5,
            prompt: 'For a car moving in a circle of radius 20 m at 10 m/s, what is its centripetal acceleration in m/s²?',
            topic: 'Circular Motion',
            questionType: 'textInput',
            points: 15,
            expectedSeconds: 12,
            topicNote: 'Centripetal acceleration a_c = v² / r = (10²) / 20 = 100 / 20 = 5 m/s².',
            helpHint: 'Use a_c = v² / r.',
            acceptedAnswers: ['5', '5.0', 'five', '٥'],
          ),
        ],
      ),

      // -----------------------------------------------------------------------
      // COURSE 3: Biology & Cellular Foundations
      // -----------------------------------------------------------------------
      _SeedCourse(
        title: 'Biology & Cellular Foundations',
        subject: 'Natural Sciences',
        topics: [
          'Cell Structure',
          'Molecular Genetics',
          'Photosynthesis',
          'Cellular Respiration',
          'Enzyme Kinetics',
        ],
        questions: [
          _SeedQuestion(
            position: 1,
            prompt: 'Which cellular organelle is known as the powerhouse of the cell and produces ATP through oxidative phosphorylation?',
            topic: 'Cell Structure',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 8,
            topicNote: 'Mitochondria generate cellular energy (ATP) via the citric acid cycle and the electron transport chain on the inner cristae.',
            helpHint: 'The organelle that manufactures cellular ATP.',
            options: [
              _SeedOption('Mitochondria', true, 'Correct! Mitochondria produce over 90% of cellular ATP.'),
              _SeedOption('Ribosome', false, 'Incorrect: Ribosomes are responsible for protein synthesis.'),
              _SeedOption('Golgi Apparatus', false, 'Incorrect: The Golgi modifies, sorts, and packages macromolecules.'),
              _SeedOption('Endoplasmic Reticulum', false, 'Incorrect: The ER synthesizes proteins (rough) and lipids (smooth).'),
            ],
          ),
          _SeedQuestion(
            position: 2,
            prompt: 'How many hydrogen bonds connect Guanine (G) and Cytosine (C) in standard Watson-Crick DNA base pairing?',
            topic: 'Molecular Genetics',
            questionType: 'textInput',
            points: 15,
            expectedSeconds: 8,
            topicNote: 'Guanine and Cytosine form 3 hydrogen bonds, while Adenine and Thymine form 2.',
            helpHint: 'One more bond than the Adenine-Thymine base pair.',
            acceptedAnswers: ['3', '3.0', 'three', '٣'],
          ),
          _SeedQuestion(
            position: 3,
            prompt: 'What gas is produced as a direct byproduct of the photolysis of water during the light reactions of photosynthesis?',
            topic: 'Photosynthesis',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 8,
            topicNote: 'In Photosystem II, enzymes split water into hydrogen ions, electrons, and oxygen gas (O2), which is released into the atmosphere.',
            helpHint: 'The vital gas that organisms breathe.',
            options: [
              _SeedOption('Oxygen (O2)', true, 'Correct! Photolysis of H2O yields atmospheric O2.'),
              _SeedOption('Carbon Dioxide (CO2)', false, 'Incorrect: CO2 is consumed in the Calvin cycle, not produced here.'),
              _SeedOption('Nitrogen (N2)', false, 'Incorrect: Atmospheric nitrogen is not produced by photosynthesis.'),
              _SeedOption('Methane (CH4)', false, 'Incorrect: Methane is produced by methanogenic archaea.'),
            ],
          ),
          _SeedQuestion(
            position: 4,
            prompt: 'What is the primary organic molecule broken down during glycolysis to produce pyruvate?',
            topic: 'Cellular Respiration',
            questionType: 'multipleChoice',
            points: 10,
            expectedSeconds: 10,
            topicNote: 'Glycolysis is the anaerobic breakdown of 1 six-carbon glucose molecule into 2 three-carbon pyruvate molecules.',
            helpHint: 'The 6-carbon monosaccharide sugar.',
            options: [
              _SeedOption('Glucose', true, 'Correct! Glycolysis converts one glucose into two pyruvates.'),
              _SeedOption('Sucrose', false, 'Incorrect: Sucrose is a disaccharide that must first be cleaved.'),
              _SeedOption('Cellulose', false, 'Incorrect: Cellulose is a structural plant polysaccharide.'),
              _SeedOption('Lactose', false, 'Incorrect: Lactose is milk sugar, not the primary input to glycolysis.'),
            ],
          ),
        ],
      ),
    ];

    // 4. Seed each course, its topics, questions, options, and student attempts
    for (final courseSpec in coursesToSeed) {
      final topicsJson = jsonEncode(courseSpec.topics);

      // Check if course already exists
      final existingCourse = await connection.execute(
        Sql.named('SELECT id FROM course WHERE title = @title;'),
        parameters: {'title': courseSpec.title},
      );

      int courseId;
      if (existingCourse.isEmpty) {
        final inserted = await connection.execute(
          Sql.named('INSERT INTO course (title, subject, topics) VALUES (@title, @subject, @topics::json) RETURNING id;'),
          parameters: {
            'title': courseSpec.title,
            'subject': courseSpec.subject,
            'topics': topicsJson,
          },
        );
        courseId = inserted.first.first as int;
        print('📚 Created Course: "${courseSpec.title}" (ID: $courseId) with ${courseSpec.topics.length} topics');
      } else {
        courseId = existingCourse.first.first as int;
        // Ensure topics are up-to-date
        await connection.execute(
          Sql.named('UPDATE course SET topics = @topics::json, subject = @subject WHERE id = @id;'),
          parameters: {
            'id': courseId,
            'topics': topicsJson,
            'subject': courseSpec.subject,
          },
        );
        print('ℹ️ Updated topics for Course: "${courseSpec.title}" (ID: $courseId)');
      }

      // Check existing questions
      final qCheck = await connection.execute(
        Sql.named('SELECT COUNT(*) FROM question WHERE "courseId" = @cId;'),
        parameters: {'cId': courseId},
      );
      final qCount = qCheck.first.first as int;

      final courseQuestionIds = <int>[];
      if (qCount == 0) {
        print('  📝 Seeding ${courseSpec.questions.length} questions for "${courseSpec.title}"...');
        for (final seed in courseSpec.questions) {
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
          courseQuestionIds.add(qId);

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
        print('  ✅ Seeded ${courseQuestionIds.length} questions.');
      } else {
        final existingQ = await connection.execute(
          Sql.named('SELECT id FROM question WHERE "courseId" = @cId ORDER BY position;'),
          parameters: {'cId': courseId},
        );
        for (final row in existingQ) {
          courseQuestionIds.add(row.first as int);
        }
        print('  ℹ️ Questions already present (${courseQuestionIds.length} found).');
      }

      // 5. Generate sample student attempts for this course
      final courseAttemptCheck = await connection.execute(
        Sql.named('SELECT COUNT(*) FROM attempt WHERE "questionId" = ANY(@qIds);'),
        parameters: {'qIds': courseQuestionIds},
      );
      final courseAttemptCount = courseAttemptCheck.first.first as int;

      if (courseAttemptCount == 0 && courseQuestionIds.isNotEmpty && studentIds.isNotEmpty) {
        print('  📊 Generating realistic cohort attempt telemetry for "${courseSpec.title}"...');
        final now = DateTime.now().toUtc();

        for (var sIdx = 0; sIdx < studentIds.length; sIdx++) {
          final sId = studentIds[sIdx];
          for (var qIdx = 0; qIdx < courseQuestionIds.length; qIdx++) {
            final qId = courseQuestionIds[qIdx];
            final isClean = (sIdx + qIdx) % 2 == 0;
            final status = isClean ? 'valid' : 'wrong';
            final tier = isClean ? 'greenMastered' : 'redNeedsWork';
            final latency = isClean ? (4500 + sIdx * 500) : (18000 + sIdx * 1000);

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
                'created': now.subtract(Duration(hours: (sIdx + 1) * 3 + qIdx)),
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
        print('  ✅ Cohort attempt telemetry generated.');
      } else {
        print('  ℹ️ Cohort attempts already present ($courseAttemptCount found).');
      }
    }

    print('🎉 Database seeding complete! All courses, topics, questions, and telemetry are ready.');
  } finally {
    await connection.close();
  }
  exit(0);
}

class _SeedCourse {
  final String title;
  final String subject;
  final List<String> topics;
  final List<_SeedQuestion> questions;

  const _SeedCourse({
    required this.title,
    required this.subject,
    required this.topics,
    required this.questions,
  });
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
