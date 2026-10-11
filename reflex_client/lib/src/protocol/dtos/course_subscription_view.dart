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
import '../enums/subscription_status.dart' as _i704759y;

abstract class CourseSubscriptionView
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  CourseSubscriptionView._({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.studentId,
    required this.studentName,
    required this.status,
    required this.requestedAt,
    this.decidedAt,
  });

  factory CourseSubscriptionView({
    required int id,
    required int courseId,
    required String courseTitle,
    required int studentId,
    required String studentName,
    required _i704759y.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) = _CourseSubscriptionViewImpl;

  factory CourseSubscriptionView.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CourseSubscriptionView(
      id: jsonSerialization['id'] as int,
      courseId: jsonSerialization['courseId'] as int,
      courseTitle: jsonSerialization['courseTitle'] as String,
      studentId: jsonSerialization['studentId'] as int,
      studentName: jsonSerialization['studentName'] as String,
      status: _i704759y.SubscriptionStatus.fromJson(
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

  int id;

  int courseId;

  String courseTitle;

  int studentId;

  String studentName;

  _i704759y.SubscriptionStatus status;

  DateTime requestedAt;

  DateTime? decidedAt;

  /// Returns a shallow copy of this [CourseSubscriptionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  CourseSubscriptionView copyWith({
    int? id,
    int? courseId,
    String? courseTitle,
    int? studentId,
    String? studentName,
    _i704759y.SubscriptionStatus? status,
    DateTime? requestedAt,
    DateTime? decidedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CourseSubscriptionView',
      'id': id,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'studentId': studentId,
      'studentName': studentName,
      'status': status.toJson(),
      'requestedAt': requestedAt.toJson(),
      if (decidedAt != null) 'decidedAt': decidedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'CourseSubscriptionView',
      'id': id,
      'courseId': courseId,
      'courseTitle': courseTitle,
      'studentId': studentId,
      'studentName': studentName,
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

class _CourseSubscriptionViewImpl extends CourseSubscriptionView {
  _CourseSubscriptionViewImpl({
    required int id,
    required int courseId,
    required String courseTitle,
    required int studentId,
    required String studentName,
    required _i704759y.SubscriptionStatus status,
    required DateTime requestedAt,
    DateTime? decidedAt,
  }) : super._(
         id: id,
         courseId: courseId,
         courseTitle: courseTitle,
         studentId: studentId,
         studentName: studentName,
         status: status,
         requestedAt: requestedAt,
         decidedAt: decidedAt,
       );

  /// Returns a shallow copy of this [CourseSubscriptionView]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  CourseSubscriptionView copyWith({
    int? id,
    int? courseId,
    String? courseTitle,
    int? studentId,
    String? studentName,
    _i704759y.SubscriptionStatus? status,
    DateTime? requestedAt,
    Object? decidedAt = _Undefined,
  }) {
    return CourseSubscriptionView(
      id: id ?? this.id,
      courseId: courseId ?? this.courseId,
      courseTitle: courseTitle ?? this.courseTitle,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      status: status ?? this.status,
      requestedAt: requestedAt ?? this.requestedAt,
      decidedAt: decidedAt is DateTime? ? decidedAt : this.decidedAt,
    );
  }
}
