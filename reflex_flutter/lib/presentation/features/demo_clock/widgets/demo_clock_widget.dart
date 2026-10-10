import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../data/repositories/demo_clock_repository.dart';
import '../../../../generated/locale_keys.g.dart';
import '../../../core/theme/app_colors.dart';
import '../controller/demo_clock_controller.dart';

/// Floating / Drawer / Persistent Time Machine widget for evaluators to simulate future days.
class DemoClockWidget extends StatefulWidget {
  final IDemoClockRepository? repositoryOverride;
  final VoidCallback? onClockShifted;

  const DemoClockWidget({
    super.key,
    this.repositoryOverride,
    this.onClockShifted,
  });

  @override
  State<DemoClockWidget> createState() => _DemoClockWidgetState();
}

class _DemoClockWidgetState extends DemoClockController {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final simulatedDate = DateTime.now().add(Duration(days: offsetDays));
    final year = simulatedDate.year;
    final month = simulatedDate.month.toString().padLeft(2, '0');
    final day = simulatedDate.day.toString().padLeft(2, '0');
    final dateStr = '$year-$month-$day';

    return Container(
      padding: const EdgeInsetsDirectional.all(14),
      decoration: BoxDecoration(
        color: isDark ? ReflexColors.darkSurface : ReflexColors.lightSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ReflexColors.accent.withValues(alpha: 0.4),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ReflexColors.accent.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: ReflexColors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.access_time_filled_rounded, color: ReflexColors.accent, size: 18),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  LocaleKeys.demo_clock_title.tr(),
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: ReflexColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  '+$offsetDays d ($dateStr)',
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: ReflexColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ActionChip(
                  key: const Key('demo_clock_1d'),
                  avatar: const Icon(Icons.fast_forward_rounded, size: 16),
                  label: Text(LocaleKeys.demo_clock_advance_1d.tr(), style: const TextStyle(fontSize: 11)),
                  onPressed: isLoading ? null : () => advance(1),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  key: const Key('demo_clock_2d'),
                  avatar: const Icon(Icons.fast_forward_rounded, size: 16),
                  label: Text(LocaleKeys.demo_clock_advance_2d.tr(), style: const TextStyle(fontSize: 11)),
                  onPressed: isLoading ? null : () => advance(2),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  key: const Key('demo_clock_30d'),
                  avatar: const Icon(Icons.skip_next_rounded, size: 16),
                  label: Text(LocaleKeys.demo_clock_advance_30d.tr(), style: const TextStyle(fontSize: 11)),
                  onPressed: isLoading ? null : () => advance(30),
                ),
                const SizedBox(width: 8),
                ActionChip(
                  key: const Key('demo_clock_reset'),
                  avatar: const Icon(Icons.restart_alt_rounded, size: 16),
                  label: Text(LocaleKeys.demo_clock_reset.tr(), style: const TextStyle(fontSize: 11)),
                  onPressed: isLoading ? null : reset,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
