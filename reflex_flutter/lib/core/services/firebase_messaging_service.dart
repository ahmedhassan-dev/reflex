import 'dart:async';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../client.dart';

/// Top-level background message handler for FCM.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('[FirebaseMessaging] Background message received: ${message.messageId}');
}

/// Service managing Firebase Cloud Messaging (FCM), push permissions,
/// device token registration, topic subscriptions, and server synchronization.
class FirebaseMessagingService {
  FirebaseMessagingService._();
  static final FirebaseMessagingService instance = FirebaseMessagingService._();

  static const String prefKeyFcmToken = 'fcm_device_token';

  String? _fcmToken;

  /// Active FCM token for the device.
  String? get token => _fcmToken;
  static String? get fcmToken => instance.token;

  /// Whether current platform supports push notifications via FCM.
  static bool get isPlatformSupported {
    if (kIsWeb) return true;
    try {
      if (Platform.isAndroid || Platform.isIOS) return true;
    } catch (_) {
      return false;
    }
    return false;
  }

  /// Initializes FCM listeners, permissions, tokens, and topic subscriptions.
  Future<void> initialize() async {
    if (!isPlatformSupported) return;

    try {
      await requestPermissions();
      _setupMessageHandlers();
      await _retrieveAndCacheToken();
      await _setupTopicSubscriptions();
      await syncFcmTokenWithServer();
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Initialization error: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }

  static Future<void> init() => instance.initialize();

  /// Requests notification permissions from the OS.
  Future<NotificationSettings?> requestPermissions() async {
    if (!isPlatformSupported) return null;
    try {
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: true,
        sound: true,
      );
      return settings;
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Permission request failed: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
      return null;
    }
  }

  void _setupMessageHandlers() {
    try {
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('[FirebaseMessaging] Foreground message: ${message.notification?.title}');
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        debugPrint('[FirebaseMessaging] Message opened app: ${message.data}');
      });

      unawaited(
        FirebaseMessaging.instance.getInitialMessage().then((initial) {
          if (initial != null) {
            debugPrint('[FirebaseMessaging] Initial notification message: ${initial.data}');
          }
        }),
      );

      FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        unawaited(_persistTokenLocally(newToken));
        unawaited(syncFcmTokenWithServer());
      });
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Message handler setup error: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }

  Future<void> _retrieveAndCacheToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _fcmToken = prefs.getString(prefKeyFcmToken);

      final freshToken = await FirebaseMessaging.instance.getToken();
      if (freshToken != null && freshToken.isNotEmpty) {
        _fcmToken = freshToken;
        await _persistTokenLocally(freshToken);
      }
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Failed to retrieve FCM token: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }

  Future<void> _persistTokenLocally(String token) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(prefKeyFcmToken, token);
    } catch (e) {
      debugPrint('[FirebaseMessaging] Local token storage error: $e');
    }
  }

  Future<void> _setupTopicSubscriptions() async {
    try {
      await subscribe('users');
      if (!kIsWeb) {
        if (Platform.isAndroid) await subscribe('android');
        if (Platform.isIOS) await subscribe('ios');
      }
    } catch (e) {
      debugPrint('[FirebaseMessaging] Topic subscription skipped or failed: $e');
    }
  }

  /// Subscribes to a broadcast topic.
  Future<void> subscribe(String topic) async {
    if (!isPlatformSupported) return;
    try {
      await FirebaseMessaging.instance.subscribeToTopic(topic);
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Failed to subscribe to $topic: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }

  /// Unsubscribes from a broadcast topic.
  Future<void> unsubscribe(String topic) async {
    if (!isPlatformSupported) return;
    try {
      await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
    } catch (_) {}
  }

  /// Synchronizes the cached or live FCM device token with the backend user profile.
  Future<void> syncFcmTokenWithServer() async {
    if (!isUserAuthenticated || isDemoUserActive) return;

    final tokenToSend = _fcmToken;
    if (tokenToSend == null || tokenToSend.isEmpty) return;

    try {
      await client.userProfile.updateFcmToken(fcmToken: tokenToSend);
      debugPrint('[FirebaseMessaging] FCM token synced with user profile on server.');
    } catch (e, st) {
      debugPrint('[FirebaseMessaging] Failed to sync FCM token with server: $e');
      unawaited(Sentry.captureException(e, stackTrace: st));
    }
  }

  static Future<void> syncWithServer() => instance.syncFcmTokenWithServer();
}
