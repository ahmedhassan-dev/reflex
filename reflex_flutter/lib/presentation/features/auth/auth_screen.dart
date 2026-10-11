import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../core/theme/app_colors.dart';
import '../../../generated/locale_keys.g.dart';
import 'controller/auth_controller.dart';
import 'widgets/auth_persona_banner_widget.dart';
import 'widgets/quick_demo_section_widget.dart';
import 'widgets/sign_in_form_widget.dart';
import 'widgets/sign_up_form_widget.dart';

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
                  AuthPersonaBannerWidget(
                    selectedRole: selectedRole,
                    roleColor: roleColor,
                    onSwitchRole: () => switchToRoleSelection(context),
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
                          SignInFormWidget(
                            emailController: emailController,
                            passwordController: passwordController,
                            selectedRole: selectedRole,
                            roleColor: roleColor,
                            onSignIn: () => signInWithEmail(context),
                            onGoogleSignIn: () => signInWithGoogle(context),
                            onAppleSignIn: () => signInWithApple(context),
                          ),
                          SignUpFormWidget(
                            nameController: nameController,
                            emailController: emailController,
                            passwordController: passwordController,
                            selectedRole: selectedRole,
                            roleColor: roleColor,
                            onSignUp: () => signUpWithEmail(context),
                            onGoogleSignIn: () => signInWithGoogle(context),
                            onAppleSignIn: () => signInWithApple(context),
                          ),
                          QuickDemoSectionWidget(
                            onEnterAsStudent: () => enterAsStudent(context),
                            onEnterAsTeacher: () => enterAsTeacher(context),
                          ),
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
}
