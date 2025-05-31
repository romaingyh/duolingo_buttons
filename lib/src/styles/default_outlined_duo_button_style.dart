import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';

class DefaultOutlinedDuoButtonStyle extends DuoButtonStyle {
  DefaultOutlinedDuoButtonStyle(
    this.context, {
    super.animationDuration = const Duration(milliseconds: 100),
    super.enableFeedback = true,
    super.alignment = Alignment.center,
  });

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  WidgetStateProperty<TextStyle?> get textStyle =>
      WidgetStatePropertyAll<TextStyle?>(
          Theme.of(context).textTheme.labelLarge);

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      const WidgetStatePropertyAll(null);

  @override
  WidgetStateProperty<Color?>? get foregroundColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return _colors.onSurface.withValues(alpha: 0.38);
        }
        return _colors.onSurface;
      });

  @override
  WidgetStateProperty<Color?>? get outlineColor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return _colors.onSurface.withValues(alpha: 0.12);
        }

        return _colors.onSurface;
      });

  @override
  double? get chinHeight => 4.0;

  @override
  WidgetStateProperty<Border?>? get border => const WidgetStatePropertyAll(
        Border(
          top: BorderSide(width: 2.0),
          left: BorderSide(width: 2.0),
          right: BorderSide(width: 2.0),
          bottom: BorderSide(width: 2.0 + 0.0001),
        ),
      );

  @override
  WidgetStateProperty<double?>? get borderRadius =>
      const WidgetStatePropertyAll<double?>(12.0);

  @override
  WidgetStateProperty<EdgeInsetsGeometry>? get padding =>
      WidgetStatePropertyAll<EdgeInsetsGeometry>(super.scaledPadding(context));

  @override
  WidgetStateProperty<Size>? get minimumSize =>
      const WidgetStatePropertyAll<Size>(Size(64.0, 40.0));

  // No default fixedSize

  @override
  WidgetStateProperty<Size>? get maximumSize =>
      const WidgetStatePropertyAll<Size>(Size.infinite);

  @override
  VisualDensity? get visualDensity => Theme.of(context).visualDensity;

  @override
  MaterialTapTargetSize? get tapTargetSize =>
      Theme.of(context).materialTapTargetSize;
}
