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
import 'package:serverpod/serverpod.dart' as _is;

abstract class QuestionOptionView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuestionOptionView._({
    required this.id,
    required this.text,
  });

  factory QuestionOptionView({
    required int id,
    required String text,
  }) = _QuestionOptionViewImpl;

  factory QuestionOptionView.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionOptionView(
      id: jsonSerialization['id'] as int,
      text: jsonSerialization['text'] as String,
    );
  }

  int id;

  String text;

  /// Returns a shallow copy of this [QuestionOptionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuestionOptionView copyWith({
    int? id,
    String? text,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionOptionView',
      'id': id,
      'text': text,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionOptionView',
      'id': id,
      'text': text,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _QuestionOptionViewImpl extends QuestionOptionView {
  _QuestionOptionViewImpl({
    required int id,
    required String text,
  }) : super._(
         id: id,
         text: text,
       );

  /// Returns a shallow copy of this [QuestionOptionView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuestionOptionView copyWith({
    int? id,
    String? text,
  }) {
    return QuestionOptionView(
      id: id ?? this.id,
      text: text ?? this.text,
    );
  }
}
