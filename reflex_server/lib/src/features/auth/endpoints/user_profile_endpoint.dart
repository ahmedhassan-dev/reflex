import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:reflex_server/src/core/di/app_container.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/data/repositories/serverpod_course_repositories.dart';
import 'package:reflex_server/src/data/repositories/serverpod_practice_repositories.dart';
import 'package:reflex_server/src/features/auth/config/scopes.dart';
import 'package:reflex_server/src/features/auth/services/account_deletion_service.dart';
import 'package:reflex_server/src/generated/protocol.dart';

/// By extending [UserProfileEditBaseEndpoint], user profile endpoints
/// (including uploading user image to Serverpod storage and removing it)
/// are exposed on the server.
class UserProfileEndpoint extends UserProfileEditBaseEndpoint {
  final AccountDeletionService? _accountDeletionService;

  UserProfileEndpoint({AccountDeletionService? accountDeletionService})
      // ignore: prefer_initializing_formals
      : _accountDeletionService = accountDeletionService;

  /// Returns the user profile of the current user. Overrides base implementation
  /// to gracefully handle missing profile records without throwing 500 exceptions.
  @override
  Future<UserProfileModel> get(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final authUserId = UuidValue.fromString(authInfo.userIdentifier);

    // 1. Try to find existing serverpod user profile
    final existing = await userProfiles.maybeFindUserProfileByUserId(
      session,
      authUserId,
    );
    if (existing != null) {
      return existing;
    }

    // 2. Resolve domain profile for fallback display name and email
    final container = AppContainer(session);
    final domainProfile = await container.profileRepo.findByAuthUserId(authUserId);
    final displayName = domainProfile?.displayName ??
        (authInfo.scopes.contains(AppScopes.teacher) ? 'Teacher' : 'Student');
    final email = domainProfile?.email;

    // 3. Try creating the profile in serverpod_auth_core_profile
    try {
      return await userProfiles.createUserProfile(
        session,
        authUserId,
        UserProfileData(
          fullName: displayName,
          userName: displayName,
          email: email,
        ),
      );
    } catch (_) {
      // Fallback: return a valid memory UserProfileModel rather than crashing with 500
      final fallback = await userProfiles.maybeFindUserProfileByUserId(
        session,
        authUserId,
      );
      if (fallback != null) return fallback;

      return UserProfileModel(
        authUserId: authUserId,
        fullName: displayName,
        userName: displayName,
        email: email,
      );
    }
  }

  /// Ensures the authenticated user has a domain [Profile] record and synchronizes
  /// their role (Teacher or Student) and Serverpod scopes.
  Future<Profile> ensureProfile(
    Session session, {
    Role? role,
  }) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final container = AppContainer(session);
    final targetRole = role ?? Role.student;

    var profile = await container.profileRepo.findByAuthUserId(authUserId);
    profile ??= await container.resolveCurrentProfile(
      defaultRole: targetRole,
    );

    if (role != null && profile.role != role) {
      profile.role = role;
      profile = await container.profileRepo.save(profile);
    }

    try {
      await AuthServices.instance.authUsers.update(
        session,
        authUserId: authUserId,
        scopes: profile.role == Role.teacher ? {AppScopes.teacher} : {AppScopes.student},
      );
    } catch (_) {}

    return profile;
  }

  /// Returns the domain [Profile] of the currently authenticated user.
  Future<Profile> getMyProfile(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final container = AppContainer(session);
    return container.resolveCurrentProfile();
  }

  /// Updates the FCM device token for the authenticated user.
  Future<bool> updateFcmToken(Session session, {required String fcmToken}) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final repo = ServerpodProfileRepository(session);
    var profile = await repo.findByAuthUserId(authUserId);
    if (profile == null) {
      final container = AppContainer(session);
      profile = await container.resolveCurrentProfile();
    }
    profile.fcmToken = fcmToken;
    await repo.save(profile);
    return true;
  }

  /// Permanently deletes the authenticated user's account and associated data.
  Future<bool> deleteAccount(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final service = _accountDeletionService ??
        AccountDeletionService(
          profileRepo: ServerpodProfileRepository(session),
          attemptRepo: ServerpodAttemptRepository(session),
          reviewStateRepo: ServerpodReviewStateRepository(session),
          subscriptionRepo: ServerpodCourseSubscriptionRepository(session),
          courseRepo: ServerpodCourseRepository(session),
        );
    await service.deleteUserAccount(session, authUserId);
    return true;
  }
}
