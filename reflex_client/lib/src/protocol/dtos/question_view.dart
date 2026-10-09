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
import 'package:reflex_client/src/protocol/protocol.dart' as _i733dxuy;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../dtos/question_option_view.dart' as _iz6tdjjw;
import '../enums/question_type.dart' as _it9pozz4;

abstract class QuestionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuestionView._({
    required this.id,
    required this.prompt,
    required this.topic,
    required this.questionType,
    this.options,
    required this.points,
    required this.expectedSeconds,
    required this.hasHelpHint,
  });

  factory QuestionView({
    required int id,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    List<_iz6tdjjw.QuestionOptionView>? options,
    required int points,
    required int expectedSeconds,
    required bool hasHelpHint,
  }) = _QuestionViewImpl;

  factory QuestionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionView(
      id: jsonSerialization['id'] as int,
      prompt: jsonSerialization['prompt'] as String,
      topic: jsonSerialization['topic'] as String,
      questionType: _it9pozz4.QuestionType.fromJson(
        (jsonSerialization['questionType'] as String),
      ),
      options: jsonSerialization['options'] == null
          ? null
          : _i733dxuy.Protocol()
                .deserialize<List<_iz6tdjjw.QuestionOptionView>>(
                  jsonSerialization['options'],
                ),
      points: jsonSerialization['points'] as int,
      expectedSeconds: jsonSerialization['expectedSeconds'] as int,
      hasHelpHint: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['hasHelpHint'],
      ),
    );
  }

  int id;

  String prompt;

  String topic;

  _it9pozz4.QuestionType questionType;

  List<_iz6tdjjw.QuestionOptionView>? options;

  int points;

  int expectedSeconds;

  bool hasHelpHint;

  /// Returns a shallow copy of this [QuestionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuestionView copyWith({
    int? id,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    List<_iz6tdjjw.QuestionOptionView>? options,
    int? points,
    int? expectedSeconds,
    bool? hasHelpHint,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionView',
      'id': id,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJson()),
      'points': points,
      'expectedSeconds': expectedSeconds,
      'hasHelpHint': hasHelpHint,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionView',
      'id': id,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      if (options != null)
        'options': options?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'points': points,
      'expectedSeconds': expectedSeconds,
      'hasHelpHint': hasHelpHint,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionViewImpl extends QuestionView {
  _QuestionViewImpl({
    required int id,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    List<_iz6tdjjw.QuestionOptionView>? options,
    required int points,
    required int expectedSeconds,
    required bool hasHelpHint,
  }) : super._(
         id: id,
         prompt: prompt,
         topic: topic,
         questionType: questionType,
         options: options,
         points: points,
         expectedSeconds: expectedSeconds,
         hasHelpHint: hasHelpHint,
       );

  /// Returns a shallow copy of this [QuestionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuestionView copyWith({
    int? id,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    Object? options = _Undefined,
    int? points,
    int? expectedSeconds,
    bool? hasHelpHint,
  }) {
    return QuestionView(
      id: id ?? this.id,
      prompt: prompt ?? this.prompt,
      topic: topic ?? this.topic,
      questionType: questionType ?? this.questionType,
      options: options is List<_iz6tdjjw.QuestionOptionView>?
          ? options
          : this.options?.map((e0) => e0.copyWith()).toList(),
      points: points ?? this.points,
      expectedSeconds: expectedSeconds ?? this.expectedSeconds,
      hasHelpHint: hasHelpHint ?? this.hasHelpHint,
    );
  }
}
