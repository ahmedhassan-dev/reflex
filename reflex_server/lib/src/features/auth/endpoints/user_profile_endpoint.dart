import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:reflex_server/src/core/errors/exceptions.dart';
import 'package:reflex_server/src/data/repositories/serverpod_course_repositories.dart';
import 'package:reflex_server/src/data/repositories/serverpod_practice_repositories.dart';
import 'package:reflex_server/src/features/auth/services/account_deletion_service.dart';

/// By extending [UserProfileEditBaseEndpoint], user profile endpoints
/// (including uploading user image to Serverpod storage and removing it)
/// are exposed on the server.
class UserProfileEndpoint extends UserProfileEditBaseEndpoint {
  final AccountDeletionService? _accountDeletionService;

  UserProfileEndpoint({AccountDeletionService? accountDeletionService})
      : _accountDeletionService = accountDeletionService;

  /// Permanently deletes the authenticated user's account and associated data.
  Future<bool> deleteAccount(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      throw const UnauthorizedException('Authentication required.');
    }
    final authUserId = UuidValue.fromString(authInfo.userIdentifier);
    final service = _accountDeletionService ??
        AccountDeletionService(
          learnerRepo: ServerpodLearnerRepository(session),
          attemptRepo: ServerpodAttemptRepository(session),
          reviewStateRepo: ServerpodReviewStateRepository(session),
          subscriptionRepo: ServerpodCourseSubscriptionRepository(session),
          courseRepo: ServerpodCourseRepository(session),
        );
    await service.deleteUserAccount(session, authUserId);
    return true;
  }
}
