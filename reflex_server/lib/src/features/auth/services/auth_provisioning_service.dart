import 'package:serverpod/serverpod.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/generated/protocol.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Ensures every authenticated Serverpod user is mapped to a domain [Profile] record.
class AuthProvisioningService {
  final IProfileRepository profileRepo;

  AuthProvisioningService({required this.profileRepo});

  /// Resolves the authenticated user from the session and returns their [Profile].
  /// Automatically provisions a new [Profile] on first login.
  Future<Profile> ensureProfileForSession(
    Session session, {
    String? defaultDisplayName,
    Role defaultRole = Role.student,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }

    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final existing = await profileRepo.findByAuthUserId(authUserId);

    // Attempt to resolve real full name and email from Serverpod auth user profile
    String? profileFullName;
    String? profileEmail;
    try {
      final rows = await session.db.unsafeQuery(
        'SELECT "fullName", "userName", "email" FROM "serverpod_auth_core_profile" WHERE "authUserId" = \'$authUserId\' LIMIT 1;',
      );
      if (rows.isNotEmpty) {
        final row = rows.first;
        final fn = row[0]?.toString();
        final un = row[1]?.toString();
        final em = row[2]?.toString();
        if (em != null && em.trim().isNotEmpty) {
          profileEmail = em.trim();
        }
        if (fn != null && fn.trim().isNotEmpty) {
          profileFullName = fn.trim();
        } else if (un != null && un.trim().isNotEmpty) {
          profileFullName = un.trim();
        } else if (em != null && em.trim().isNotEmpty) {
          profileFullName = em.split('@').first;
        }
      }
    } catch (_) {}

    if (existing != null) {
      var updated = false;
      if (profileFullName != null &&
          (existing.displayName.startsWith('Student ') ||
              existing.displayName.startsWith('Teacher '))) {
        existing.displayName = profileFullName;
        updated = true;
      }
      if (existing.email == null && profileEmail != null) {
        existing.email = profileEmail;
        updated = true;
      }
      if (updated) {
        return profileRepo.save(existing);
      }
      return existing;
    }

    final isTeacher = authInfo.scopes.contains(AppScopes.teacher);
    final uid = authUserId.uuid;
    String resolvedName;
    if (uid == '00000000-0000-4000-8000-000000000022') {
      resolvedName = 'Mr. Hassan (Teacher)';
    } else if (uid == '00000000-0000-4000-8000-000000000023') {
      resolvedName = 'Dr. Sarah (Teacher)';
    } else if (uid == '00000000-0000-4000-8000-000000000011') {
      resolvedName = 'Alice (Student)';
    } else if (uid == '00000000-0000-4000-8000-000000000012') {
      resolvedName = 'Bob (Student)';
    } else if (uid == '00000000-0000-4000-8000-000000000013') {
      resolvedName = 'Charlie (Student)';
    } else {
      resolvedName = profileFullName ??
          defaultDisplayName ??
          (isTeacher
              ? 'Teacher ${uid.substring(0, 8)}'
              : 'Student ${uid.substring(0, 8)}');
    }

    final newProfile = Profile(
      authUserId: authUserId,
      displayName: resolvedName,
      role: isTeacher ? Role.teacher : defaultRole,
      email: profileEmail,
    );

    return profileRepo.save(newProfile);
  }
}
