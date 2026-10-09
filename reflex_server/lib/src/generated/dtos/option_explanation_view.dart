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

abstract class OptionExplanationView
    implements _is.SerializableModel, _is.ProtocolSerialization {
  OptionExplanationView._({
    required this.optionId,
    required this.text,
    required this.isCorrect,
    this.explanation,
  });

  factory OptionExplanationView({
    required int optionId,
    required String text,
    required bool isCorrect,
    String? explanation,
  }) = _OptionExplanationViewImpl;

  factory OptionExplanationView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OptionExplanationView(
      optionId: jsonSerialization['optionId'] as int,
      text: jsonSerialization['text'] as String,
      isCorrect: _is.BoolJsonExtension.fromJson(jsonSerialization['isCorrect']),
      explanation: jsonSerialization['explanation'] as String?,
    );
  }

  int optionId;

  String text;

  bool isCorrect;

  String? explanation;

  /// Returns a shallow copy of this [OptionExplanationView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  OptionExplanationView copyWith({
    int? optionId,
    String? text,
    bool? isCorrect,
    String? explanation,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OptionExplanationView',
      'optionId': optionId,
      'text': text,
      'isCorrect': isCorrect,
      if (explanation != null) 'explanation': explanation,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'OptionExplanationView',
      'optionId': optionId,
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

class _OptionExplanationViewImpl extends OptionExplanationView {
  _OptionExplanationViewImpl({
    required int optionId,
    required String text,
    required bool isCorrect,
    String? explanation,
  }) : super._(
         optionId: optionId,
         text: text,
         isCorrect: isCorrect,
         explanation: explanation,
       );

  /// Returns a shallow copy of this [OptionExplanationView]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  OptionExplanationView copyWith({
    int? optionId,
    String? text,
    bool? isCorrect,
    Object? explanation = _Undefined,
  }) {
    return OptionExplanationView(
      optionId: optionId ?? this.optionId,
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
      explanation: explanation is String? ? explanation : this.explanation,
    );
  }
}
