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
import 'dart:typed_data' as _idt;
import 'package:reflex_server/src/generated/dtos/create_question_input.dart'
    as _i27r3xjl;
import 'package:reflex_server/src/generated/enums/subscription_status.dart'
    as _ipub36mu;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../features/analytics/endpoints/analytics_endpoint.dart' as _iq2m74g2;
import '../features/auth/endpoints/email_idp_endpoint.dart' as _ikefcyg2;
import '../features/auth/endpoints/google_idp_endpoint.dart' as _i9fjg688;
import '../features/auth/endpoints/jwt_refresh_endpoint.dart' as _ifvnvxal;
import '../features/auth/endpoints/user_profile_endpoint.dart' as _ixcbvcae;
import '../features/demo_clock/endpoints/demo_clock_endpoint.dart' as _ibqt6ryp;
import '../features/greetings/endpoints/greeting_endpoint.dart' as _imxylvdf;
import '../features/practice/endpoints/practice_endpoint.dart' as _izjuq0o1;
import '../features/questions/endpoints/question_admin_endpoint.dart'
    as _i28c2dxt;

class Endpoints extends _is.EndpointDispatch {
  @override
  void initializeEndpoints(_is.Server server) {
    var endpoints = <String, _is.Endpoint>{
      'analytics': _iq2m74g2.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'emailIdp': _ikefcyg2.EmailIdpEndpoint()
        ..initialize(
          server,
          'emailIdp',
          null,
        ),
      'googleIdp': _i9fjg688.GoogleIdpEndpoint()
        ..initialize(
          server,
          'googleIdp',
          null,
        ),
      'jwtRefresh': _ifvnvxal.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
          null,
        ),
      'userProfile': _ixcbvcae.UserProfileEndpoint()
        ..initialize(
          server,
          'userProfile',
          null,
        ),
      'demoClock': _ibqt6ryp.DemoClockEndpoint()
        ..initialize(
          server,
          'demoClock',
          null,
        ),
      'greeting': _imxylvdf.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'practice': _izjuq0o1.PracticeEndpoint()
        ..initialize(
          server,
          'practice',
          null,
        ),
      'questionAdmin': _i28c2dxt.QuestionAdminEndpoint()
        ..initialize(
          server,
          'questionAdmin',
          null,
        ),
    };
    connectors['analytics'] = _is.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'getCohortSummary': _is.MethodConnector(
          name: 'getCohortSummary',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _iq2m74g2.AnalyticsEndpoint)
                  .getCohortSummary(
                    session,
                    params['courseId'],
                  ),
        ),
        'getMyProgress': _is.MethodConnector(
          name: 'getMyProgress',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['analytics'] as _iq2m74g2.AnalyticsEndpoint)
                  .getMyProgress(
                    session,
                    params['courseId'],
                  ),
        ),
      },
    );
    connectors['emailIdp'] = _is.EndpointConnector(
      name: 'emailIdp',
      endpoint: endpoints['emailIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint).login(
                    session,
                    email: params['email'],
                    password: params['password'],
                  ),
        ),
        'startRegistration': _is.MethodConnector(
          name: 'startRegistration',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .startRegistration(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyRegistrationCode': _is.MethodConnector(
          name: 'verifyRegistrationCode',
          params: {
            'accountRequestId': _is.ParameterDescription(
              name: 'accountRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .verifyRegistrationCode(
                    session,
                    accountRequestId: params['accountRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishRegistration': _is.MethodConnector(
          name: 'finishRegistration',
          params: {
            'registrationToken': _is.ParameterDescription(
              name: 'registrationToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'password': _is.ParameterDescription(
              name: 'password',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .finishRegistration(
                    session,
                    registrationToken: params['registrationToken'],
                    password: params['password'],
                  ),
        ),
        'startPasswordReset': _is.MethodConnector(
          name: 'startPasswordReset',
          params: {
            'email': _is.ParameterDescription(
              name: 'email',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .startPasswordReset(
                    session,
                    email: params['email'],
                  ),
        ),
        'verifyPasswordResetCode': _is.MethodConnector(
          name: 'verifyPasswordResetCode',
          params: {
            'passwordResetRequestId': _is.ParameterDescription(
              name: 'passwordResetRequestId',
              type: _is.getType<_is.UuidValue>(),
              nullable: false,
            ),
            'verificationCode': _is.ParameterDescription(
              name: 'verificationCode',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .verifyPasswordResetCode(
                    session,
                    passwordResetRequestId: params['passwordResetRequestId'],
                    verificationCode: params['verificationCode'],
                  ),
        ),
        'finishPasswordReset': _is.MethodConnector(
          name: 'finishPasswordReset',
          params: {
            'finishPasswordResetToken': _is.ParameterDescription(
              name: 'finishPasswordResetToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'newPassword': _is.ParameterDescription(
              name: 'newPassword',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .finishPasswordReset(
                    session,
                    finishPasswordResetToken:
                        params['finishPasswordResetToken'],
                    newPassword: params['newPassword'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['emailIdp'] as _ikefcyg2.EmailIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['googleIdp'] = _is.EndpointConnector(
      name: 'googleIdp',
      endpoint: endpoints['googleIdp']!,
      methodConnectors: {
        'login': _is.MethodConnector(
          name: 'login',
          params: {
            'idToken': _is.ParameterDescription(
              name: 'idToken',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'accessToken': _is.ParameterDescription(
              name: 'accessToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['googleIdp'] as _i9fjg688.GoogleIdpEndpoint).login(
                    session,
                    idToken: params['idToken'],
                    accessToken: params['accessToken'],
                  ),
        ),
        'loginWithCode': _is.MethodConnector(
          name: 'loginWithCode',
          params: {
            'code': _is.ParameterDescription(
              name: 'code',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'codeVerifier': _is.ParameterDescription(
              name: 'codeVerifier',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'redirectUri': _is.ParameterDescription(
              name: 'redirectUri',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i9fjg688.GoogleIdpEndpoint)
                  .loginWithCode(
                    session,
                    code: params['code'],
                    codeVerifier: params['codeVerifier'],
                    redirectUri: params['redirectUri'],
                  ),
        ),
        'hasAccount': _is.MethodConnector(
          name: 'hasAccount',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['googleIdp'] as _i9fjg688.GoogleIdpEndpoint)
                  .hasAccount(session),
        ),
      },
    );
    connectors['jwtRefresh'] = _is.EndpointConnector(
      name: 'jwtRefresh',
      endpoint: endpoints['jwtRefresh']!,
      methodConnectors: {
        'refreshAccessToken': _is.MethodConnector(
          name: 'refreshAccessToken',
          params: {
            'refreshToken': _is.ParameterDescription(
              name: 'refreshToken',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['jwtRefresh'] as _ifvnvxal.JwtRefreshEndpoint)
                      .refreshAccessToken(
                        session,
                        refreshToken: params['refreshToken'],
                      ),
        ),
      },
    );
    connectors['userProfile'] = _is.EndpointConnector(
      name: 'userProfile',
      endpoint: endpoints['userProfile']!,
      methodConnectors: {
        'removeUserImage': _is.MethodConnector(
          name: 'removeUserImage',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _ixcbvcae.UserProfileEndpoint)
                      .removeUserImage(session),
        ),
        'setUserImage': _is.MethodConnector(
          name: 'setUserImage',
          params: {
            'image': _is.ParameterDescription(
              name: 'image',
              type: _is.getType<_idt.ByteData>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _ixcbvcae.UserProfileEndpoint)
                      .setUserImage(
                        session,
                        params['image'],
                      ),
        ),
        'changeUserName': _is.MethodConnector(
          name: 'changeUserName',
          params: {
            'userName': _is.ParameterDescription(
              name: 'userName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _ixcbvcae.UserProfileEndpoint)
                      .changeUserName(
                        session,
                        params['userName'],
                      ),
        ),
        'changeFullName': _is.MethodConnector(
          name: 'changeFullName',
          params: {
            'fullName': _is.ParameterDescription(
              name: 'fullName',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _ixcbvcae.UserProfileEndpoint)
                      .changeFullName(
                        session,
                        params['fullName'],
                      ),
        ),
        'get': _is.MethodConnector(
          name: 'get',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['userProfile'] as _ixcbvcae.UserProfileEndpoint)
                      .get(session),
        ),
      },
    );
    connectors['demoClock'] = _is.EndpointConnector(
      name: 'demoClock',
      endpoint: endpoints['demoClock']!,
      methodConnectors: {
        'getOffsetDays': _is.MethodConnector(
          name: 'getOffsetDays',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['demoClock'] as _ibqt6ryp.DemoClockEndpoint)
                  .getOffsetDays(session),
        ),
        'setOffsetDays': _is.MethodConnector(
          name: 'setOffsetDays',
          params: {
            'offsetDays': _is.ParameterDescription(
              name: 'offsetDays',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['demoClock'] as _ibqt6ryp.DemoClockEndpoint)
                  .setOffsetDays(
                    session,
                    params['offsetDays'],
                  ),
        ),
        'advanceDays': _is.MethodConnector(
          name: 'advanceDays',
          params: {
            'days': _is.ParameterDescription(
              name: 'days',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['demoClock'] as _ibqt6ryp.DemoClockEndpoint)
                  .advanceDays(
                    session,
                    params['days'],
                  ),
        ),
        'resetClock': _is.MethodConnector(
          name: 'resetClock',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['demoClock'] as _ibqt6ryp.DemoClockEndpoint)
                  .resetClock(session),
        ),
      },
    );
    connectors['greeting'] = _is.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _is.MethodConnector(
          name: 'hello',
          params: {
            'name': _is.ParameterDescription(
              name: 'name',
              type: _is.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['greeting'] as _imxylvdf.GreetingEndpoint).hello(
                    session,
                    params['name'],
                  ),
        ),
      },
    );
    connectors['practice'] = _is.EndpointConnector(
      name: 'practice',
      endpoint: endpoints['practice']!,
      methodConnectors: {
        'listCourses': _is.MethodConnector(
          name: 'listCourses',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .listCourses(session),
        ),
        'serveNextCard': _is.MethodConnector(
          name: 'serveNextCard',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .serveNextCard(
                    session,
                    params['courseId'],
                  ),
        ),
        'requestHelp': _is.MethodConnector(
          name: 'requestHelp',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .requestHelp(
                    session,
                    params['questionId'],
                  ),
        ),
        'submitAnswer': _is.MethodConnector(
          name: 'submitAnswer',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'textAnswer': _is.ParameterDescription(
              name: 'textAnswer',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'optionId': _is.ParameterDescription(
              name: 'optionId',
              type: _is.getType<int?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .submitAnswer(
                    session,
                    params['questionId'],
                    textAnswer: params['textAnswer'],
                    optionId: params['optionId'],
                  ),
        ),
        'requestCourseSubscription': _is.MethodConnector(
          name: 'requestCourseSubscription',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .requestCourseSubscription(
                    session,
                    params['courseId'],
                  ),
        ),
        'getCourseSubscriptionStatus': _is.MethodConnector(
          name: 'getCourseSubscriptionStatus',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['practice'] as _izjuq0o1.PracticeEndpoint)
                  .getCourseSubscriptionStatus(
                    session,
                    params['courseId'],
                  ),
        ),
      },
    );
    connectors['questionAdmin'] = _is.EndpointConnector(
      name: 'questionAdmin',
      endpoint: endpoints['questionAdmin']!,
      methodConnectors: {
        'listCourses': _is.MethodConnector(
          name: 'listCourses',
          params: {},
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .listCourses(session),
        ),
        'createCourse': _is.MethodConnector(
          name: 'createCourse',
          params: {
            'title': _is.ParameterDescription(
              name: 'title',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'subject': _is.ParameterDescription(
              name: 'subject',
              type: _is.getType<String>(),
              nullable: false,
            ),
            'topics': _is.ParameterDescription(
              name: 'topics',
              type: _is.getType<List<String>?>(),
              nullable: true,
            ),
            'isPublic': _is.ParameterDescription(
              name: 'isPublic',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .createCourse(
                        session,
                        title: params['title'],
                        subject: params['subject'],
                        topics: params['topics'],
                        isPublic: params['isPublic'],
                      ),
        ),
        'updateCourseVisibility': _is.MethodConnector(
          name: 'updateCourseVisibility',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'isPublic': _is.ParameterDescription(
              name: 'isPublic',
              type: _is.getType<bool>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .updateCourseVisibility(
                        session,
                        courseId: params['courseId'],
                        isPublic: params['isPublic'],
                      ),
        ),
        'listSubscriptions': _is.MethodConnector(
          name: 'listSubscriptions',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .listSubscriptions(
                        session,
                        params['courseId'],
                      ),
        ),
        'respondToSubscription': _is.MethodConnector(
          name: 'respondToSubscription',
          params: {
            'subscriptionId': _is.ParameterDescription(
              name: 'subscriptionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'status': _is.ParameterDescription(
              name: 'status',
              type: _is.getType<_ipub36mu.SubscriptionStatus>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .respondToSubscription(
                        session,
                        subscriptionId: params['subscriptionId'],
                        status: params['status'],
                      ),
        ),
        'createQuestion': _is.MethodConnector(
          name: 'createQuestion',
          params: {
            'input': _is.ParameterDescription(
              name: 'input',
              type: _is.getType<_i27r3xjl.CreateQuestionInput>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .createQuestion(
                        session,
                        params['input'],
                      ),
        ),
        'updateTopicNoteAndHint': _is.MethodConnector(
          name: 'updateTopicNoteAndHint',
          params: {
            'questionId': _is.ParameterDescription(
              name: 'questionId',
              type: _is.getType<int>(),
              nullable: false,
            ),
            'topicNote': _is.ParameterDescription(
              name: 'topicNote',
              type: _is.getType<String?>(),
              nullable: true,
            ),
            'helpHint': _is.ParameterDescription(
              name: 'helpHint',
              type: _is.getType<String?>(),
              nullable: true,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .updateTopicNoteAndHint(
                        session,
                        params['questionId'],
                        topicNote: params['topicNote'],
                        helpHint: params['helpHint'],
                      ),
        ),
        'listQuestions': _is.MethodConnector(
          name: 'listQuestions',
          params: {
            'courseId': _is.ParameterDescription(
              name: 'courseId',
              type: _is.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _is.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['questionAdmin']
                          as _i28c2dxt.QuestionAdminEndpoint)
                      .listQuestions(
                        session,
                        params['courseId'],
                      ),
        ),
      },
    );
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
  }
}
