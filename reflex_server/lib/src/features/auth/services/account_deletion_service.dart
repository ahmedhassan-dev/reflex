import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Handles complete account and domain data deletion for a user.
class AccountDeletionService {
  final IProfileRepository profileRepo;
  final IAttemptRepository attemptRepo;
  final IReviewStateRepository reviewStateRepo;
  final ICourseSubscriptionRepository subscriptionRepo;
  final ICourseRepository courseRepo;

  AccountDeletionService({
    required this.profileRepo,
    required this.attemptRepo,
    required this.reviewStateRepo,
    required this.subscriptionRepo,
    required this.courseRepo,
  });

  /// Deletes all domain data for the user (attempts, review states, subscriptions,
  /// teacher course associations, profile record) and removes the Serverpod auth user.
  Future<void> deleteUserAccount(Session session, UuidValue authUserId) async {
    final profile = await profileRepo.findByAuthUserId(authUserId);
    if (profile != null && profile.id != null) {
      final profileId = profile.id!;
      await attemptRepo.deleteByProfileId(profileId);
      await reviewStateRepo.deleteByProfileId(profileId);
      await subscriptionRepo.deleteByStudentId(profileId);
      await courseRepo.unassignTeacher(profileId);
      await profileRepo.delete(profile);
    }

    try {
      await const AuthUsers().delete(session, authUserId: authUserId);
    } catch (e) {
      session.log('AuthUsers delete notice: $e', level: LogLevel.warning);
    }
  }
}
