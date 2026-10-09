import 'package:serverpod/serverpod.dart';

/// Role-based access control scopes for Serverpod endpoints.
abstract class AppScopes {
  /// Teacher scope granting course authoring and analytics inspection rights.
  static const Scope teacher = Scope('teacher');

  /// Student scope granting flashcard practicing and progress viewing rights.
  static const Scope student = Scope('student');

  /// Administrative scope.
  static const Scope admin = Scope('admin');
}
