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
import '../enums/question_type.dart' as _it9pozz4;

abstract class QuestionInsight
    implements _is.SerializableModel, _is.ProtocolSerialization {
  QuestionInsight._({
    required this.questionId,
    required this.prompt,
    required this.topic,
    required this.questionType,
    required this.attemptCount,
    required this.solvedStudentCount,
    required this.firstTrySolveCount,
    required this.underTimeSolveCount,
    required this.cleanSolveCount,
    required this.firstTryRate,
    required this.cleanRate,
    required this.avgResponseMs,
  });

  factory QuestionInsight({
    required int questionId,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    required int attemptCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
    required double firstTryRate,
    required double cleanRate,
    required double avgResponseMs,
  }) = _QuestionInsightImpl;

  factory QuestionInsight.fromJson(Map<String, dynamic> jsonSerialization) {
    return QuestionInsight(
      questionId: jsonSerialization['questionId'] as int,
      prompt: jsonSerialization['prompt'] as String,
      topic: jsonSerialization['topic'] as String,
      questionType: _it9pozz4.QuestionType.fromJson(
        (jsonSerialization['questionType'] as String),
      ),
      attemptCount: jsonSerialization['attemptCount'] as int,
      solvedStudentCount: jsonSerialization['solvedStudentCount'] as int,
      firstTrySolveCount: jsonSerialization['firstTrySolveCount'] as int,
      underTimeSolveCount: jsonSerialization['underTimeSolveCount'] as int,
      cleanSolveCount: jsonSerialization['cleanSolveCount'] as int,
      firstTryRate: (jsonSerialization['firstTryRate'] as num).toDouble(),
      cleanRate: (jsonSerialization['cleanRate'] as num).toDouble(),
      avgResponseMs: (jsonSerialization['avgResponseMs'] as num).toDouble(),
    );
  }

  int questionId;

  String prompt;

  String topic;

  _it9pozz4.QuestionType questionType;

  int attemptCount;

  int solvedStudentCount;

  int firstTrySolveCount;

  int underTimeSolveCount;

  int cleanSolveCount;

  double firstTryRate;

  double cleanRate;

  double avgResponseMs;

  /// Returns a shallow copy of this [QuestionInsight]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  QuestionInsight copyWith({
    int? questionId,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    int? attemptCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
    double? firstTryRate,
    double? cleanRate,
    double? avgResponseMs,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'QuestionInsight',
      'questionId': questionId,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'attemptCount': attemptCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
      'firstTryRate': firstTryRate,
      'cleanRate': cleanRate,
      'avgResponseMs': avgResponseMs,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'QuestionInsight',
      'questionId': questionId,
      'prompt': prompt,
      'topic': topic,
      'questionType': questionType.toJson(),
      'attemptCount': attemptCount,
      'solvedStudentCount': solvedStudentCount,
      'firstTrySolveCount': firstTrySolveCount,
      'underTimeSolveCount': underTimeSolveCount,
      'cleanSolveCount': cleanSolveCount,
      'firstTryRate': firstTryRate,
      'cleanRate': cleanRate,
      'avgResponseMs': avgResponseMs,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _QuestionInsightImpl extends QuestionInsight {
  _QuestionInsightImpl({
    required int questionId,
    required String prompt,
    required String topic,
    required _it9pozz4.QuestionType questionType,
    required int attemptCount,
    required int solvedStudentCount,
    required int firstTrySolveCount,
    required int underTimeSolveCount,
    required int cleanSolveCount,
    required double firstTryRate,
    required double cleanRate,
    required double avgResponseMs,
  }) : super._(
         questionId: questionId,
         prompt: prompt,
         topic: topic,
         questionType: questionType,
         attemptCount: attemptCount,
         solvedStudentCount: solvedStudentCount,
         firstTrySolveCount: firstTrySolveCount,
         underTimeSolveCount: underTimeSolveCount,
         cleanSolveCount: cleanSolveCount,
         firstTryRate: firstTryRate,
         cleanRate: cleanRate,
         avgResponseMs: avgResponseMs,
       );

  /// Returns a shallow copy of this [QuestionInsight]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  QuestionInsight copyWith({
    int? questionId,
    String? prompt,
    String? topic,
    _it9pozz4.QuestionType? questionType,
    int? attemptCount,
    int? solvedStudentCount,
    int? firstTrySolveCount,
    int? underTimeSolveCount,
    int? cleanSolveCount,
    double? firstTryRate,
    double? cleanRate,
    double? avgResponseMs,
  }) {
    return QuestionInsight(
      questionId: questionId ?? this.questionId,
      prompt: prompt ?? this.prompt,
      topic: topic ?? this.topic,
      questionType: questionType ?? this.questionType,
      attemptCount: attemptCount ?? this.attemptCount,
      solvedStudentCount: solvedStudentCount ?? this.solvedStudentCount,
      firstTrySolveCount: firstTrySolveCount ?? this.firstTrySolveCount,
      underTimeSolveCount: underTimeSolveCount ?? this.underTimeSolveCount,
      cleanSolveCount: cleanSolveCount ?? this.cleanSolveCount,
      firstTryRate: firstTryRate ?? this.firstTryRate,
      cleanRate: cleanRate ?? this.cleanRate,
      avgResponseMs: avgResponseMs ?? this.avgResponseMs,
    );
  }
}
