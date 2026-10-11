import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../core/theme/app_colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'controller/auth_controller.dart';

/// Authentication Screen with Persona Banner, Email Sign In/Sign Up,
/// Google & Apple OAuth sign-in integration, and Quick Demo profiles.
class AuthScreen extends StatefulWidget {
  final Role? initialRole;

  const AuthScreen({
    super.key,
    this.initialRole,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends AuthController {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final roleColor = selectedRole == Role.student ? ReflexColors.primary : ReflexColors.accent;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: ReflexColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.flash_on_rounded,
                color: ReflexColors.primary,
                size: 20,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              LocaleKeys.app_title.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          IconButton(
            key: const Key('btn_switch_role_appbar'),
            icon: const Icon(Icons.switch_account_outlined),
            tooltip: LocaleKeys.auth_switch_role.tr(),
            onPressed: () => switchToRoleSelection(context),
          ),
          IconButton(
            icon: const Icon(Icons.language_rounded),
            tooltip: LocaleKeys.switch_language.tr(),
            onPressed: () => toggleLanguage(context),
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
                  // Hero Icon & Branding
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            roleColor.withValues(alpha: 0.25),
                            ReflexColors.accent.withValues(alpha: 0.15),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: roleColor.withValues(alpha: 0.25),
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        selectedRole == Role.student
                            ? Icons.school_rounded
                            : Icons.co_present_rounded,
                        size: 40,
                        color: roleColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
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
                  const SizedBox(height: 20),

                  // Active Persona Banner with Switch Role Action
                  Container(
                    key: const Key('persona_banner'),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: isDark ? 0.15 : 0.08),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: roleColor.withValues(alpha: 0.35),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: roleColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            selectedRole == Role.student
                                ? Icons.school_rounded
                                : Icons.co_present_rounded,
                            color: roleColor,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedRole == Role.student
                                    ? LocaleKeys.auth_role_student.tr()
                                    : LocaleKeys.auth_role_teacher.tr(),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: roleColor,
                                ),
                              ),
                              Text(
                                selectedRole == Role.student
                                    ? LocaleKeys.auth_role_student_desc.tr()
                                    : LocaleKeys.auth_role_teacher_desc.tr(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? ReflexColors.textSecondaryDark
                                      : ReflexColors.textSecondaryLight,
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton.icon(
                          key: const Key('btn_change_role'),
                          icon: const Icon(Icons.swap_horiz_rounded, size: 18),
                          label: Text(
                            LocaleKeys.auth_switch_role.tr(),
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          style: TextButton.styleFrom(
                            foregroundColor: roleColor,
                          ),
                          onPressed: () => switchToRoleSelection(context),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Authentication Tabs (Sign In, Sign Up, Quick Demo)
                  Container(
                    decoration: BoxDecoration(
                      color: isDark ? ReflexColors.darkSurface : ReflexColors.lightCard,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TabBar(
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: roleColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      labelColor: Colors.white,
                      unselectedLabelColor: isDark
                          ? ReflexColors.textSecondaryDark
                          : ReflexColors.textSecondaryLight,
                      tabs: [
                        Tab(
                          icon: const Icon(Icons.login_rounded, size: 18),
                          text: LocaleKeys.auth_tab_signin.tr(),
                        ),
                        Tab(
                          icon: const Icon(Icons.person_add_rounded, size: 18),
                          text: LocaleKeys.auth_tab_signup.tr(),
                        ),
                        Tab(
                          icon: const Icon(Icons.bolt_rounded, size: 18),
                          text: LocaleKeys.auth_tab_demo.tr(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  // Tab Views
                  AnimatedBuilder(
                    animation: tabController,
                    builder: (context, _) {
                      return IndexedStack(
                        index: tabController.index,
                        children: [
                          _buildSignInForm(context, roleColor),
                          _buildSignUpForm(context, roleColor),
                          _buildQuickDemoSection(context, isDark),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignInForm(BuildContext context, Color roleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const Key('input_signin_email'),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_email_label.tr(),
            hintText: LocaleKeys.auth_email_hint.tr(),
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('input_signin_password'),
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_password_label.tr(),
            hintText: LocaleKeys.auth_password_hint.tr(),
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            key: const Key('btn_submit_signin'),
            icon: const Icon(Icons.login_rounded),
            label: Text(
              selectedRole == Role.student
                  ? LocaleKeys.auth_continue_as_student.tr()
                  : LocaleKeys.auth_continue_as_teacher.tr(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: roleColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => signInWithEmail(context),
          ),
        ),
        const SizedBox(height: 16),
        _buildOAuthButtons(context),
      ],
    );
  }

  Widget _buildSignUpForm(BuildContext context, Color roleColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          key: const Key('input_signup_name'),
          controller: nameController,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_name_label.tr(),
            hintText: LocaleKeys.auth_name_hint.tr(),
            prefixIcon: const Icon(Icons.badge_outlined, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('input_signup_email'),
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_email_label.tr(),
            hintText: LocaleKeys.auth_email_hint.tr(),
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          key: const Key('input_signup_password'),
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
            labelText: LocaleKeys.auth_password_label.tr(),
            hintText: LocaleKeys.auth_password_hint.tr(),
            prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20),
          ),
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            key: const Key('btn_submit_signup'),
            icon: const Icon(Icons.check_circle_outline_rounded),
            label: Text(
              '${LocaleKeys.auth_create_account.tr()} (${selectedRole == Role.student ? LocaleKeys.auth_role_student.tr() : LocaleKeys.auth_role_teacher.tr()})',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: roleColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => signUpWithEmail(context),
          ),
        ),
        const SizedBox(height: 16),
        _buildOAuthButtons(context),
      ],
    );
  }

  Widget _buildOAuthButtons(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                LocaleKeys.auth_or_divider.tr(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: isDark ? ReflexColors.textMutedDark : ReflexColors.textMutedLight,
                ),
              ),
            ),
            const Expanded(child: Divider()),
          ],
        ),
        const SizedBox(height: 14),
        // Google Sign-In Button
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            key: const Key('btn_google_signin'),
            icon: const Icon(Icons.g_mobiledata_rounded, size: 28, color: Colors.redAccent),
            label: Text(
              LocaleKeys.auth_sign_in_with_google.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => signInWithGoogle(context),
          ),
        ),
        const SizedBox(height: 10),
        // Apple Sign-In Button
        SizedBox(
          width: double.infinity,
          height: 46,
          child: OutlinedButton.icon(
            key: const Key('btn_apple_signin'),
            icon: const Icon(Icons.apple_rounded, size: 22),
            label: Text(
              LocaleKeys.auth_sign_in_with_apple.tr(),
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onPressed: () => signInWithApple(context),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickDemoSection(BuildContext context, bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          LocaleKeys.auth_demo_hint.tr(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? ReflexColors.textSecondaryDark : ReflexColors.textSecondaryLight,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                key: const Key('btn_quick_student'),
                icon: const Icon(Icons.school_outlined, size: 18),
                label: Text(
                  LocaleKeys.auth_demo_student_alice.tr(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ReflexColors.primary, width: 1.5),
                  foregroundColor: ReflexColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => enterAsStudent(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                key: const Key('btn_quick_teacher'),
                icon: const Icon(Icons.co_present_outlined, size: 18),
                label: Text(
                  LocaleKeys.auth_demo_teacher_hassan.tr(),
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: ReflexColors.accent, width: 1.5),
                  foregroundColor: ReflexColors.accent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () => enterAsTeacher(context),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
