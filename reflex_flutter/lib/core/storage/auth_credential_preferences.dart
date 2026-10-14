import 'package:shared_preferences/shared_preferences.dart';

/// Representation of saved authentication credentials when "Remember Password" is enabled.
class SavedCredentials {
  final bool remember;
  final String? email;
  final String? password;

  const SavedCredentials({
    required this.remember,
    this.email,
    this.password,
  });
}

/// Local persistence manager for caching login credentials (email & remember password preference).
class AuthCredentialPreferences {
  static const String keyRemember = 'reflex_remember_password';
  static const String keyEmail = 'reflex_saved_email';
  static const String keyPassword = 'reflex_saved_password';

  /// Retrieves saved credentials from persistent storage.
  static Future<SavedCredentials> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(keyRemember) ?? false;
    if (!remember) {
      return const SavedCredentials(remember: false);
    }
    final email = prefs.getString(keyEmail);
    final password = prefs.getString(keyPassword);
    return SavedCredentials(
      remember: true,
      email: email,
      password: password,
    );
  }

  /// Saves or clears credentials based on the [remember] flag.
  static Future<void> saveCredentials({
    required bool remember,
    String? email,
    String? password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyRemember, remember);
    if (remember) {
      if (email != null && email.isNotEmpty) {
        await prefs.setString(keyEmail, email);
      } else {
        await prefs.remove(keyEmail);
      }
      if (password != null && password.isNotEmpty) {
        await prefs.setString(keyPassword, password);
      } else {
        await prefs.remove(keyPassword);
      }
    } else {
      await prefs.remove(keyEmail);
      await prefs.remove(keyPassword);
    }
  }

  /// Clears all saved credentials.
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyRemember);
    await prefs.remove(keyEmail);
    await prefs.remove(keyPassword);
  }
}
