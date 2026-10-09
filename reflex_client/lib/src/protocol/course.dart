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

abstract class Course
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Course._({
    this.id,
    required this.title,
    required this.subject,
  });

  factory Course({
    int? id,
    required String title,
    required String subject,
  }) = _CourseImpl;

  factory Course.fromJson(Map<String, dynamic> jsonSerialization) {
    return Course(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      subject: jsonSerialization['subject'] as String,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String title;

  String subject;

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Course copyWith({
    int? id,
    String? title,
    String? subject,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      'subject': subject,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Course',
      if (id != null) 'id': id,
      'title': title,
      'subject': subject,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CourseImpl extends Course {
  _CourseImpl({
    int? id,
    required String title,
    required String subject,
  }) : super._(
         id: id,
         title: title,
         subject: subject,
       );

  /// Returns a shallow copy of this [Course]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Course copyWith({
    Object? id = _Undefined,
    String? title,
    String? subject,
  }) {
    return Course(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      subject: subject ?? this.subject,
    );
  }
}
