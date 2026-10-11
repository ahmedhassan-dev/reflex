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
import 'dart:async' as _ida;
import 'package:http/http.dart' as _i85jenna;
import 'package:reflex_client/src/protocol/course.dart' as _irm1rqva;
import 'package:reflex_client/src/protocol/course_subscription.dart'
    as _im39ob9f;
import 'package:reflex_client/src/protocol/dtos/cohort_summary.dart'
    as _ipp2lvvc;
import 'package:reflex_client/src/protocol/dtos/course_subscription_view.dart'
    as _ienigelz;
import 'package:reflex_client/src/protocol/dtos/create_question_input.dart'
    as _igxwd1ae;
import 'package:reflex_client/src/protocol/dtos/help_result.dart' as _i38zaplx;
import 'package:reflex_client/src/protocol/dtos/practice_item.dart'
    as _izdle0db;
import 'package:reflex_client/src/protocol/dtos/student_progress.dart'
    as _ibk5hkxp;
import 'package:reflex_client/src/protocol/dtos/submit_result.dart'
    as _ida54fs3;
import 'package:reflex_client/src/protocol/enums/subscription_status.dart'
    as _iuzp1e2t;
import 'package:reflex_client/src/protocol/greetings/greeting.dart'
    as _igwxqmcb;
import 'package:reflex_client/src/protocol/question.dart' as _idjaghnf;
import 'package:serverpod_auth_core_client/serverpod_auth_core_client.dart'
    as _iacc;
import 'package:serverpod_auth_idp_client/serverpod_auth_idp_client.dart'
    as _iaic;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import 'protocol.dart' as _il2as5qe;

/// Endpoint delivering cohort-wide insights and individual student learning progress.
/// {@category Endpoint}
class EndpointAnalytics extends _isc.EndpointRef {
  EndpointAnalytics(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  /// Returns aggregated cohort metrics for teacher dashboard and question analytics.
  _ida.Future<_ipp2lvvc.CohortSummary> getCohortSummary(int courseId) =>
      caller.callServerEndpoint<_ipp2lvvc.CohortSummary>(
        'analytics',
        'getCohortSummary',
        {'courseId': courseId},
      );

  /// Returns progress metrics for the currently active student.
  _ida.Future<_ibk5hkxp.StudentProgress> getMyProgress(int courseId) =>
      caller.callServerEndpoint<_ibk5hkxp.StudentProgress>(
        'analytics',
        'getMyProgress',
        {'courseId': courseId},
      );
}

/// By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
/// are made available on the server and enable the corresponding sign-in widget
/// on the client.
/// {@category Endpoint}
class EndpointEmailIdp extends _iaic.EndpointEmailIdpBase {
  EndpointEmailIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'emailIdp';

  /// Logs in the user and returns a new session.
  ///
  /// Throws an [EmailAccountLoginException] in case of errors, with reason:
  /// - [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  ///   password is incorrect.
  /// - [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  ///   too many failed login attempts.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String email,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'login',
    {
      'email': email,
      'password': password,
    },
  );

  /// Starts the registration for a new user account with an email-based login
  /// associated to it.
  ///
  /// Upon successful completion of this method, an email will have been
  /// sent to [email] with a verification link, which the user must open to
  /// complete the registration.
  ///
  /// Always returns a account request ID, which can be used to complete the
  /// registration. If the email is already registered, the returned ID will not
  /// be valid.
  @override
  _ida.Future<_isc.UuidValue> startRegistration({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startRegistration',
        {'email': email},
      );

  /// Verifies an account request code and returns a token
  /// that can be used to complete the account creation.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if no request exists
  ///   for the given [accountRequestId] or [verificationCode] is invalid.
  @override
  _ida.Future<String> verifyRegistrationCode({
    required _isc.UuidValue accountRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyRegistrationCode',
    {
      'accountRequestId': accountRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a new account registration, creating a new auth user with a
  /// profile and attaching the given email account to it.
  ///
  /// Throws an [EmailAccountRequestException] in case of errors, with reason:
  /// - [EmailAccountRequestExceptionReason.expired] if the account request has
  ///   already expired.
  /// - [EmailAccountRequestExceptionReason.policyViolation] if the password
  ///   does not comply with the password policy.
  /// - [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  ///   is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  ///
  /// Returns a session for the newly created user.
  @override
  _ida.Future<_iacc.AuthSuccess> finishRegistration({
    required String registrationToken,
    required String password,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'emailIdp',
    'finishRegistration',
    {
      'registrationToken': registrationToken,
      'password': password,
    },
  );

  /// Requests a password reset for [email].
  ///
  /// If the email address is registered, an email with reset instructions will
  /// be send out. If the email is unknown, this method will have no effect.
  ///
  /// Always returns a password reset request ID, which can be used to complete
  /// the reset. If the email is not registered, the returned ID will not be
  /// valid.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to request a password reset.
  ///
  @override
  _ida.Future<_isc.UuidValue> startPasswordReset({required String email}) =>
      caller.callServerEndpoint<_isc.UuidValue>(
        'emailIdp',
        'startPasswordReset',
        {'email': email},
      );

  /// Verifies a password reset code and returns a finishPasswordResetToken
  /// that can be used to finish the password reset.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  ///   made too many attempts trying to verify the password reset.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// If multiple steps are required to complete the password reset, this endpoint
  /// should be overridden to return credentials for the next step instead
  /// of the credentials for setting the password.
  @override
  _ida.Future<String> verifyPasswordResetCode({
    required _isc.UuidValue passwordResetRequestId,
    required String verificationCode,
  }) => caller.callServerEndpoint<String>(
    'emailIdp',
    'verifyPasswordResetCode',
    {
      'passwordResetRequestId': passwordResetRequestId,
      'verificationCode': verificationCode,
    },
  );

  /// Completes a password reset request by setting a new password.
  ///
  /// The [verificationCode] returned from [verifyPasswordResetCode] is used to
  /// validate the password reset request.
  ///
  /// Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
  /// - [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  ///   request has already expired.
  /// - [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  ///   password does not comply with the password policy.
  /// - [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  ///   for the given [passwordResetRequestId] or [verificationCode] is invalid.
  ///
  /// Throws an [AuthUserBlockedException] if the auth user is blocked.
  @override
  _ida.Future<void> finishPasswordReset({
    required String finishPasswordResetToken,
    required String newPassword,
  }) => caller.callServerEndpoint<void>(
    'emailIdp',
    'finishPasswordReset',
    {
      'finishPasswordResetToken': finishPasswordResetToken,
      'newPassword': newPassword,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'emailIdp',
    'hasAccount',
    {},
  );
}

/// By extending [GoogleIdpBaseEndpoint], the Google identity provider endpoints
/// are made available on the server and enable Google OAuth sign-in on the client.
/// {@category Endpoint}
class EndpointGoogleIdp extends _iaic.EndpointGoogleIdpBase {
  EndpointGoogleIdp(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'googleIdp';

  /// Validates a Google ID token and either logs in the associated user or
  /// creates a new user account if the Google account ID is not yet known.
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> login({
    required String idToken,
    required String? accessToken,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'login',
    {
      'idToken': idToken,
      'accessToken': accessToken,
    },
  );

  /// Validates a Google authorization code from the web OAuth2 PKCE flow and
  /// either logs in the associated user or creates a new account.
  ///
  /// This is the web counterpart of [login], which accepts an ID token directly
  /// (used on native platforms via the `google_sign_in` package).
  ///
  /// If a new user is created an associated [UserProfile] is also created.
  @override
  _ida.Future<_iacc.AuthSuccess> loginWithCode({
    required String code,
    required String codeVerifier,
    required String redirectUri,
  }) => caller.callServerEndpoint<_iacc.AuthSuccess>(
    'googleIdp',
    'loginWithCode',
    {
      'code': code,
      'codeVerifier': codeVerifier,
      'redirectUri': redirectUri,
    },
  );

  @override
  _ida.Future<bool> hasAccount() => caller.callServerEndpoint<bool>(
    'googleIdp',
    'hasAccount',
    {},
  );
}

/// By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
/// is made available on the server and enables automatic token refresh on the client.
/// {@category Endpoint}
class EndpointJwtRefresh extends _iacc.EndpointRefreshJwtTokens {
  EndpointJwtRefresh(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'jwtRefresh';

  /// Creates a new token pair for the given [refreshToken].
  ///
  /// If [refreshToken] is omitted, cookie-mode web clients fall back to the
  /// configured HttpOnly refresh cookie. When neither source is present this
  /// throws [RefreshTokenNotFoundException], the same public "no usable refresh
  /// credential" exception used for unknown refresh tokens.
  ///
  /// Can throw the following exceptions:
  /// -[RefreshTokenMalformedException]: refresh token is malformed and could
  ///   not be parsed. Not expected to happen for tokens issued by the server.
  /// -[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  ///   Either the token was deleted or generated by a different server.
  /// -[RefreshTokenExpiredException]: refresh token has expired. Will happen
  ///   only if it has not been used within configured `refreshTokenLifetime`.
  /// -[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  ///   it does not refer to the current secret refresh token. This indicates
  ///   either a malfunctioning client or a malicious attempt by someone who has
  ///   obtained the refresh token. In this case the underlying refresh token
  ///   will be deleted, and access to it will expire fully when the last access
  ///   token is elapsed.
  ///
  /// This endpoint is unauthenticated, meaning the client won't include any
  /// authentication information with the call.
  @override
  _ida.Future<_iacc.AuthSuccess> refreshAccessToken({String? refreshToken}) =>
      caller.callServerEndpoint<_iacc.AuthSuccess>(
        'jwtRefresh',
        'refreshAccessToken',
        {'refreshToken': refreshToken},
        authenticated: false,
      );
}

/// Endpoint managing simulated time advancement for live demonstrations and testing.
/// {@category Endpoint}
class EndpointDemoClock extends _isc.EndpointRef {
  EndpointDemoClock(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'demoClock';

  /// Returns current simulated offset in days.
  _ida.Future<int> getOffsetDays() => caller.callServerEndpoint<int>(
    'demoClock',
    'getOffsetDays',
    {},
  );

  /// Sets the simulated offset to a specific number of days.
  _ida.Future<int> setOffsetDays(int offsetDays) =>
      caller.callServerEndpoint<int>(
        'demoClock',
        'setOffsetDays',
        {'offsetDays': offsetDays},
      );

  /// Advances the simulated time forward by [days].
  _ida.Future<int> advanceDays(int days) => caller.callServerEndpoint<int>(
    'demoClock',
    'advanceDays',
    {'days': days},
  );

  /// Resets the simulated clock back to current real-world time.
  _ida.Future<void> resetClock() => caller.callServerEndpoint<void>(
    'demoClock',
    'resetClock',
    {},
  );
}

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _isc.EndpointRef {
  EndpointGreeting(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _ida.Future<_igwxqmcb.Greeting> hello(String name) =>
      caller.callServerEndpoint<_igwxqmcb.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

/// Endpoint managing active flashcard practice, hints, and answer submissions.
/// {@category Endpoint}
class EndpointPractice extends _isc.EndpointRef {
  EndpointPractice(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'practice';

  /// Lists all courses available for practice.
  _ida.Future<List<_irm1rqva.Course>> listCourses() =>
      caller.callServerEndpoint<List<_irm1rqva.Course>>(
        'practice',
        'listCourses',
        {},
      );

  /// Serves the next card due for spaced repetition review or the next unattempted card.
  _ida.Future<_izdle0db.PracticeItem?> serveNextCard(int courseId) =>
      caller.callServerEndpoint<_izdle0db.PracticeItem?>(
        'practice',
        'serveNextCard',
        {'courseId': courseId},
      );

  /// Requests a help hint for the currently served card.
  _ida.Future<_i38zaplx.HelpResult> requestHelp(int questionId) =>
      caller.callServerEndpoint<_i38zaplx.HelpResult>(
        'practice',
        'requestHelp',
        {'questionId': questionId},
      );

  /// Submits an answer for the currently served question.
  _ida.Future<_ida54fs3.SubmitResult> submitAnswer(
    int questionId, {
    String? textAnswer,
    int? optionId,
  }) => caller.callServerEndpoint<_ida54fs3.SubmitResult>(
    'practice',
    'submitAnswer',
    {
      'questionId': questionId,
      'textAnswer': textAnswer,
      'optionId': optionId,
    },
  );

  /// Requests subscription to a private course.
  _ida.Future<_im39ob9f.CourseSubscription> requestCourseSubscription(
    int courseId,
  ) => caller.callServerEndpoint<_im39ob9f.CourseSubscription>(
    'practice',
    'requestCourseSubscription',
    {'courseId': courseId},
  );

  /// Checks subscription status of active learner for a course.
  _ida.Future<_iuzp1e2t.SubscriptionStatus?> getCourseSubscriptionStatus(
    int courseId,
  ) => caller.callServerEndpoint<_iuzp1e2t.SubscriptionStatus?>(
    'practice',
    'getCourseSubscriptionStatus',
    {'courseId': courseId},
  );
}

/// Endpoint allowing teachers to inspect questions, create courses/questions, update topic notes, and manage hints.
/// {@category Endpoint}
class EndpointQuestionAdmin extends _isc.EndpointRef {
  EndpointQuestionAdmin(_isc.EndpointCaller caller) : super(caller);

  @override
  String get name => 'questionAdmin';

  /// Lists all courses.
  _ida.Future<List<_irm1rqva.Course>> listCourses() =>
      caller.callServerEndpoint<List<_irm1rqva.Course>>(
        'questionAdmin',
        'listCourses',
        {},
      );

  /// Creates a new course.
  _ida.Future<_irm1rqva.Course> createCourse({
    required String title,
    required String subject,
    List<String>? topics,
    required bool isPublic,
  }) => caller.callServerEndpoint<_irm1rqva.Course>(
    'questionAdmin',
    'createCourse',
    {
      'title': title,
      'subject': subject,
      'topics': topics,
      'isPublic': isPublic,
    },
  );

  /// Updates course visibility (public vs private).
  _ida.Future<_irm1rqva.Course> updateCourseVisibility({
    required int courseId,
    required bool isPublic,
  }) => caller.callServerEndpoint<_irm1rqva.Course>(
    'questionAdmin',
    'updateCourseVisibility',
    {
      'courseId': courseId,
      'isPublic': isPublic,
    },
  );

  /// Lists student subscription requests for a course.
  _ida.Future<List<_ienigelz.CourseSubscriptionView>> listSubscriptions(
    int courseId,
  ) => caller.callServerEndpoint<List<_ienigelz.CourseSubscriptionView>>(
    'questionAdmin',
    'listSubscriptions',
    {'courseId': courseId},
  );

  /// Accepts or rejects a student's course subscription request.
  _ida.Future<_im39ob9f.CourseSubscription> respondToSubscription({
    required int subscriptionId,
    required _iuzp1e2t.SubscriptionStatus status,
  }) => caller.callServerEndpoint<_im39ob9f.CourseSubscription>(
    'questionAdmin',
    'respondToSubscription',
    {
      'subscriptionId': subscriptionId,
      'status': status,
    },
  );

  /// Creates a new question with options or accepted answers.
  _ida.Future<_idjaghnf.Question> createQuestion(
    _igxwd1ae.CreateQuestionInput input,
  ) => caller.callServerEndpoint<_idjaghnf.Question>(
    'questionAdmin',
    'createQuestion',
    {'input': input},
  );

  /// Updates teacher topic explanation note and help hint for a question.
  _ida.Future<_idjaghnf.Question> updateTopicNoteAndHint(
    int questionId, {
    String? topicNote,
    String? helpHint,
  }) => caller.callServerEndpoint<_idjaghnf.Question>(
    'questionAdmin',
    'updateTopicNoteAndHint',
    {
      'questionId': questionId,
      'topicNote': topicNote,
      'helpHint': helpHint,
    },
  );

  /// Lists all questions belonging to a course.
  _ida.Future<List<_idjaghnf.Question>> listQuestions(int courseId) =>
      caller.callServerEndpoint<List<_idjaghnf.Question>>(
        'questionAdmin',
        'listQuestions',
        {'courseId': courseId},
      );
}

class Modules {
  Modules(Client client) {
    serverpod_auth_idp = _iaic.Caller(client);
    serverpod_auth_core = _iacc.Caller(client);
  }

  late final _iaic.Caller serverpod_auth_idp;

  late final _iacc.Caller serverpod_auth_core;
}

class Client extends _isc.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _isc.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_isc.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
    _i85jenna.Client? httpClientOverride,
  }) : super(
         host,
         _il2as5qe.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
         httpClientOverride: httpClientOverride,
       ) {
    analytics = EndpointAnalytics(this);
    emailIdp = EndpointEmailIdp(this);
    googleIdp = EndpointGoogleIdp(this);
    jwtRefresh = EndpointJwtRefresh(this);
    demoClock = EndpointDemoClock(this);
    greeting = EndpointGreeting(this);
    practice = EndpointPractice(this);
    questionAdmin = EndpointQuestionAdmin(this);
    modules = Modules(this);
  }

  late final EndpointAnalytics analytics;

  late final EndpointEmailIdp emailIdp;

  late final EndpointGoogleIdp googleIdp;

  late final EndpointJwtRefresh jwtRefresh;

  late final EndpointDemoClock demoClock;

  late final EndpointGreeting greeting;

  late final EndpointPractice practice;

  late final EndpointQuestionAdmin questionAdmin;

  late final Modules modules;

  @override
  Map<String, _isc.EndpointRef> get endpointRefLookup => {
    'analytics': analytics,
    'emailIdp': emailIdp,
    'googleIdp': googleIdp,
    'jwtRefresh': jwtRefresh,
    'demoClock': demoClock,
    'greeting': greeting,
    'practice': practice,
    'questionAdmin': questionAdmin,
  };

  @override
  Map<String, _isc.ModuleEndpointCaller> get moduleLookup => {
    'serverpod_auth_idp': modules.serverpod_auth_idp,
    'serverpod_auth_core': modules.serverpod_auth_core,
  };
}
