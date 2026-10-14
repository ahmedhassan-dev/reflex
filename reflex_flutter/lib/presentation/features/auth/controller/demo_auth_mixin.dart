import "dart:async";
import "package:reflex_client/reflex_client.dart";
import "../../../../client.dart";

/// Mixin providing quick-demo authentication triggers for hackathon profiles.
mixin DemoAuthMixin {
  void navigateToAppShell({required Role role, String? userName});

  void enterAsStudent() {
    unawaited(signInDemoStudent());
    navigateToAppShell(role: Role.student, userName: "Alice");
  }

  void enterAsStudentBob() {
    unawaited(signInDemoStudentBob());
    navigateToAppShell(role: Role.student, userName: "Bob");
  }

  void enterAsStudentCharlie() {
    unawaited(signInDemoStudentCharlie());
    navigateToAppShell(role: Role.student, userName: "Charlie");
  }

  void enterAsTeacher() {
    unawaited(signInDemoTeacher());
    navigateToAppShell(role: Role.teacher, userName: "Mr. Hassan");
  }

  void enterAsTeacherSarah() {
    unawaited(signInDemoTeacherSarah());
    navigateToAppShell(role: Role.teacher, userName: "Dr. Sarah");
  }
}
