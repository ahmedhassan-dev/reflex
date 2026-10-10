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
import 'package:reflex_server/src/generated/protocol.dart' as _immqfr35;
import 'package:serverpod/serverpod.dart' as _is;
import '../dtos/create_option_input.dart' as _iqk7h4v1;
import '../enums/question_type.dart' as _it9pozz4;

abstract class CreateQuestionInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CreateQuestionInput._({
    required this.courseId,
    required this.prompt,
    required this.topic,
    required this.questionType,
    required this.points,
    required this.expectedSeconds,
    this.topicNote,
    this.helpHint,
    this.acceptedAnswers,
    this.options,
  });

  factory CreateQuestionInput({
    required int courseId,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    List<String>? acceptedAnswers,
    List<_iqk7h4v1.CreateOptionInput>? options,
  }) = _CreateQuestionInputImpl;

  factory CreateQuestionInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateQuestionInput(
      courseId: jsonSerialization['courseId'] as int,
      prompt: jsonSerialization['prompt'] as String,
      topic: jsonSerialization['topic'] as String,
      questionType: _it9pozz4.QuestionType.fromJson(
        (jsonSerialization['questionType'] as String),
      ),
      points: jsonSerialization['points'] as int,
      expectedSeconds: jsonSerialization['expectedSeconds'] as int,
      topicNote: jsonSerialization['topicNote'] as String?,
      helpHint: jsonSerialization['helpHint'] as String?,
      acceptedAnswers: jsonSerialization['acceptedAnswers'] == null
          ? null
          : _immqfr35.Protocol().deserialize<List<String>>(
              jsonSerialization['acceptedAnswers'],
            ),
      options: jsonSerialization['options'] == null
          ? null
          : _immqfr35.Protocol().deserialize<List<_iqk7h4v1.CreateOptionInput>>(
              jsonSerialization['options'],
            ),
    );
  }

  int courseId;

  String prompt;

  String topic;

  _it9pozz4.QuestionType questionType;

  int points;

  int expectedSeconds;

  String? topicNote;

  String? helpHint;

  List<String>? acceptedAnswers;

  List<_iqk7h4v1.CreateOptionInput>? options;

  /// Returns a shallow copy of this [CreateQuestionInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CreateQuestionInput copyWith({
    int? courseId,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    String? topicNote,
    String? helpHint,
    List<String>? acceptedAnswers,
    List<_iqk7h4v1.CreateOptionInput>? options,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateQuestionInput',
      'courseId': courseId,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      if (acceptedAnswers != null) 'acceptedAnswers': acceptedAnswers?.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateQuestionInput',
      'courseId': courseId,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'points': points,
      'expectedSeconds': expectedSeconds,
      if (topicNote != null) 'topicNote': topicNote,
      if (helpHint != null) 'helpHint': helpHint,
      if (acceptedAnswers != null) 'acceptedAnswers': acceptedAnswers?.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateQuestionInputImpl extends CreateQuestionInput {
  _CreateQuestionInputImpl({
    required int courseId,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    required int points,
    required int expectedSeconds,
    String? topicNote,
    String? helpHint,
    List<String>? acceptedAnswers,
    List<_iqk7h4v1.CreateOptionInput>? options,
  }) : super._(
         courseId: courseId,
         prompt: prompt,
         topic: topic,
         questionType: questionType,
         points: points,
         expectedSeconds: expectedSeconds,
         topicNote: topicNote,
         helpHint: helpHint,
         acceptedAnswers: acceptedAnswers,
         options: options,
       );

  /// Returns a shallow copy of this [CreateQuestionInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CreateQuestionInput copyWith({
    int? courseId,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    int? points,
    int? expectedSeconds,
    Object? topicNote = _Undefined,
    Object? helpHint = _Undefined,
    Object? acceptedAnswers = _Undefined,
    Object? options = _Undefined,
  }) {
    return CreateQuestionInput(
      courseId: courseId ?? this.courseId,
      prompt: prompt ?? this.prompt,
      topic: topic ?? this.topic,
      questionType: questionType ?? this.questionType,
      points: points ?? this.points,
      expectedSeconds: expectedSeconds ?? this.expectedSeconds,
      topicNote: topicNote is String? ? topicNote : this.topicNote,
      helpHint: helpHint is String? ? helpHint : this.helpHint,
      acceptedAnswers: acceptedAnswers is List<String>?
          ? acceptedAnswers
          : this.acceptedAnswers?.map((e0) => e0).toList(),
      options: options is List<_iqk7h4v1.CreateOptionInput>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
