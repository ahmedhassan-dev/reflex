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
import 'enums/reflex_tier.dart' as _i8m78wq8;

abstract class Attempt
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Attempt._({
    this.id,
    required this.learnerId,
    required this.questionId,
    this.selectedOptionId,
    this.answerText,
    required this.status,
    required this.responseMs,
    required this.usedHelp,
    required this.isFirstAttempt,
    required this.underExpectedTime,
    required this.isClean,
    required this.reflexTier,
    required this.createdAt,
  });

  factory Attempt({
    int? id,
    required int learnerId,
    required int questionId,
    int? selectedOptionId,
    String? answerText,
    required _ir7impgi.AttemptStatus status,
    required int responseMs,
    required bool usedHelp,
    required bool isFirstAttempt,
    required bool underExpectedTime,
    required bool isClean,
    required _i8m78wq8.ReflexTier reflexTier,
    required DateTime createdAt,
  }) = _AttemptImpl;

  factory Attempt.fromJson(Map<String, dynamic> jsonSerialization) {
    return Attempt(
      id: jsonSerialization['id'] as int?,
      learnerId: jsonSerialization['learnerId'] as int,
      questionId: jsonSerialization['questionId'] as int,
      selectedOptionId: jsonSerialization['selectedOptionId'] as int?,
      answerText: jsonSerialization['answerText'] as String?,
      status: _ir7impgi.AttemptStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      responseMs: jsonSerialization['responseMs'] as int,
      usedHelp: _isc.BoolJsonExtension.fromJson(jsonSerialization['usedHelp']),
      isFirstAttempt: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['isFirstAttempt'],
      ),
      underExpectedTime: _isc.BoolJsonExtension.fromJson(
        jsonSerialization['underExpectedTime'],
      ),
      isClean: _isc.BoolJsonExtension.fromJson(jsonSerialization['isClean']),
      reflexTier: _i8m78wq8.ReflexTier.fromJson(
        (jsonSerialization['reflexTier'] as String),
      ),
      createdAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int learnerId;

  int questionId;

  int? selectedOptionId;

  String? answerText;

  _ir7impgi.AttemptStatus status;

  int responseMs;

  bool usedHelp;

  bool isFirstAttempt;

  bool underExpectedTime;

  bool isClean;

  _i8m78wq8.ReflexTier reflexTier;

  DateTime createdAt;

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Attempt copyWith({
    int? id,
    int? learnerId,
    int? questionId,
    int? selectedOptionId,
    String? answerText,
    _ir7impgi.AttemptStatus? status,
    int? responseMs,
    bool? usedHelp,
    bool? isFirstAttempt,
    bool? underExpectedTime,
    bool? isClean,
    _i8m78wq8.ReflexTier? reflexTier,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'learnerId': learnerId,
      'questionId': questionId,
      if (selectedOptionId != null) 'selectedOptionId': selectedOptionId,
      if (answerText != null) 'answerText': answerText,
      'status': status.toJson(),
      'responseMs': responseMs,
      'usedHelp': usedHelp,
      'isFirstAttempt': isFirstAttempt,
      'underExpectedTime': underExpectedTime,
      'isClean': isClean,
      'reflexTier': reflexTier.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Attempt',
      if (id != null) 'id': id,
      'learnerId': learnerId,
      'questionId': questionId,
      if (selectedOptionId != null) 'selectedOptionId': selectedOptionId,
      if (answerText != null) 'answerText': answerText,
      'status': status.toJson(),
      'responseMs': responseMs,
      'usedHelp': usedHelp,
      'isFirstAttempt': isFirstAttempt,
      'underExpectedTime': underExpectedTime,
      'isClean': isClean,
      'reflexTier': reflexTier.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AttemptImpl extends Attempt {
  _AttemptImpl({
    int? id,
    required int learnerId,
    required int questionId,
    int? selectedOptionId,
    String? answerText,
    required _ir7impgi.AttemptStatus status,
    required int responseMs,
    required bool usedHelp,
    required bool isFirstAttempt,
    required bool underExpectedTime,
    required bool isClean,
    required _i8m78wq8.ReflexTier reflexTier,
    required DateTime createdAt,
  }) : super._(
         id: id,
         learnerId: learnerId,
         questionId: questionId,
         selectedOptionId: selectedOptionId,
         answerText: answerText,
         status: status,
         responseMs: responseMs,
         usedHelp: usedHelp,
         isFirstAttempt: isFirstAttempt,
         underExpectedTime: underExpectedTime,
         isClean: isClean,
         reflexTier: reflexTier,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Attempt]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Attempt copyWith({
    Object? id = _Undefined,
    int? learnerId,
    int? questionId,
    Object? selectedOptionId = _Undefined,
    Object? answerText = _Undefined,
    _ir7impgi.AttemptStatus? status,
    int? responseMs,
    bool? usedHelp,
    bool? isFirstAttempt,
    bool? underExpectedTime,
    bool? isClean,
    _i8m78wq8.ReflexTier? reflexTier,
    DateTime? createdAt,
  }) {
    return Attempt(
      id: id is int? ? id : this.id,
      learnerId: learnerId ?? this.learnerId,
      questionId: questionId ?? this.questionId,
      selectedOptionId: selectedOptionId is int?
          ? selectedOptionId
          : this.selectedOptionId,
      answerText: answerText is String? ? answerText : this.answerText,
      status: status ?? this.status,
      responseMs: responseMs ?? this.responseMs,
      usedHelp: usedHelp ?? this.usedHelp,
      isFirstAttempt: isFirstAttempt ?? this.isFirstAttempt,
      underExpectedTime: underExpectedTime ?? this.underExpectedTime,
      isClean: isClean ?? this.isClean,
      reflexTier: reflexTier ?? this.reflexTier,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
