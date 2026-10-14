import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../generated/locale_keys.g.dart';
import '../../core/theme/app_colors.dart';
import 'app_drawer_header.dart';
import 'delete_account_dialog.dart';
import 'legal_doc_dialog.dart';

/// Responsive App Drawer for mobile layouts containing Persona info,
/// Language Switch, Legal documents, Time Machine, and Account actions.
class AppDrawerWidget extends StatelessWidget {
  final Role currentRole;
  final String? userName;
  final String? userImageUrl;
  final bool showTimeMachine;
  final ValueChanged<bool> onToggleTimeMachine;
  final VoidCallback onSignOut;
  final Future<void> Function() onDeleteAccount;

  const AppDrawerWidget({
    super.key,
    required this.currentRole,
    this.userName,
    this.userImageUrl,
    required this.showTimeMachine,
    required this.onToggleTimeMachine,
    required this.onSignOut,
    required this.onDeleteAccount,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppDrawerHeader(
              currentRole: currentRole,
              userName: userName,
              userImageUrl: userImageUrl,
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 4),
                children: [
                  _buildLanguageTile(context),
                  _buildPrivacyPolicyTile(context),
                  _buildTermsTile(context),
                  _buildTimeMachineTile(context),
                  const Divider(),
                  _buildDeleteAccountTile(context),
                  _buildSignOutTile(context),
                ],
              ),
            ),
            const Divider(height: 1),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    final theme = Theme.of(context);
    return ListTile(
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
    );
  }

  Widget _buildPrivacyPolicyTile(BuildContext context) {
    return ListTile(
      key: const Key('btn_drawer_privacy_policy'),
      leading: const Icon(Icons.privacy_tip_outlined),
      title: Text(LocaleKeys.drawer_privacy_policy.tr()),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () {
        Navigator.of(context).pop();
        LegalDocDialog.show(context, LegalDocType.privacyPolicy);
      },
    );
  }

  Widget _buildTermsTile(BuildContext context) {
    return ListTile(
      key: const Key('btn_drawer_terms_of_service'),
      leading: const Icon(Icons.description_outlined),
      title: Text(LocaleKeys.drawer_terms_of_service.tr()),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20),
      onTap: () {
        Navigator.of(context).pop();
        LegalDocDialog.show(context, LegalDocType.termsOfService);
      },
    );
  }

  Widget _buildTimeMachineTile(BuildContext context) {
    return ListTile(
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
    );
  }

  Widget _buildDeleteAccountTile(BuildContext context) {
    return ListTile(
      key: const Key('btn_drawer_delete_account'),
      leading: const Icon(Icons.delete_forever_rounded, color: Colors.redAccent),
      title: Text(
        LocaleKeys.drawer_delete_account.tr(),
        style: const TextStyle(
          color: Colors.redAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () async {
        final navigator = Navigator.of(context);
        final messenger = ScaffoldMessenger.of(context);
        navigator.pop();
        final deleted = await DeleteAccountDialog.show(
          navigator.context,
          onConfirm: onDeleteAccount,
        );
        if (deleted == true) {
          messenger.showSnackBar(
            SnackBar(
              content: Text(LocaleKeys.drawer_delete_account_success.tr()),
              backgroundColor: Colors.green,
            ),
          );
          onSignOut();
        }
      },
    );
  }

  Widget _buildSignOutTile(BuildContext context) {
    return ListTile(
      key: const Key('btn_drawer_sign_out'),
      leading: const Icon(Icons.logout_rounded, color: Colors.orangeAccent),
      title: Text(
        LocaleKeys.sign_out.tr(),
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontWeight: FontWeight.w600,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        onSignOut();
      },
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 8,
            runSpacing: 4,
            children: [
              Text(
                LocaleKeys.drawer_app_version.tr(),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.4)),
                ),
                child: Text(
                  LocaleKeys.drawer_production_ready.tr(),
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 3),
          Text(
            LocaleKeys.drawer_copyright.tr(),
            style: TextStyle(
              fontSize: 10,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}
