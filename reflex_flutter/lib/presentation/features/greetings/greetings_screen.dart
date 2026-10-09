import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../generated/locale_keys.g.dart';
import 'controller/greetings_controller.dart';

/// Greetings Screen shell.
///
/// Contains only widget building code. All business logic, state variables,
/// and action handlers reside in [GreetingsController].
class GreetingsScreen extends StatefulWidget {
  final Future<void> Function()? onSignOut;
  const GreetingsScreen({super.key, this.onSignOut});

  @override
  State<GreetingsScreen> createState() => _GreetingsScreenState();
}

class _GreetingsScreenState extends GreetingsController {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          if (widget.onSignOut != null) ...[
            Text(LocaleKeys.connected.tr()),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: widget.onSignOut,
              child: Text(LocaleKeys.sign_out.tr()),
            ),
          ],
          const SizedBox(height: 32),
          TextField(
            controller: nameController,
            onSubmitted: (_) => callHello(),
            decoration: InputDecoration(
              hintText: LocaleKeys.enter_name.tr(),
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: isLoading ? null : callHello,
                icon: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.send),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _ResultDisplay(
            resultMessage: resultMessage,
            errorMessage: errorMessage,
          ),
        ],
      ),
    );
  }
}

class _ResultDisplay extends StatelessWidget {
  final String? resultMessage;
  final String? errorMessage;

  const _ResultDisplay({this.resultMessage, this.errorMessage});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    String text;
    Color backgroundColor;
    Color foregroundColor;
    if (errorMessage != null) {
      backgroundColor = colors.errorContainer;
      foregroundColor = colors.onErrorContainer;
      text = errorMessage!;
    } else if (resultMessage != null) {
      backgroundColor = colors.primaryContainer;
      foregroundColor = colors.onPrimaryContainer;
      text = resultMessage!;
    } else {
      backgroundColor = colors.surfaceContainerHighest;
      foregroundColor = colors.onSurfaceVariant;
      text = LocaleKeys.no_response_yet.tr();
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 60),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: backgroundColor,
        shape: OutlineInputBorder(
          borderSide: BorderSide(color: foregroundColor),
        ),
      ),
      child: Center(
        child: Text(text, style: TextStyle(color: foregroundColor)),
      ),
    );
  }
}
