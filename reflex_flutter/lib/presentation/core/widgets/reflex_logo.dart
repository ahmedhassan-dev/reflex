import "package:flutter/material.dart";

/// Reusable branding logo for the Reflex platform.
class ReflexLogo extends StatelessWidget {
  final double size;
  final double borderRadius;
  final BoxBorder? border;

  const ReflexLogo({
    super.key,
    this.size = 28,
    this.borderRadius = 8,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Image.asset(
          "assets/images/logo.png",
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
