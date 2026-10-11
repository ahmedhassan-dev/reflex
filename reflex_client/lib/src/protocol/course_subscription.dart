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
import 'enums/subscription_status.dart' as _i5d9goyo;

abstract class CourseSubscription
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CourseSubscription._({
    this.id,
    required this.courseId,
    required this.studentId,
    required this.status,
    required this.requestedAt,
    this.decidedAt,
  });

  factory CourseSubscription({
    int? id,
    required int courseId,
    required int studentId,
    required _i5d9goyo.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) = _CourseSubscriptionImpl;

  factory CourseSubscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return CourseSubscription(
      id: jsonSerialization['id'] as int?,
      courseId: jsonSerialization['courseId'] as int,
      studentId: jsonSerialization['studentId'] as int,
      status: _i5d9goyo.SubscriptionStatus.fromJson(
        (jsonSerialization['status'] as String),
      ),
      requestedAt: _isc.DateTimeJsonExtension.fromJson(
        jsonSerialization['requestedAt'],
      ),
      decidedAt: jsonSerialization['decidedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['decidedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int courseId;

  int studentId;

  _i5d9goyo.SubscriptionStatus status;

  DateTime requestedAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [CourseSubscription]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CourseSubscription copyWith({
    int? id,
    int? courseId,
    int? studentId,
    _i5d9goyo.SubscriptionStatus? status,
    DateTime? requestedAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSubscription',
      if (id != null) 'id': id,
      'courseId': courseId,
      'studentId': studentId,
      'status': status.toJson(),
      'requestedAt': requestedAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseSubscription',
      if (id != null) 'id': id,
      'courseId': courseId,
      'studentId': studentId,
      'status': status.toJson(),
      'requestedAt': requestedAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseSubscriptionImpl extends CourseSubscription {
  _CourseSubscriptionImpl({
    int? id,
    required int courseId,
    required int studentId,
    required _i5d9goyo.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         studentId: studentId,
         status: status,
         requestedAt: requestedAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [CourseSubscription]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CourseSubscription copyWith({
    Object? id = _Undefined,
    int? courseId,
    int? studentId,
    _i5d9goyo.SubscriptionStatus? status,
    DateTime? requestedAt,
    Object? decidedAt = _Undefined,
  }) {
    return CourseSubscription(
      id: id is int? ? id : this.id,
      courseId: courseId ?? this.courseId,
      studentId: studentId ?? this.studentId,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
