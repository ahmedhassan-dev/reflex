import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reflex_flutter/core/storage/auth_credential_preferences.dart';
import 'package:reflex_flutter/generated/locale_keys.g.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  group('AuthCredentialPreferences unit tests', () {
    test('default state returns remember: false and null credentials', () async {
      final creds = await AuthCredentialPreferences.getSavedCredentials();
      expect(creds.remember, isFalse);
      expect(creds.email, isNull);
      expect(creds.password, isNull);
    });

    test('saves credentials when remember is true', () async {
      await AuthCredentialPreferences.saveCredentials(
        remember: true,
        email: 'student@example.com',
        password: 'password123',
      );

      final creds = await AuthCredentialPreferences.getSavedCredentials();
      expect(creds.remember, isTrue);
      expect(creds.email, equals('student@example.com'));
      expect(creds.password, equals('password123'));
    });

    test('removes email and password when remember is false', () async {
      await AuthCredentialPreferences.saveCredentials(
        remember: true,
        email: 'student@example.com',
        password: 'password123',
      );

      await AuthCredentialPreferences.saveCredentials(
        remember: false,
      );

      final creds = await AuthCredentialPreferences.getSavedCredentials();
      expect(creds.remember, isFalse);
      expect(creds.email, isNull);
      expect(creds.password, isNull);
    });

    test('clear removes all keys from shared preferences', () async {
      await AuthCredentialPreferences.saveCredentials(
        remember: true,
        email: 'student@example.com',
        password: 'password123',
      );

      await AuthCredentialPreferences.clear();

      final creds = await AuthCredentialPreferences.getSavedCredentials();
      expect(creds.remember, isFalse);
      expect(creds.email, isNull);
      expect(creds.password, isNull);
    });

    test('LocaleKeys defines auth_remember_password correctly', () {
      expect(LocaleKeys.auth_remember_password, equals('auth.remember_password'));
    });
  });
}
