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

abstract class QuestionOption
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  QuestionOption._({
    this.id,
    required this.questionId,
    required this.position,
    required this.text,
    required this.isCorrect,
    this.explanation,
  });

  factory QuestionOption({
    int? id,
    required int questionId,
    required int position,
    required String text,
    required bool isCorrect,
    String? explanation,
  }) = _QuestionOptionImpl;

  factory QuestionOption.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionOption(
      id: jsonSerialization['id'] as int?,
      questionId: jsonSerialization['questionId'] as int,
      position: jsonSerialization['position'] as int,
      text: jsonSerialization['text'] as String,
      isCorrect: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isCorrect'],
      ),
      explanation: jsonSerialization['explanation'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionId;

  int position;

  String text;

  bool isCorrect;

  String? explanation;

  /// Returns a shallow copy of this [QuestionOption]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  QuestionOption copyWith({
    int? id,
    int? questionId,
    int? position,
    String? text,
    bool? isCorrect,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionOption',
      if (id != null) 'id': id,
      'questionId': questionId,
      'position': position,
      'text': text,
      'isCorrect': isCorrect,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionOption',
      if (id != null) 'id': id,
      'questionId': questionId,
      'position': position,
      'text': text,
      'isCorrect': isCorrect,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionOptionImpl extends QuestionOption {
  _QuestionOptionImpl({
    int? id,
    required int questionId,
    required int position,
    required String text,
    required bool isCorrect,
    String? explanation,
  }) : super._(
         id: id,
         questionId: questionId,
         position: position,
         text: text,
         isCorrect: isCorrect,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [QuestionOption]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  QuestionOption copyWith({
    Object? id = _Undefined,
    int? questionId,
    int? position,
    String? text,
    bool? isCorrect,
    Object? explanation = _Undefined,
  }) {
    return QuestionOption(
      id: id is int? ? id : this.id,
      questionId: questionId ?? this.questionId,
      position: position ?? this.position,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation is String? ? explanation : this.explanation,
    );
  }
}
