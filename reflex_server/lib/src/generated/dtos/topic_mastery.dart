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

abstract class TopicMastery
    implements _is.SerializableModel, _is.ProtocolSerialization {
  TopicMastery._({
    required this.topic,
    required this.masteryRate,
  });

  factory TopicMastery({
    required String topic,
    required double masteryRate,
  }) = _TopicMasteryImpl;

  factory TopicMastery.fromJson(Map<String, dynamic> jsonSerialization) {
    return TopicMastery(
      topic: jsonSerialization['topic'] as String,
      masteryRate: (jsonSerialization['masteryRate'] as num).toDouble(),
    );
  }

  String topic;

  double masteryRate;

  /// Returns a shallow copy of this [TopicMastery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  TopicMastery copyWith({
    String? topic,
    double? masteryRate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'TopicMastery',
      'topic': topic,
      'masteryRate': masteryRate,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'TopicMastery',
      'topic': topic,
      'masteryRate': masteryRate,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _TopicMasteryImpl extends TopicMastery {
  _TopicMasteryImpl({
    required String topic,
    required double masteryRate,
  }) : super._(
         topic: topic,
         masteryRate: masteryRate,
       );

  /// Returns a shallow copy of this [TopicMastery]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  TopicMastery copyWith({
    String? topic,
    double? masteryRate,
  }) {
    return TopicMastery(
      topic: topic ?? this.topic,
      masteryRate: masteryRate ?? this.masteryRate,
    );
  }
}
