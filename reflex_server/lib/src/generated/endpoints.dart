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
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;
import 'package:serverpod_auth_idp_server/serverpod_auth_idp_server.dart'
    as _iais;
import '../features/analytics/endpoints/analytics_endpoint.dart' as _iq2m74g2;
import '../features/auth/endpoints/email_idp_endpoint.dart' as _ikefcyg2;
import '../features/auth/endpoints/jwt_refresh_endpoint.dart' as _ifvnvxal;
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
      'jwtRefresh': _ifvnvxal.JwtRefreshEndpoint()
        ..initialize(
          server,
          'jwtRefresh',
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
      },
    );
    connectors['questionAdmin'] = _is.EndpointConnector(
      name: 'questionAdmin',
      endpoint: endpoints['questionAdmin']!,
      methodConnectors: {
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
    modules['serverpod_auth_idp'] = _iais.Endpoints()
      ..initializeEndpoints(server);
    modules['serverpod_auth_core'] = _iacs.Endpoints()
      ..initializeEndpoints(server);
  }
}
