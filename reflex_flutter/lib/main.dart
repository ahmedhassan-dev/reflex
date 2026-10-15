import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'package:firebase_core/firebase_core.dart';
import 'client.dart';
import 'core/services/firebase_messaging_service.dart';
import 'core/storage/role_preferences.dart';
import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';
import 'generated/locale_keys.g.dart';
import 'package:reflex_client/reflex_client.dart';
import 'presentation/core/theme/app_theme.dart';
import 'presentation/features/auth/auth_screen.dart';
import 'presentation/features/auth/role_selection_screen.dart';
import 'presentation/shell/app_shell.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment(
        'SENTRY_DSN',
        defaultValue: '',
      );
      options.tracesSampleRate = 1.0;
      options.beforeSend = (event, hint) {
        return event;
      };
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );
        await FirebaseMessagingService.init();
      } catch (e) {
        debugPrint('[Firebase] Init skipped or failed: $e');
      }
      await initializeClient();
      final savedRole = await RolePreferences.getSavedRole();

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: ReflexApp(initialRole: savedRole),
        ),
      );
    },
  );
}

class ReflexApp extends StatelessWidget {
  final Role? initialRole;

  const ReflexApp({super.key, this.initialRole});

  @override
  Widget build(BuildContext context) {
    final effectiveRole = initialRole ?? Role.student;
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      debugShowCheckedModeBanner: false,
      locale: context.locale,
      title: LocaleKeys.app_title.tr(),
      theme: ReflexTheme.light,
      darkTheme: ReflexTheme.dark,
      themeMode: ThemeMode.system,
      home: isUserAuthenticated
          ? AppShell(initialRole: effectiveRole)
          : (initialRole != null
                ? AuthScreen(initialRole: initialRole)
                : const RoleSelectionScreen()),
    );
  }
}
