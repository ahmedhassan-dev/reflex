import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/providers/email.dart';

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
class EmailIdpEndpoint extends EmailIdpBaseEndpoint {
  /// Checks whether an email is already associated with an account.
  Future<bool> isEmailRegistered(Session session, {required String email}) async {
    final normalized = email.trim().toLowerCase();
    final count = await EmailAccount.db.count(
      session,
      where: (t) => t.email.equals(normalized),
    );
    return count > 0;
  }

  @override
  Future<UuidValue> startRegistration(
    Session session, {
    required String email,
  }) async {
    final normalized = email.trim().toLowerCase();
    final count = await EmailAccount.db.count(
      session,
      where: (t) => t.email.equals(normalized),
    );
    if (count > 0) {
      throw EmailAccountRequestException(
        reason: EmailAccountRequestExceptionReason.policyViolation,
      );
    }
    return super.startRegistration(session, email: email);
  }
}
