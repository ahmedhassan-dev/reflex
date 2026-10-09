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
import '../dtos/question_view.dart' as _iqalp2t8;
import '../enums/card_kind.dart' as _iv8rtx5h;

abstract class PracticeItem
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  PracticeItem._({
    required this.question,
    required this.kind,
  });

  factory PracticeItem({
    required _iqalp2t8.QuestionView question,
    required _iv8rtx5h.CardKind kind,
  }) = _PracticeItemImpl;

  factory PracticeItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return PracticeItem(
      question: _i733dxuy.Protocol().deserialize<_iqalp2t8.QuestionView>(
        jsonSerialization['question'],
      ),
      kind: _iv8rtx5h.CardKind.fromJson((jsonSerialization['kind'] as String)),
    );
  }

  _iqalp2t8.QuestionView question;

  _iv8rtx5h.CardKind kind;

  /// Returns a shallow copy of this [PracticeItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  PracticeItem copyWith({
    _iqalp2t8.QuestionView? question,
    _iv8rtx5h.CardKind? kind,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PracticeItem',
      'question': question.toJson(),
      'kind': kind.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'PracticeItem',
      'question': question.toJsonForProtocol(),
      'kind': kind.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _PracticeItemImpl extends PracticeItem {
  _PracticeItemImpl({
    required _iqalp2t8.QuestionView question,
    required _iv8rtx5h.CardKind kind,
  }) : super._(
         question: question,
         kind: kind,
       );

  /// Returns a shallow copy of this [PracticeItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  PracticeItem copyWith({
    _iqalp2t8.QuestionView? question,
    _iv8rtx5h.CardKind? kind,
  }) {
    return PracticeItem(
      question: question ?? this.question.copyWith(),
      kind: kind ?? this.kind,
    );
  }
}
