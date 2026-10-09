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
import 'enums/attempt_status.dart' as _ir7impgi;

abstract class ReviewState
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ReviewState._({
    this.id,
    required this.learnerId,
    required this.questionId,
    required this.dueAt,
    required this.intervalDays,
    required this.lapses,
    required this.helpUsed,
    this.lastServedAt,
    this.lastResult,
  });

  factory ReviewState({
    int? id,
    required int learnerId,
    required int questionId,
    required DateTime dueAt,
    required int intervalDays,
    required int lapses,
    required bool helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  }) = _ReviewStateImpl;

  factory ReviewState.fromJson(Map<String, dynamic> jsonSerialization) {
    return ReviewState(
      id: jsonSerialization['id'] as int?,
      learnerId: jsonSerialization['learnerId'] as int,
      questionId: jsonSerialization['questionId'] as int,
      dueAt: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      intervalDays: jsonSerialization['intervalDays'] as int,
      lapses: jsonSerialization['lapses'] as int,
      helpUsed: _isc.BoolJsonExtension.fromJson(jsonSerialization['helpUsed']),
      lastServedAt: jsonSerialization['lastServedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastServedAt'],
            ),
      lastResult: jsonSerialization['lastResult'] == null
          ? null
          : _ir7impgi.AttemptStatus.fromJson(
              (jsonSerialization['lastResult'] as String),
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int learnerId;

  int questionId;

  DateTime dueAt;

  int intervalDays;

  int lapses;

  bool helpUsed;

  DateTime? lastServedAt;

  _ir7impgi.AttemptStatus? lastResult;

  /// Returns a shallow copy of this [ReviewState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ReviewState copyWith({
    int? id,
    int? learnerId,
    int? questionId,
    DateTime? dueAt,
    int? intervalDays,
    int? lapses,
    bool? helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ReviewState',
      if (id != null) 'id': id,
      'learnerId': learnerId,
      'questionId': questionId,
      'dueAt': dueAt.toJson(),
      'intervalDays': intervalDays,
      'lapses': lapses,
      'helpUsed': helpUsed,
      if (lastServedAt != null) 'lastServedAt': lastServedAt?.toJson(),
      if (lastResult != null) 'lastResult': lastResult?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ReviewState',
      if (id != null) 'id': id,
      'learnerId': learnerId,
      'questionId': questionId,
      'dueAt': dueAt.toJson(),
      'intervalDays': intervalDays,
      'lapses': lapses,
      'helpUsed': helpUsed,
      if (lastServedAt != null) 'lastServedAt': lastServedAt?.toJson(),
      if (lastResult != null) 'lastResult': lastResult?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ReviewStateImpl extends ReviewState {
  _ReviewStateImpl({
    int? id,
    required int learnerId,
    required int questionId,
    required DateTime dueAt,
    required int intervalDays,
    required int lapses,
    required bool helpUsed,
    DateTime? lastServedAt,
    _ir7impgi.AttemptStatus? lastResult,
  }) : super._(
         id: id,
         learnerId: learnerId,
         questionId: questionId,
         dueAt: dueAt,
         intervalDays: intervalDays,
         lapses: lapses,
         helpUsed: helpUsed,
         lastServedAt: lastServedAt,
         lastResult: lastResult,
       );

  /// Returns a shallow copy of this [ReviewState]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ReviewState copyWith({
    Object? id = _Undefined,
    int? learnerId,
    int? questionId,
    DateTime? dueAt,
    int? intervalDays,
    int? lapses,
    bool? helpUsed,
    Object? lastServedAt = _Undefined,
    Object? lastResult = _Undefined,
  }) {
    return ReviewState(
      id: id is int? ? id : this.id,
      learnerId: learnerId ?? this.learnerId,
      questionId: questionId ?? this.questionId,
      dueAt: dueAt ?? this.dueAt,
      intervalDays: intervalDays ?? this.intervalDays,
      lapses: lapses ?? this.lapses,
      helpUsed: helpUsed ?? this.helpUsed,
      lastServedAt: lastServedAt is DateTime?
          ? lastServedAt
          : this.lastServedAt,
      lastResult: lastResult is _ir7impgi.AttemptStatus?
          ? lastResult
          : this.lastResult,
    );
  }
}
