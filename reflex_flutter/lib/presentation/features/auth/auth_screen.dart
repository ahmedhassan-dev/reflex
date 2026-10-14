import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/reflex_logo.dart';
import '../../../generated/locale_keys.g.dart';
import 'controller/auth_controller.dart';
import 'controller/auth_view_mode.dart';
import 'widgets/auth_header_widget.dart';
import 'widgets/auth_persona_banner_widget.dart';
import 'widgets/forgot_password_widget.dart';
import 'widgets/otp_verification_widget.dart';
import 'widgets/quick_demo_section_widget.dart';
import 'widgets/sign_in_form_widget.dart';
import 'widgets/sign_up_form_widget.dart';

/// Authentication Screen with Persona Banner, Email Sign In/Sign Up,
/// OTP Verification, Forgot Password, Google & Apple OAuth, and Quick Demo profiles.
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
            key: const Key('btn_switch_role_appbar'),
            icon: const Icon(Icons.switch_account_outlined),
            tooltip: LocaleKeys.auth_switch_role.tr(),
            onPressed: switchToRoleSelection,
          ),
          IconButton(
            icon: const Icon(Icons.language_rounded),
            tooltip: LocaleKeys.switch_language.tr(),
            onPressed: toggleLanguage,
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
                  AuthHeaderWidget(
                    selectedRole: selectedRole,
                    roleColor: roleColor,
                  ),
                  const SizedBox(height: 20),
                  AuthPersonaBannerWidget(
                    selectedRole: selectedRole,
                    roleColor: roleColor,
                    onSwitchRole: switchToRoleSelection,
                  ),
                  const SizedBox(height: 16),
                  if (errorMessage != null) ...[
                    Container(
                      key: const Key('auth_error_banner'),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.4),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            color: Theme.of(context).colorScheme.error,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  errorMessage!,
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.onErrorContainer,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (errorMessage == LocaleKeys.auth_email_already_registered.tr() &&
                                    tabController.index == 1) ...[
                                  const SizedBox(height: 4),
                                  InkWell(
                                    key: const Key('btn_switch_to_signin_from_error'),
                                    onTap: () {
                                      setState(() {
                                        errorMessage = null;
                                        tabController.animateTo(0);
                                      });
                                    },
                                    child: Text(
                                      '${LocaleKeys.sign_in.tr()} →',
                                      style: TextStyle(
                                        color: roleColor,
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close_rounded, size: 16),
                            color: Theme.of(context).colorScheme.onErrorContainer,
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () => setState(() => errorMessage = null),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (authViewMode == AuthViewMode.otpVerification) ...[
                    OtpVerificationWidget(
                      email: emailController.text.trim(),
                      otpController: otpController,
                      roleColor: roleColor,
                      isLoading: isLoading,
                      onVerify: verifyOtpAndCompleteRegistration,
                      onResend: resendRegistrationOtp,
                      onBack: cancelSubView,
                    ),
                  ] else if (authViewMode == AuthViewMode.forgotPassword) ...[
                    ForgotPasswordWidget(
                      emailController: emailController,
                      otpController: otpController,
                      newPasswordController: newPasswordController,
                      confirmPasswordController: confirmPasswordController,
                      roleColor: roleColor,
                      isCodeSent: isResetCodeSent,
                      isLoading: isLoading,
                      onSendResetCode: sendPasswordResetCode,
                      onSubmitPasswordReset: verifyResetOtpAndSetPassword,
                      onResendResetCode: resendPasswordResetOtp,
                      onBack: cancelSubView,
                    ),
                  ] else ...[
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
                              isLoading: isLoading,
                              onSignIn: signInWithEmail,
                              onForgotPassword: openForgotPassword,
                              onGoogleSignIn: signInWithGoogle,
                              onAppleSignIn: signInWithApple,
                            ),
                            SignUpFormWidget(
                              nameController: nameController,
                              emailController: emailController,
                              passwordController: passwordController,
                              selectedRole: selectedRole,
                              roleColor: roleColor,
                              isLoading: isLoading,
                              onSignUp: signUpWithEmail,
                              onGoogleSignIn: signInWithGoogle,
                              onAppleSignIn: signInWithApple,
                            ),
                            QuickDemoSectionWidget(
                              onEnterAsStudent: enterAsStudent,
                              onEnterAsStudentBob: enterAsStudentBob,
                              onEnterAsStudentCharlie: enterAsStudentCharlie,
                              onEnterAsTeacher: enterAsTeacher,
                              onEnterAsTeacherSarah: enterAsTeacherSarah,
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
