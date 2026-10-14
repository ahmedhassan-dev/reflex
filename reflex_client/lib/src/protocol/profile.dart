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
import 'enums/role.dart' as _iu4tij3a;

abstract class Profile
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
  Profile._({
    this.id,
    required this.authUserId,
    required this.displayName,
    required this.role,
    this.fcmToken,
    this.email,
  });

  factory Profile({
    int? id,
    required _isc.UuidValue authUserId,
    required String displayName,
    required _iu4tij3a.Role role,
    String? fcmToken,
    String? email,
  }) = _ProfileImpl;

  factory Profile.fromJson(Map<String, dynamic> jsonSerialization) {
    return Profile(
      id: jsonSerialization['id'] as int?,
      authUserId: _isc.UuidValueJsonExtension.fromJson(
        jsonSerialization['authUserId'],
      ),
      displayName: jsonSerialization['displayName'] as String,
      role: _iu4tij3a.Role.fromJson((jsonSerialization['role'] as String)),
      fcmToken: jsonSerialization['fcmToken'] as String?,
      email: jsonSerialization['email'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  _isc.UuidValue authUserId;

  String displayName;

  _iu4tij3a.Role role;

  String? fcmToken;

  String? email;

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  Profile copyWith({
    int? id,
    _isc.UuidValue? authUserId,
    String? displayName,
    _iu4tij3a.Role? role,
    String? fcmToken,
    String? email,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (fcmToken != null) 'fcmToken': fcmToken,
      if (email != null) 'email': email,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Profile',
      if (id != null) 'id': id,
      'authUserId': authUserId.toJson(),
      'displayName': displayName,
      'role': role.toJson(),
      if (fcmToken != null) 'fcmToken': fcmToken,
      if (email != null) 'email': email,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ProfileImpl extends Profile {
  _ProfileImpl({
    int? id,
    required _isc.UuidValue authUserId,
    required String displayName,
    required _iu4tij3a.Role role,
    String? fcmToken,
    String? email,
  }) : super._(
         id: id,
         authUserId: authUserId,
         displayName: displayName,
         role: role,
         fcmToken: fcmToken,
         email: email,
       );

  /// Returns a shallow copy of this [Profile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  Profile copyWith({
    Object? id = _Undefined,
    _isc.UuidValue? authUserId,
    String? displayName,
    _iu4tij3a.Role? role,
    Object? fcmToken = _Undefined,
    Object? email = _Undefined,
  }) {
    return Profile(
      id: id is int? ? id : this.id,
      authUserId: authUserId ?? this.authUserId,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      fcmToken: fcmToken is String? ? fcmToken : this.fcmToken,
      email: email is String? ? email : this.email,
    );
  }
}
