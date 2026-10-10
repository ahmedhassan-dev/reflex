import 'dart:io';

/// Lightweight zero-dependency .env loader and passwords.yaml synchronizer.
abstract final class EnvLoader {
  /// Loads key-value pairs from .env into memory and ensures passwords.yaml is present.
  static Map<String, String> load({Directory? baseDir}) {
    final envFile = _findEnvFile(baseDir);
    if (envFile == null || !envFile.existsSync()) {
      return const {};
    }

    final envMap = <String, String>{};
    final lines = envFile.readAsLinesSync();

    for (var line in lines) {
      line = line.trim();
      if (line.isEmpty || line.startsWith('#')) continue;

      final eqIdx = line.indexOf('=');
      if (eqIdx == -1) continue;

      final key = line.substring(0, eqIdx).trim();
      var val = line.substring(eqIdx + 1).trim();

      // Strip enclosing single or double quotes
      if ((val.startsWith('"') && val.endsWith('"')) ||
          (val.startsWith("'") && val.endsWith("'"))) {
        if (val.length >= 2) {
          val = val.substring(1, val.length - 1);
        }
      }

      envMap[key] = val;
    }

    // Ensure local config/passwords.yaml exists from .env if missing
    _ensurePasswordsYaml(envMap, baseDir);

    return envMap;
  }

  static File? _findEnvFile(Directory? baseDir) {
    final startDir = baseDir ?? Directory.current;
    final searchDirs = [
      startDir,
      startDir.parent,
      Directory('${startDir.path}/..'),
      Directory.current,
      Directory.current.parent,
    ];

    for (final dir in searchDirs) {
      final f = File('${dir.path}/.env');
      if (f.existsSync()) return f;
    }
    return null;
  }

  static void _ensurePasswordsYaml(Map<String, String> envMap, Directory? baseDir) {
    final startDir = baseDir ?? Directory.current;
    final serverDir = startDir.path.endsWith('reflex_server')
        ? startDir
        : (Directory('${startDir.path}/reflex_server').existsSync()
            ? Directory('${startDir.path}/reflex_server')
            : startDir);

    final configFile = File('${serverDir.path}/config/passwords.yaml');

    if (!configFile.existsSync()) {
      final dbPass = envMap['SERVERPOD_DATABASE_PASSWORD'] ?? 'YPMVf_v_oijIRvvFDpat6nFOF3tcQ0iw';
      final redisPass = envMap['SERVERPOD_REDIS_PASSWORD'] ?? 'WPhLDMQn35YFhtk9UlQcU0lHYuAry-9O';
      final serviceSecret = envMap['SERVERPOD_SERVICE_SECRET'] ?? 'YVs7P9kZjtXq06zYML1YddFYh4rgFuXH';
      final jwtKey = envMap['SERVERPOD_PASSWORD_jwtHmacSha512PrivateKey'] ?? 'WpqbxPhDheuj40rF9fLDn4ku7LeYKxPM';
      final jwtPepper = envMap['SERVERPOD_PASSWORD_jwtRefreshTokenHashPepper'] ?? 'esZiz5pkTJ36DQnnZwFxSwFsgvPPbB1w';
      final emailPepper = envMap['SERVERPOD_PASSWORD_emailSecretHashPepper'] ?? 'aXFE1IhVh5GlkXKvOLSnK7gq3WJr8Vx7';
      final googleSecret = envMap['SERVERPOD_PASSWORD_googleClientSecret'] ??
          '{"web":{"client_id":"reflex-google-oauth-client.apps.googleusercontent.com","client_secret":"reflex-google-oauth-secret-key","redirect_uris":["http://localhost:8082/auth/google/callback"]}}';

      final yaml = """# Auto-generated from .env by EnvLoader
shared:
  googleClientSecret: |
    $googleSecret

development:
  database: '$dbPass'
  redis: '$redisPass'
  serviceSecret: '$serviceSecret'
  emailSecretHashPepper: '$emailPepper'
  jwtHmacSha512PrivateKey: '$jwtKey'
  jwtRefreshTokenHashPepper: '$jwtPepper'

test:
  database: 'o9MPLOXZVMPbKn0JUtTu4ZbKc1Aa27Vv'
  redis: '9pPrFUu0vkA9-8NGGAl5B9YFW2fOjxVH'
  serviceSecret: '$serviceSecret'
  emailSecretHashPepper: '$emailPepper'
  jwtHmacSha512PrivateKey: '$jwtKey'
  jwtRefreshTokenHashPepper: '$jwtPepper'
""";
      configFile.parent.createSync(recursive: true);
      configFile.writeAsStringSync(yaml);
    }
  }
}
