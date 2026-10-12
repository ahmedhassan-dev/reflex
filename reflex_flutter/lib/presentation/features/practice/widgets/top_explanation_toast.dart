import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Shows an animated toast from the top of the app displaying teacher explanations.
OverlayEntry? showTopExplanationToast(
  BuildContext context, {
  required String explanation,
  String? title,
  Duration? duration,
}) {
  final overlay = Overlay.maybeOf(context);
  if (overlay == null) return null;

  late final OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => _TopExplanationToastWidget(
      title: title ?? LocaleKeys.practice_note_gate_title.tr(),
      explanation: explanation,
      duration: duration,
      onDismiss: () {
        if (entry.mounted) {
          entry.remove();
        }
      },
    ),
  );

  overlay.insert(entry);
  return entry;
}

class _TopExplanationToastWidget extends StatefulWidget {
  final String title;
  final String explanation;
  final Duration? duration;
  final VoidCallback onDismiss;

  const _TopExplanationToastWidget({
    required this.title,
    required this.explanation,
    this.duration,
    required this.onDismiss,
  });

  @override
  State<_TopExplanationToastWidget> createState() => _TopExplanationToastWidgetState();
}

class _TopExplanationToastWidgetState extends State<_TopExplanationToastWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;
  Timer? _autoDismissTimer;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 320),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutBack,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    _animController.forward();

    if (widget.duration != null) {
      _autoDismissTimer = Timer(widget.duration!, _dismiss);
    }
  }

  void _dismiss() {
    if (!mounted) return;
    _autoDismissTimer?.cancel();
    _animController.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  @override
  void dispose() {
    _autoDismissTimer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: SlideTransition(
            position: _offsetAnimation,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Material(
                key: const Key('top_explanation_toast'),
                elevation: 8,
                borderRadius: BorderRadius.circular(16),
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: ReflexColors.primary.withValues(alpha: 0.5),
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ReflexColors.primary.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.school_rounded,
                          color: ReflexColors.primary,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: ReflexColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              widget.explanation,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                height: 1.4,
                                color: isDark ? Colors.white70 : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        key: const Key('top_explanation_toast_close_button'),
                        icon: const Icon(Icons.close_rounded, size: 18),
                        onPressed: _dismiss,
                        tooltip: LocaleKeys.practice_got_it.tr(),
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
