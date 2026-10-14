import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart';
import 'package:reflex_server/src/data/repositories/interfaces.dart';

/// Handles complete account and domain data deletion for a user.
class AccountDeletionService {
  final ILearnerRepository learnerRepo;
  final IAttemptRepository attemptRepo;
  final IReviewStateRepository reviewStateRepo;
  final ICourseSubscriptionRepository subscriptionRepo;
  final ICourseRepository courseRepo;

  AccountDeletionService({
    required this.learnerRepo,
    required this.attemptRepo,
    required this.reviewStateRepo,
    required this.subscriptionRepo,
    required this.courseRepo,
  });

  /// Deletes all domain data for the user (attempts, review states, subscriptions,
  /// teacher course associations, learner record) and removes the Serverpod auth user.
  Future<void> deleteUserAccount(Session session, UuidValue authUserId) async {
    final learner = await learnerRepo.findByAuthUserId(authUserId);
    if (learner != null && learner.id != null) {
      final learnerId = learner.id!;
      await attemptRepo.deleteByLearnerId(learnerId);
      await reviewStateRepo.deleteByLearnerId(learnerId);
      await subscriptionRepo.deleteByStudentId(learnerId);
      await courseRepo.unassignTeacher(learnerId);
      await learnerRepo.delete(learner);
    }

    try {
      await const AuthUsers().delete(session, authUserId: authUserId);
    } catch (e) {
      session.log('AuthUsers delete notice: $e', level: LogLevel.warning);
    }
  }
}
