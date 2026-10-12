import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Ensures every authenticated Serverpod user is mapped to a domain [Learner] record.
class AuthProvisioningService {
  final ILearnerRepository learnerRepo;

  AuthProvisioningService({required this.learnerRepo});

  /// Resolves the authenticated user from the session and returns their [Learner] profile.
  /// Automatically provisions a new [Learner] on first login.
  Future<Learner> ensureLearnerForSession(
    Session session, {
    String? defaultDisplayName,
    Role defaultRole = Role.student,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }

    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final existing = await learnerRepo.findByAuthUserId(authUserId);
    if (existing != null) {
      return existing;
    }

    final isTeacher = authInfo.scopes.contains(AppScopes.teacher);
    final newLearner = Learner(
      authUserId: authUserId,
      displayName: defaultDisplayName ??
          (isTeacher
              ? 'Mr. Hassan (Teacher)'
              : 'Student ${authUserId.uuid.substring(0, 8)}'),
      role: isTeacher ? Role.teacher : defaultRole,
    );

    return learnerRepo.save(newLearner);
  }
}
