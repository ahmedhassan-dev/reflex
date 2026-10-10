import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'client.dart';
import 'generated/codegen_loader.g.dart';
import 'generated/locale_keys.g.dart';
import 'presentation/core/theme/app_theme.dart';
import 'presentation/features/auth/auth_screen.dart';

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

      runApp(
        EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar')],
          path: 'assets/translations',
          fallbackLocale: const Locale('en'),
          assetLoader: const CodegenLoader(),
          child: const ReflexApp(),
        ),
      );
    },
  );
}

class ReflexApp extends StatelessWidget {
  const ReflexApp({super.key});

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
      home: const AuthScreen(),
    );
  }
}
