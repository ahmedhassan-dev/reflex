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

abstract class AcceptedAnswer
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AcceptedAnswer._({
    this.id,
    required this.questionId,
    required this.normalizedText,
  });

  factory AcceptedAnswer({
    int? id,
    required int questionId,
    required String normalizedText,
  }) = _AcceptedAnswerImpl;

  factory AcceptedAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcceptedAnswer(
      id: jsonSerialization['id'] as int?,
      questionId: jsonSerialization['questionId'] as int,
      normalizedText: jsonSerialization['normalizedText'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int questionId;

  String normalizedText;

  /// Returns a shallow copy of this [AcceptedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AcceptedAnswer copyWith({
    int? id,
    int? questionId,
    String? normalizedText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcceptedAnswer',
      if (id != null) 'id': id,
      'questionId': questionId,
      'normalizedText': normalizedText,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AcceptedAnswer',
      if (id != null) 'id': id,
      'questionId': questionId,
      'normalizedText': normalizedText,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcceptedAnswerImpl extends AcceptedAnswer {
  _AcceptedAnswerImpl({
    int? id,
    required int questionId,
    required String normalizedText,
  }) : super._(
         id: id,
         questionId: questionId,
         normalizedText: normalizedText,
       );

  /// Returns a shallow copy of this [AcceptedAnswer]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AcceptedAnswer copyWith({
    Object? id = _Undefined,
    int? questionId,
    String? normalizedText,
  }) {
    return AcceptedAnswer(
      id: id is int? ? id : this.id,
      questionId: questionId ?? this.questionId,
      normalizedText: normalizedText ?? this.normalizedText,
    );
  }
}
