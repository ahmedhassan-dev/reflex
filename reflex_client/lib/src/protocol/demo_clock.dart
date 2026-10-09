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

abstract class DemoClock
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  DemoClock._({
    this.id,
    required this.offsetDays,
  });

  factory DemoClock({
    int? id,
    required int offsetDays,
  }) = _DemoClockImpl;

  factory DemoClock.fromJson(Map<String, dynamic> jsonSerialization) {
    return DemoClock(
      id: jsonSerialization['id'] as int?,
      offsetDays: jsonSerialization['offsetDays'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int offsetDays;

  /// Returns a shallow copy of this [DemoClock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  DemoClock copyWith({
    int? id,
    int? offsetDays,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DemoClock',
      if (id != null) 'id': id,
      'offsetDays': offsetDays,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'DemoClock',
      if (id != null) 'id': id,
      'offsetDays': offsetDays,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DemoClockImpl extends DemoClock {
  _DemoClockImpl({
    int? id,
    required int offsetDays,
  }) : super._(
         id: id,
         offsetDays: offsetDays,
       );

  /// Returns a shallow copy of this [DemoClock]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  DemoClock copyWith({
    Object? id = _Undefined,
    int? offsetDays,
  }) {
    return DemoClock(
      id: id is int? ? id : this.id,
      offsetDays: offsetDays ?? this.offsetDays,
    );
  }
}
