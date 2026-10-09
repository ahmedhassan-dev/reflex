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
import '../dtos/question_insight.dart' as _ig48wp45;
import '../dtos/student_progress.dart' as _i85zhxbq;
import '../dtos/topic_mastery.dart' as _iqtmhuxf;

abstract class CohortSummary
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CohortSummary._({
    required this.mastery,
    required this.questions,
    required this.students,
  });

  factory CohortSummary({
    required List<_iqtmhuxf.TopicMastery> mastery,
    required List<_ig48wp45.QuestionInsight> questions,
    required List<_i85zhxbq.StudentProgress> students,
  }) = _CohortSummaryImpl;

  factory CohortSummary.fromJson(Map<String, dynamic> jsonSerialization) {
    return CohortSummary(
      mastery: _i733dxuy.Protocol().deserialize<List<_iqtmhuxf.TopicMastery>>(
        jsonSerialization['mastery'],
      ),
      questions: _i733dxuy.Protocol()
          .deserialize<List<_ig48wp45.QuestionInsight>>(
            jsonSerialization['questions'],
          ),
      students: _i733dxuy.Protocol()
          .deserialize<List<_i85zhxbq.StudentProgress>>(
            jsonSerialization['students'],
          ),
    );
  }

  List<_iqtmhuxf.TopicMastery> mastery;

  List<_ig48wp45.QuestionInsight> questions;

  List<_i85zhxbq.StudentProgress> students;

  /// Returns a shallow copy of this [CohortSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CohortSummary copyWith({
    List<_iqtmhuxf.TopicMastery>? mastery,
    List<_ig48wp45.QuestionInsight>? questions,
    List<_i85zhxbq.StudentProgress>? students,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CohortSummary',
      'mastery': mastery.toJson(valueToJson: (v) => v.toJson()),
      'questions': questions.toJson(valueToJson: (v) => v.toJson()),
      'students': students.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CohortSummary',
      'mastery': mastery.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'questions': questions.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'students': students.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _CohortSummaryImpl extends CohortSummary {
  _CohortSummaryImpl({
    required List<_iqtmhuxf.TopicMastery> mastery,
    required List<_ig48wp45.QuestionInsight> questions,
    required List<_i85zhxbq.StudentProgress> students,
  }) : super._(
         mastery: mastery,
         questions: questions,
         students: students,
       );

  /// Returns a shallow copy of this [CohortSummary]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CohortSummary copyWith({
    List<_iqtmhuxf.TopicMastery>? mastery,
    List<_ig48wp45.QuestionInsight>? questions,
    List<_i85zhxbq.StudentProgress>? students,
  }) {
    return CohortSummary(
      mastery: mastery ?? this.mastery.map((e0) => e0.copyWith()).toList(),
      questions:
          questions ?? this.questions.map((e0) => e0.copyWith()).toList(),
      students: students ?? this.students.map((e0) => e0.copyWith()).toList(),
    );
  }
}
