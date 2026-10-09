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
import '../dtos/option_explanation_view.dart' as _ivrdlgde;
import '../enums/attempt_status.dart' as _i0vhg68n;
import '../enums/reflex_tier.dart' as _in6r2tl6;
import '../enums/result_reason.dart' as _ih18v6li;

abstract class SubmitResult
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  SubmitResult._({
    required this.verdict,
    required this.reason,
    required this.reflexTier,
    required this.points,
    required this.responseMs,
    required this.nextDueAt,
    this.topicNote,
    this.selectedOptionExplanation,
    this.optionExplanations,
  });

  factory SubmitResult({
    required _i0vhg68n.AttemptStatus verdict,
    required _ih18v6li.ResultReason reason,
    required _in6r2tl6.ReflexTier reflexTier,
    required int points,
    required int responseMs,
    required DateTime nextDueAt,
    String? topicNote,
    String? selectedOptionExplanation,
    List<_ivrdlgde.OptionExplanationView>? optionExplanations,
  }) = _SubmitResultImpl;

  factory SubmitResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return SubmitResult(
      verdict: _i0vhg68n.AttemptStatus.fromJson(
        (jsonSerialization['verdict'] as String),
      ),
      reason: _ih18v6li.ResultReason.fromJson(
        (jsonSerialization['reason'] as String),
      ),
      reflexTier: _in6r2tl6.ReflexTier.fromJson(
        (jsonSerialization['reflexTier'] as String),
      ),
      points: jsonSerialization['points'] as int,
      responseMs: jsonSerialization['responseMs'] as int,
      nextDueAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['nextDueAt'],
      ),
      topicNote: jsonSerialization['topicNote'] as String?,
      selectedOptionExplanation:
          jsonSerialization['selectedOptionExplanation'] as String?,
      optionExplanations: jsonSerialization['optionExplanations'] == null
          ? null
          : _i733dxuy.Protocol()
                .deserialize<List<_ivrdlgde.OptionExplanationView>>(
                  jsonSerialization['optionExplanations'],
                ),
    );
  }

  _i0vhg68n.AttemptStatus verdict;

  _ih18v6li.ResultReason reason;

  _in6r2tl6.ReflexTier reflexTier;

  int points;

  int responseMs;

  DateTime nextDueAt;

  String? topicNote;

  String? selectedOptionExplanation;

  List<_ivrdlgde.OptionExplanationView>? optionExplanations;

  /// Returns a shallow copy of this [SubmitResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  SubmitResult copyWith({
    _i0vhg68n.AttemptStatus? verdict,
    _ih18v6li.ResultReason? reason,
    _in6r2tl6.ReflexTier? reflexTier,
    int? points,
    int? responseMs,
    DateTime? nextDueAt,
    String? topicNote,
    String? selectedOptionExplanation,
    List<_ivrdlgde.OptionExplanationView>? optionExplanations,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubmitResult',
      'verdict': verdict.toJson(),
      'reason': reason.toJson(),
      'reflexTier': reflexTier.toJson(),
      'points': points,
      'responseMs': responseMs,
      'nextDueAt': nextDueAt.toJson(),
      if (topicNote != null) 'topicNote': topicNote,
      if (selectedOptionExplanation != null)
        'selectedOptionExplanation': selectedOptionExplanation,
      if (optionExplanations != null)
        'optionExplanations': optionExplanations?.toJson(
          valueToJson: (v) => v.toJson(),
        ),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SubmitResult',
      'verdict': verdict.toJson(),
      'reason': reason.toJson(),
      'reflexTier': reflexTier.toJson(),
      'points': points,
      'responseMs': responseMs,
      'nextDueAt': nextDueAt.toJson(),
      if (topicNote != null) 'topicNote': topicNote,
      if (selectedOptionExplanation != null)
        'selectedOptionExplanation': selectedOptionExplanation,
      if (optionExplanations != null)
        'optionExplanations': optionExplanations?.toJson(
          valueToJson: (v) => v.toJsonForProtocol(),
        ),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubmitResultImpl extends SubmitResult {
  _SubmitResultImpl({
    required _i0vhg68n.AttemptStatus verdict,
    required _ih18v6li.ResultReason reason,
    required _in6r2tl6.ReflexTier reflexTier,
    required int points,
    required int responseMs,
    required DateTime nextDueAt,
    String? topicNote,
    String? selectedOptionExplanation,
    List<_ivrdlgde.OptionExplanationView>? optionExplanations,
  }) : super._(
         verdict: verdict,
         reason: reason,
         reflexTier: reflexTier,
         points: points,
         responseMs: responseMs,
         nextDueAt: nextDueAt,
         topicNote: topicNote,
         selectedOptionExplanation: selectedOptionExplanation,
         optionExplanations: optionExplanations,
       );

  /// Returns a shallow copy of this [SubmitResult]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  SubmitResult copyWith({
    _i0vhg68n.AttemptStatus? verdict,
    _ih18v6li.ResultReason? reason,
    _in6r2tl6.ReflexTier? reflexTier,
    int? points,
    int? responseMs,
    DateTime? nextDueAt,
    Object? topicNote = _Undefined,
    Object? selectedOptionExplanation = _Undefined,
    Object? optionExplanations = _Undefined,
  }) {
    return SubmitResult(
      verdict: verdict ?? this.verdict,
      reason: reason ?? this.reason,
      reflexTier: reflexTier ?? this.reflexTier,
      points: points ?? this.points,
      responseMs: responseMs ?? this.responseMs,
      nextDueAt: nextDueAt ?? this.nextDueAt,
      topicNote: topicNote is String? ? topicNote : this.topicNote,
      selectedOptionExplanation: selectedOptionExplanation is String?
          ? selectedOptionExplanation
          : this.selectedOptionExplanation,
      optionExplanations:
          optionExplanations is List<_ivrdlgde.OptionExplanationView>?
          ? optionExplanations
          : this.optionExplanations?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
