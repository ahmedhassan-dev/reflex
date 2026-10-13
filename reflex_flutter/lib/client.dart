import "dart:async";

import "package:flutter/foundation.dart";
import "package:reflex_client/reflex_client.dart";
import "package:sentry_flutter/sentry_flutter.dart";
import "package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart";
import "package:serverpod_flutter/serverpod_flutter.dart";

// When you are running the app on a physical device, you need to set the
// server URL to the IP address of your computer. You can find the IP
// address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
//
// You can set the variable when running or building your app like this:
// E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`.
//
// Otherwise, the server URL is fetched from the assets/config.json file or
// defaults to http://$localhost:8080/ if not found.
final serverUrl = getServerUrl();

FlutterAuthSessionManager? authSessionManager;
bool isDemoUserActive = false;

/// Safely checks whether the user is authenticated, without throwing in tests.
bool get isUserAuthenticated => authSessionManager?.isAuthenticated ?? false;

Future<void> _signInDemoWith(String token, String uuid, String scope) async {
  isDemoUserActive = true;
  await authSessionManager?.updateSignedInUser(
    AuthSuccess(
      authStrategy: 'session',
      token: token,
      authUserId: UuidValue.fromString(uuid),
      scopeNames: {scope},
    ),
  );
}

/// Authenticates the client session as Teacher Mr. Hassan
Future<void> signInDemoTeacher() =>
    _signInDemoWith('demo-teacher-token', '00000000-0000-4000-8000-000000000022', 'teacher');

/// Authenticates the client session as Teacher Dr. Sarah
Future<void> signInDemoTeacherSarah() =>
    _signInDemoWith('demo-teacher-sarah-token', '00000000-0000-4000-8000-000000000023', 'teacher');

/// Authenticates the client session as Student Alice
Future<void> signInDemoStudent() =>
    _signInDemoWith('demo-student-token', '00000000-0000-4000-8000-000000000011', 'student');

/// Authenticates the client session as Student Bob
Future<void> signInDemoStudentBob() =>
    _signInDemoWith('demo-student-bob-token', '00000000-0000-4000-8000-000000000012', 'student');

/// Authenticates the client session as Student Charlie
Future<void> signInDemoStudentCharlie() =>
    _signInDemoWith('demo-student-charlie-token', '00000000-0000-4000-8000-000000000013', 'student');

/// Clears the active demo session or signs out authenticated user.
Future<void> signOutDemo() async {
  isDemoUserActive = false;
  try {
    await client.auth.signOutDevice();
  } catch (_) {
    await authSessionManager?.updateSignedInUser(null);
  }
}

/// Fetches profile information (full name and public image URL) for the active authenticated user.
Future<({String? name, String? imageUrl})> fetchCurrentUserProfile() async {
  if (isDemoUserActive || !isUserAuthenticated) {
    return (name: null, imageUrl: null);
  }
  try {
    final profile = await client.userProfile.get();
    final name = profile.fullName?.isNotEmpty == true
        ? profile.fullName
        : (profile.userName?.isNotEmpty == true ? profile.userName : profile.email);
    final imageUrl = profile.imageUrl?.toString();
    return (name: name, imageUrl: imageUrl);
  } catch (e) {
    debugPrint('[UserProfile] Error fetching profile: $e');
    return (name: null, imageUrl: null);
  }
}

/// Sets up a global client object that can be used to talk to the server from
/// anywhere in our app. The client is generated from your server code
/// and is set up to connect to a Serverpod running on a local server on
/// the default port. You will need to modify this to connect to staging or
/// production servers.
/// In a larger app, you may want to use the dependency injection of your choice
/// instead of using a global client object. This is just a simple example.
late final Client client;

Future<void> initializeClient() async {
  final manager = authSessionManager = FlutterAuthSessionManager();
  client = Client(await serverUrl)
    ..connectivityMonitor = FlutterConnectivityMonitor()
    ..authSessionManager = manager;
  await client.auth.initialize();

  const googleClientId = String.fromEnvironment("GOOGLE_CLIENT_ID", defaultValue: "734034762250-oqf9beii56jafh9foolv2u34bc08sdts.apps.googleusercontent.com");
  if (googleClientId.isNotEmpty) {
    try {
      if (kIsWeb) {
        await client.auth.initializeGoogleSignIn(
          clientId: googleClientId,
          redirectUri: Uri.base.resolve("auth.html").toString(),
        );
      } else {
        await client.auth.initializeGoogleSignIn(
          clientId: googleClientId,
        );
      }
    } catch (e, st) {
      debugPrint("[Auth] Note: Google Sign In pre-initialization skipped: \$e\n\$st");
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }
}
