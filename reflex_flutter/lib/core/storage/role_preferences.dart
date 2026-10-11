import 'package:reflex_client/reflex_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Local persistence manager for user role selection (Student vs Teacher).
class RolePreferences {
  static const String keyRole = 'reflex_saved_user_role';

  /// Retrieves the persisted role, or null if no role has been chosen yet.
  static Future<Role?> getSavedRole() async {
    final prefs = await SharedPreferences.getInstance();
    final roleString = prefs.getString(keyRole);
    if (roleString == Role.student.name) {
      return Role.student;
    } else if (roleString == Role.teacher.name) {
      return Role.teacher;
    }
    return null;
  }

  /// Persists the selected role locally.
  static Future<void> saveRole(Role role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyRole, role.name);
  }

  /// Clears the stored role (e.g. on full sign-out or persona switch).
  static Future<void> clearRole() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(keyRole);
  }
}
