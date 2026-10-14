import "dart:async";
import "package:reflex_client/reflex_client.dart";
import "../../../../client.dart";

import "../../../../core/storage/role_preferences.dart";

/// Mixin providing quick-demo authentication triggers for hackathon profiles.
mixin DemoAuthMixin {
  void navigateToAppShell({required Role role, String? userName});

  void enterAsStudent() {
    unawaited(RolePreferences.saveRole(Role.student));
    unawaited(signInDemoStudent());
    navigateToAppShell(role: Role.student, userName: "Alice");
  }

  void enterAsStudentBob() {
    unawaited(RolePreferences.saveRole(Role.student));
    unawaited(signInDemoStudentBob());
    navigateToAppShell(role: Role.student, userName: "Bob");
  }

  void enterAsStudentCharlie() {
    unawaited(RolePreferences.saveRole(Role.student));
    unawaited(signInDemoStudentCharlie());
    navigateToAppShell(role: Role.student, userName: "Charlie");
  }

  void enterAsTeacher() {
    unawaited(RolePreferences.saveRole(Role.teacher));
    unawaited(signInDemoTeacher());
    navigateToAppShell(role: Role.teacher, userName: "Mr. Hassan");
  }

  void enterAsTeacherSarah() {
    unawaited(RolePreferences.saveRole(Role.teacher));
    unawaited(signInDemoTeacherSarah());
    navigateToAppShell(role: Role.teacher, userName: "Dr. Sarah");
  }
}
