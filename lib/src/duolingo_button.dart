import 'dart:math' as math;

import 'package:flutter/material.dart';

class DuolingoButton extends StatefulWidget {
  const DuolingoButton({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.visualDensity,
    this.borderRadius,
    this.foregroundColor,
    this.backgroundColor,
    this.chinHeight,
    this.animationDuration,
  })  : isOutlined = false,
        outlineColor = null;

  const DuolingoButton.outlined({
    super.key,
    required this.child,
    this.onPressed,
    this.onLongPress,
    this.visualDensity,
    this.borderRadius,
    this.foregroundColor,
    this.outlineColor,
    this.chinHeight,
    this.animationDuration,
  })  : backgroundColor = Colors.transparent,
        isOutlined = true;

  final Widget child;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final VisualDensity? visualDensity;

  final double? borderRadius;

  final Color? foregroundColor;

  final Color? backgroundColor;

  final double? chinHeight;

  final bool isOutlined;

  final Color? outlineColor;

  final Duration? animationDuration;

  @override
  State<DuolingoButton> createState() => _DuolingoButtonState();
}

class _DuolingoButtonState extends State<DuolingoButton> with TickerProviderStateMixin {
  final WidgetStatesController statesController = WidgetStatesController();

  void handleStatesControllerChange() {
    // Force a rebuild to resolve MaterialStateProperty propertiesstatesController
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    statesController.addListener(handleStatesControllerChange);
  }

  @override
  void dispose() {
    statesController.removeListener(handleStatesControllerChange);
    statesController.dispose();
    super.dispose();
  }

  // MARK: - Theme

  ThemeData get theme => Theme.of(context);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  // MARK: - Properties
  VisualDensity get effectiveVisualDensity => widget.visualDensity ?? theme.visualDensity;

  EdgeInsetsGeometry get effectivePadding => const EdgeInsets.all(16.0);

  double get effectiveBorderRadius => widget.borderRadius ?? 12.0;

  Color? get effectiveForegroundColor => widget.foregroundColor;

  Color get effectiveBackgroundColor => widget.backgroundColor ?? colorScheme.primary;

  double get effectiveChinHeight => widget.chinHeight ?? 4.0;

  Color get effectiveOutlineColor => widget.outlineColor ?? colorScheme.outline;

  Duration get effectiveAnimationDuration => widget.animationDuration ?? const Duration(milliseconds: 100);

  // MARK: - Widget state properties

  WidgetStateProperty<Color> get effectiveChinColor => WidgetStateProperty.resolveWith(
        (states) => switch (states.contains(WidgetState.pressed)) {
          false => effectiveBackgroundColor.darken(),
          true => Colors.transparent,
        },
      );

  EdgeInsetsGeometry get adjustedPadding {
    final Offset densityAdjustment = effectiveVisualDensity.baseSizeAdjustment;
    final double dx = math.max(0, densityAdjustment.dx);
    final double dy = densityAdjustment.dy;

    return effectivePadding
        .add(EdgeInsets.fromLTRB(dx, dy, dx, dy))
        .clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = textTheme.labelLarge?.copyWith(color: effectiveForegroundColor);

    Widget effectiveChild = Padding(
      padding: adjustedPadding,
      child: Align(
        alignment: Alignment.center,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: widget.child,
      ),
    );

    final Color resolvedBorderColor = switch (widget.isOutlined) {
      false => effectiveChinColor.resolve(statesController.value),
      true => effectiveOutlineColor,
    };

    final BorderSide borderSide = switch (widget.isOutlined) {
      true => BorderSide(color: resolvedBorderColor, width: 1.0),
      false => BorderSide.none,
    };

    final bool isPressed = statesController.value.contains(WidgetState.pressed);

    final Border resolvedBorder = Border.merge(
      Border(
        bottom: BorderSide(
          color: resolvedBorderColor,
          strokeAlign: BorderSide.strokeAlignOutside,
          width: isPressed ? 1.0 : effectiveChinHeight,
        ),
      ),
      Border.fromBorderSide(borderSide),
    );

    /// To compense border and keep a fixed height, we need to add margin to our container
    /// If we don't do this, all the UI will move on button press
    final EdgeInsetsGeometry resolvedContainerMargin = switch (statesController.value.contains(WidgetState.pressed)) {
      true => EdgeInsets.only(top: effectiveChinHeight),
      false => EdgeInsets.only(bottom: effectiveChinHeight),
    };

    return AnimatedContainer(
      duration: effectiveAnimationDuration,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: resolvedBorder,
      ),
      margin: resolvedContainerMargin,
      child: Material(
        elevation: 0,
        textStyle: textStyle,
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: InkWell(
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          statesController: statesController,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          splashFactory: NoSplash.splashFactory,
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          child: IconTheme.merge(
            data: IconThemeData(color: effectiveForegroundColor),
            child: effectiveChild,
          ),
        ),
      ),
    );
  }
}

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
