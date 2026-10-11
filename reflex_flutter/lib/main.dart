import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'client.dart';
import 'core/storage/role_preferences.dart';
import 'generated/codegen_loader.g.dart';
import 'generated/locale_keys.g.dart';
import 'package:reflex_client/reflex_client.dart';
import 'presentation/core/theme/app_theme.dart';
import 'presentation/features/auth/auth_screen.dart';
import 'presentation/features/auth/role_selection_screen.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = const String.fromEnvironment('SENTRY_DSN', defaultValue: '');
      options.tracesSampleRate = 1.0;
      options.beforeSend = (event, hint) {
        return event;
      };
    },
    appRunner: () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
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
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: LocaleKeys.app_title.tr(),
      theme: ReflexTheme.light,
      darkTheme: ReflexTheme.dark,
      themeMode: ThemeMode.system,
      home: initialRole != null
          ? AuthScreen(initialRole: initialRole)
          : const RoleSelectionScreen(),
    );
  }
}
