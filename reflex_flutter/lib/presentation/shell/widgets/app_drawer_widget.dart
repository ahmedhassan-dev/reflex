import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';

/// Responsive App Drawer for mobile layouts containing Persona info,
/// Language Switch, Demo Clock toggle, and Sign Out.
class AppDrawerWidget extends StatelessWidget {
  final Role currentRole;
  final String? userName;
  final String? userImageUrl;
  final bool showTimeMachine;
  final ValueChanged<bool> onToggleTimeMachine;
  final VoidCallback onSignOut;

  const AppDrawerWidget({
    super.key,
    required this.currentRole,
    this.userName,
    this.userImageUrl,
    required this.showTimeMachine,
    required this.onToggleTimeMachine,
    required this.onSignOut,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isStudent = currentRole == Role.student;
    final roleColor = isStudent ? ReflexColors.primary : ReflexColors.accent;
    final roleBadgeText = isStudent
        ? LocaleKeys.auth_role_student_badge.tr()
        : LocaleKeys.auth_role_teacher_badge.tr();

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Drawer Brand & Persona Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    roleColor.withValues(alpha: 0.18),
                    ReflexColors.accent.withValues(alpha: 0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ReflexColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.flash_on_rounded,
                          color: ReflexColors.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        LocaleKeys.app_title.tr(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: roleColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: roleColor.withValues(alpha: 0.5)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (userImageUrl != null && userImageUrl!.isNotEmpty) ...[
                          CircleAvatar(
                            radius: 10,
                            backgroundImage: NetworkImage(userImageUrl!),
                            onBackgroundImageError: (error, stackTrace) {},
                          ),
                          const SizedBox(width: 6),
                        ] else ...[
                          Icon(
                            isStudent ? Icons.school_rounded : Icons.co_present_rounded,
                            size: 14,
                            color: roleColor,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          userName != null
                              ? '$userName ($roleBadgeText)'
                              : roleBadgeText,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: roleColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // Language Toggle Tile
            ListTile(
              key: const Key('btn_drawer_switch_language'),
              leading: const Icon(Icons.language_rounded),
              title: Text(LocaleKeys.switch_language.tr()),
              subtitle: Text(
                context.locale.languageCode == 'en' ? 'English (EN)' : 'العربية (AR)',
                style: TextStyle(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
              onTap: () {
                if (context.locale.languageCode == 'en') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
                Navigator.of(context).pop();
              },
            ),

            // Time Machine (Demo Clock) Toggle Tile
            ListTile(
              leading: Icon(
                Icons.access_time_filled_rounded,
                color: showTimeMachine ? ReflexColors.accent : null,
              ),
              title: Text(LocaleKeys.demo_clock_title.tr()),
              trailing: Switch(
                value: showTimeMachine,
                activeThumbColor: ReflexColors.accent,
                onChanged: (val) {
                  onToggleTimeMachine(val);
                  Navigator.of(context).pop();
                },
              ),
            ),

            const Spacer(),
            const Divider(),

            // Sign Out / Switch Persona Action
            ListTile(
              key: const Key('btn_drawer_sign_out'),
              leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
              title: Text(
                LocaleKeys.sign_out.tr(),
                style: const TextStyle(
                  color: Colors.redAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                onSignOut();
              },
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
