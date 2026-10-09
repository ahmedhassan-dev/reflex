/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'enums/question_type.dart' as _in2t4eqa;

abstract class Question
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Question._({
    this.id,
    required this.courseId,
    required this.position,
    required this.prompt,
    required this.topic,
    required this.questionType,
    required this.points,
    required this.expectedSeconds,
    this.topicNote,
    this.helpHint,
    required this.attemptCount,
    required this.attemptedStudentCount,
    required this.solvedStudentCount,
    required this.firstTrySolveCount,
    required this.underTimeSolveCount,
    required this.cleanSolveCount,
  });

  factory Question({
    int? id,
    required int courseId,
    required int position,
    required String prompt,
    required String topic,
    required _in2t4eqa.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    required int attemptCount,
    required int attemptedStudentCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      position: jsonSerialization['position'] as int,
      prompt: jsonSerialization['prompt'] as String,
      topic: jsonSerialization['topic'] as String,
      questionType: _in2t4eqa.QuestionType.fromJson(
        (jsonSerialization['questionType'] as String),
      ),
      points: jsonSerialization['points'] as int,
      expectedSeconds: jsonSerialization['expectedSeconds'] as int,
      topicNote: jsonSerialization['topicNote'] as String?,
      helpHint: jsonSerialization['helpHint'] as String?,
      attemptCount: jsonSerialization['attemptCount'] as int,
      attemptedStudentCount: jsonSerialization['attemptedStudentCount'] as int,
      solvedStudentCount: jsonSerialization['solvedStudentCount'] as int,
      firstTrySolveCount: jsonSerialization['firstTrySolveCount'] as int,
      underTimeSolveCount: jsonSerialization['underTimeSolveCount'] as int,
      cleanSolveCount: jsonSerialization['cleanSolveCount'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  int position;

  String prompt;

  String topic;

  _in2t4eqa.QuestionType questionType;

  int points;

  int expectedSeconds;

  String? topicNote;

  String? helpHint;

  int attemptCount;

  int attemptedStudentCount;

  int solvedStudentCount;

  int firstTrySolveCount;

  int underTimeSolveCount;

  int cleanSolveCount;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Question copyWith({
    int? id,
    int? courseId,
    int? position,
    String? prompt,
    String? topic,
    _in2t4eqa.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    String? topicNote,
    String? helpHint,
    int? attemptCount,
    int? attemptedStudentCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'courseId': courseId,
      'position': position,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      'attemptCount': attemptCount,
      'attemptedStudentCount': attemptedStudentCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Question',
      if (id != null) 'id': id,
      'courseId': courseId,
      'position': position,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      'attemptCount': attemptCount,
      'attemptedStudentCount': attemptedStudentCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int courseId,
    required int position,
    required String prompt,
    required String topic,
    required _in2t4eqa.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    required int attemptCount,
    required int attemptedStudentCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
  }) : super._(
         id: id,
         courseId: courseId,
         position: position,
         prompt: prompt,
         topic: topic,
         questionType: questionType,
         points: points,
         expectedSeconds: expectedSeconds,
         topicNote: topicNote,
         helpHint: helpHint,
         attemptCount: attemptCount,
         attemptedStudentCount: attemptedStudentCount,
         solvedStudentCount: solvedStudentCount,
         firstTrySolveCount: firstTrySolveCount,
         underTimeSolveCount: underTimeSolveCount,
         cleanSolveCount: cleanSolveCount,
       );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? position,
    String? prompt,
    String? topic,
    _in2t4eqa.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    Object? topicNote = _Undefined,
    Object? helpHint = _Undefined,
    int? attemptCount,
    int? attemptedStudentCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      position: position ?? this.position,
      prompt: prompt ?? this.prompt,
      topic: topic ?? this.topic,
      questionType: questionType ?? this.questionType,
      points: points ?? this.points,
      expectedSeconds: expectedSeconds ?? this.expectedSeconds,
      topicNote: topicNote is String? ? topicNote : this.topicNote,
      helpHint: helpHint is String? ? helpHint : this.helpHint,
      attemptCount: attemptCount ?? this.attemptCount,
      attemptedStudentCount:
          attemptedStudentCount ?? this.attemptedStudentCount,
      solvedStudentCount: solvedStudentCount ?? this.solvedStudentCount,
      firstTrySolveCount: firstTrySolveCount ?? this.firstTrySolveCount,
      underTimeSolveCount: underTimeSolveCount ?? this.underTimeSolveCount,
      cleanSolveCount: cleanSolveCount ?? this.cleanSolveCount,
    );
  }
}
