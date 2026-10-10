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

abstract class CreateOptionInput
    implements _is.SerializableModel, _is.ProtocolSerialization {
  CreateOptionInput._({
    required this.text,
    required this.isCorrect,
    this.explanation,
  });

  factory CreateOptionInput({
    required String text,
    required bool isCorrect,
    String? explanation,
  }) = _CreateOptionInputImpl;

  factory CreateOptionInput.fromJson(Map<String, dynamic> jsonSerialization) {
    return CreateOptionInput(
      text: jsonSerialization['text'] as String,
      isCorrect: _is.BoolJsonExtension.fromJson(jsonSerialization['isCorrect']),
      explanation: jsonSerialization['explanation'] as String?,
    );
  }

  String text;

  bool isCorrect;

  String? explanation;

  /// Returns a shallow copy of this [CreateOptionInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  CreateOptionInput copyWith({
    String? text,
    bool? isCorrect,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CreateOptionInput',
      'text': text,
      'isCorrect': isCorrect,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CreateOptionInput',
      'text': text,
      'isCorrect': isCorrect,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CreateOptionInputImpl extends CreateOptionInput {
  _CreateOptionInputImpl({
    required String text,
    required bool isCorrect,
    String? explanation,
  }) : super._(
         text: text,
         isCorrect: isCorrect,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [CreateOptionInput]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  CreateOptionInput copyWith({
    String? text,
    bool? isCorrect,
    Object? explanation = _Undefined,
  }) {
    return CreateOptionInput(
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation is String? ? explanation : this.explanation,
    );
  }
}
