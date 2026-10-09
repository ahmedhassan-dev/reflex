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

abstract class HelpResult
    implements _is.SerializableModel, _is.ProtocolSerialization {
  HelpResult._({required this.helpHint});

  factory HelpResult({required String helpHint}) = _HelpResultImpl;

  factory HelpResult.fromJson(Map<String, dynamic> jsonSerialization) {
    return HelpResult(helpHint: jsonSerialization['helpHint'] as String);
  }

  String helpHint;

  /// Returns a shallow copy of this [HelpResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  HelpResult copyWith({String? helpHint});
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'HelpResult',
      'helpHint': helpHint,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'HelpResult',
      'helpHint': helpHint,
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _HelpResultImpl extends HelpResult {
  _HelpResultImpl({required String helpHint}) : super._(helpHint: helpHint);

  /// Returns a shallow copy of this [HelpResult]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  HelpResult copyWith({String? helpHint}) {
    return HelpResult(helpHint: helpHint ?? this.helpHint);
  }
}
