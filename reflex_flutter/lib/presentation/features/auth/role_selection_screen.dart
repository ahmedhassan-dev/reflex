import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';

import '../../../core/storage/role_preferences.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/reflex_logo.dart';
import 'auth_screen.dart';
import 'widgets/role_card.dart';

/// Dedicated screen for choosing user type / persona (Student vs Teacher)
/// with chromatic feedback and local persistence.
class RoleSelectionScreen extends StatefulWidget {
  final Role? initialRole;

  const RoleSelectionScreen({
    super.key,
    this.initialRole,
  });

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  late Role _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole ?? Role.student;
  }

  void _selectRole(Role role) {
    if (_selectedRole != role) {
      setState(() {
        _selectedRole = role;
      });
    }
  }

  Future<void> _continueToAuth() async {
    // 1. Persist the chosen role locally
    await RolePreferences.saveRole(_selectedRole);

    // 2. Navigate to the Auth Screen configured for this role
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => AuthScreen(initialRole: _selectedRole),
        ),
      );
    }
  }

  void _toggleLanguage(BuildContext context) {
    if (context.locale.languageCode == 'en') {
      context.setLocale(const Locale('ar'));
    } else {
      context.setLocale(const Locale('en'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final roleColor = _selectedRole == Role.student
        ? ReflexColors.primary
        : ReflexColors.accent;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const ReflexLogo(size: 28, borderRadius: 8),
            const SizedBox(width: 10),
            Text(
              LocaleKeys.app_title.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.language_rounded),
            tooltip: LocaleKeys.switch_language.tr(),
            onPressed: () => _toggleLanguage(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 540),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Hero Icon & Chromatic Aura
                  Center(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            roleColor.withValues(alpha: 0.28),
                            roleColor.withValues(alpha: 0.08),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: roleColor.withValues(alpha: 0.25),
                            blurRadius: 28,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Icon(
                        _selectedRole == Role.student
                            ? Icons.school_rounded
                            : Icons.co_present_rounded,
                        size: 46,
                        color: roleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    LocaleKeys.auth_welcome_title.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    LocaleKeys.auth_welcome_subtitle.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark
                          ? ReflexColors.textSecondaryDark
                          : ReflexColors.textSecondaryLight,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // Prompt
                  Text(
                    LocaleKeys.auth_choose_role_prompt.tr(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Student Role Card
                  RoleCard(
                    role: Role.student,
                    title: LocaleKeys.auth_role_student.tr(),
                    description: LocaleKeys.auth_role_student_desc.tr(),
                    icon: Icons.school_rounded,
                    isSelected: _selectedRole == Role.student,
                    accentColor: ReflexColors.primary,
                    onTap: () => _selectRole(Role.student),
                  ),
                  const SizedBox(height: 12),

                  // Teacher Role Card
                  RoleCard(
                    role: Role.teacher,
                    title: LocaleKeys.auth_role_teacher.tr(),
                    description: LocaleKeys.auth_role_teacher_desc.tr(),
                    icon: Icons.co_present_rounded,
                    isSelected: _selectedRole == Role.teacher,
                    accentColor: ReflexColors.accent,
                    onTap: () => _selectRole(Role.teacher),
                  ),
                  const SizedBox(height: 28),

                  // Prominent Chromatic Continue Button
                  SizedBox(
                    height: 52,
                    child: ElevatedButton.icon(
                      key: const Key('btn_role_continue'),
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(
                        _selectedRole == Role.student
                            ? LocaleKeys.auth_continue_as_student.tr()
                            : LocaleKeys.auth_continue_as_teacher.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: roleColor,
                        foregroundColor: Colors.white,
                        elevation: 3,
                        shadowColor: roleColor.withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onPressed: _continueToAuth,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
