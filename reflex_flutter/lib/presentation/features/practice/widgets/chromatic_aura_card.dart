import 'package:flutter/material.dart';
import 'package:reflex_client/reflex_client.dart';
import '../../../core/theme/app_colors.dart';

/// Card container that applies an animated chromatic aura (Red, Yellow, Green)
/// based on the evaluation reflex tier.
class ChromaticAuraCard extends StatelessWidget {
  final ReflexTier? tier;
  final Widget child;
  final EdgeInsetsGeometry padding;

  const ChromaticAuraCard({
    super.key,
    required this.child,
    this.tier,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color borderColor;
    Color backgroundColor;
    List<BoxShadow> shadows = [];

    switch (tier) {
      case ReflexTier.greenMastered:
        borderColor = ReflexColors.chromaticGreen;
        backgroundColor = ReflexColors.chromaticGreen.withValues(alpha: isDark ? 0.12 : 0.08);
        shadows = [
          BoxShadow(
            color: ReflexColors.chromaticGreen.withValues(alpha: 0.25),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ];
        break;
      case ReflexTier.yellowDeveloping:
        borderColor = ReflexColors.chromaticYellow;
        backgroundColor = ReflexColors.chromaticYellow.withValues(alpha: isDark ? 0.12 : 0.08);
        shadows = [
          BoxShadow(
            color: ReflexColors.chromaticYellow.withValues(alpha: 0.25),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ];
        break;
      case ReflexTier.redNeedsWork:
        borderColor = ReflexColors.chromaticRed;
        backgroundColor = ReflexColors.chromaticRed.withValues(alpha: isDark ? 0.12 : 0.08);
        shadows = [
          BoxShadow(
            color: ReflexColors.chromaticRed.withValues(alpha: 0.25),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ];
        break;
      case null:
        borderColor = isDark ? ReflexColors.darkBorder : ReflexColors.lightBorder;
        backgroundColor = isDark ? ReflexColors.darkCard : ReflexColors.lightCard;
        shadows = [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ];
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOut,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: tier != null ? 2 : 1),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}
