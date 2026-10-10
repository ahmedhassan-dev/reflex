import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';

/// Response timer widget providing a live visual cue against expected target seconds.
class ResponseTimerWidget extends StatefulWidget {
  final int expectedSeconds;
  final bool isRunning;

  const ResponseTimerWidget({
    super.key,
    required this.expectedSeconds,
    this.isRunning = true,
  });

  @override
  State<ResponseTimerWidget> createState() => _ResponseTimerWidgetState();
}

class _ResponseTimerWidgetState extends State<ResponseTimerWidget> {
  Timer? _timer;
  int _elapsedMillis = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isRunning) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant ResponseTimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.expectedSeconds != oldWidget.expectedSeconds) {
      _elapsedMillis = 0;
    }
    if (widget.isRunning != oldWidget.isRunning) {
      if (widget.isRunning) {
        _startTimer();
      } else {
        _timer?.cancel();
      }
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _elapsedMillis = 0;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (t) {
      if (!mounted) {
        t.cancel();
        return;
      }
      setState(() {
        _elapsedMillis += 100;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final totalExpectedMillis = widget.expectedSeconds * 1000;
    final progress = totalExpectedMillis > 0
        ? (_elapsedMillis / totalExpectedMillis).clamp(0.0, 1.0)
        : 1.0;

    Color timerColor;
    if (progress < 0.6) {
      timerColor = ReflexColors.chromaticGreen;
    } else if (progress < 1.0) {
      timerColor = ReflexColors.chromaticYellow;
    } else {
      timerColor = ReflexColors.chromaticRed;
    }

    final elapsedSeconds = (_elapsedMillis / 1000).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: timerColor.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: timerColor.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              value: progress,
              strokeWidth: 2.5,
              backgroundColor: timerColor.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(timerColor),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${elapsedSeconds}s',
            style: TextStyle(
              color: timerColor,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '(${LocaleKeys.practice_target_time.tr(args: [widget.expectedSeconds.toString()])})',
            style: theme.textTheme.bodySmall?.copyWith(
              color: timerColor.withValues(alpha: 0.85),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
