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

abstract class StudentProgress
    implements _is.SerializableModel, _is.ProtocolSerialization {
  StudentProgress._({
    required this.profileId,
    required this.displayName,
    required this.solvedCount,
    required this.cleanFirstTryCount,
    required this.avgResponseMs,
    this.studyStreakDays,
    this.totalScore,
  });

  factory StudentProgress({
    required int profileId,
    required String displayName,
    required int solvedCount,
    required int cleanFirstTryCount,
    required double avgResponseMs,
    int? studyStreakDays,
    int? totalScore,
  }) = _StudentProgressImpl;

  factory StudentProgress.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudentProgress(
      profileId: jsonSerialization['profileId'] as int,
      displayName: jsonSerialization['displayName'] as String,
      solvedCount: jsonSerialization['solvedCount'] as int,
      cleanFirstTryCount: jsonSerialization['cleanFirstTryCount'] as int,
      avgResponseMs: (jsonSerialization['avgResponseMs'] as num).toDouble(),
      studyStreakDays: jsonSerialization['studyStreakDays'] as int?,
      totalScore: jsonSerialization['totalScore'] as int?,
    );
  }

  int profileId;

  String displayName;

  int solvedCount;

  int cleanFirstTryCount;

  double avgResponseMs;

  int? studyStreakDays;

  int? totalScore;

  /// Returns a shallow copy of this [StudentProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  StudentProgress copyWith({
    int? profileId,
    String? displayName,
    int? solvedCount,
    int? cleanFirstTryCount,
    double? avgResponseMs,
    int? studyStreakDays,
    int? totalScore,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudentProgress',
      'profileId': profileId,
      'displayName': displayName,
      'solvedCount': solvedCount,
      'cleanFirstTryCount': cleanFirstTryCount,
      'avgResponseMs': avgResponseMs,
      if (studyStreakDays != null) 'studyStreakDays': studyStreakDays,
      if (totalScore != null) 'totalScore': totalScore,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'StudentProgress',
      'profileId': profileId,
      'displayName': displayName,
      'solvedCount': solvedCount,
      'cleanFirstTryCount': cleanFirstTryCount,
      'avgResponseMs': avgResponseMs,
      if (studyStreakDays != null) 'studyStreakDays': studyStreakDays,
      if (totalScore != null) 'totalScore': totalScore,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudentProgressImpl extends StudentProgress {
  _StudentProgressImpl({
    required int profileId,
    required String displayName,
    required int solvedCount,
    required int cleanFirstTryCount,
    required double avgResponseMs,
    int? studyStreakDays,
    int? totalScore,
  }) : super._(
         profileId: profileId,
         displayName: displayName,
         solvedCount: solvedCount,
         cleanFirstTryCount: cleanFirstTryCount,
         avgResponseMs: avgResponseMs,
         studyStreakDays: studyStreakDays,
         totalScore: totalScore,
       );

  /// Returns a shallow copy of this [StudentProgress]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  StudentProgress copyWith({
    int? profileId,
    String? displayName,
    int? solvedCount,
    int? cleanFirstTryCount,
    double? avgResponseMs,
    Object? studyStreakDays = _Undefined,
    Object? totalScore = _Undefined,
  }) {
    return StudentProgress(
      profileId: profileId ?? this.profileId,
      displayName: displayName ?? this.displayName,
      solvedCount: solvedCount ?? this.solvedCount,
      cleanFirstTryCount: cleanFirstTryCount ?? this.cleanFirstTryCount,
      avgResponseMs: avgResponseMs ?? this.avgResponseMs,
      studyStreakDays: studyStreakDays is int?
          ? studyStreakDays
          : this.studyStreakDays,
      totalScore: totalScore is int? ? totalScore : this.totalScore,
    );
  }
}
