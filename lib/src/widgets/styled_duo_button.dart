import 'dart:math' as math;

import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class StyledDuoButton extends StatefulWidget {
  const StyledDuoButton({
    super.key,
    required this.onPressed,
    required this.onLongPress,
    required this.style,
    required this.child,
  });

  final Widget child;

  final VoidCallback? onPressed;

  final VoidCallback? onLongPress;

  final DuoButtonStyle? style;

  /// Whether the button is enabled or disabled.
  ///
  /// Buttons are disabled by default. To enable a button, set its [onPressed]
  /// or [onLongPress] properties to a non-null value.
  bool get enabled => onPressed != null || onLongPress != null;

  /// Returns a non-null [DuoButtonStyle] that's based primarily on the [Theme]'s
  /// [ThemeData.textTheme] and [ThemeData.colorScheme].
  ///
  /// The returned style can be overridden by the [style] parameter and
  /// by the style returned by [themeStyleOf]. For example the default
  /// style of the [DuoButton] subclass can be overridden with its
  /// [DuoButton.style] constructor parameter, or with a
  /// [DuolingoButtonTheme].
  ///
  /// Concrete button subclasses should return a ButtonStyle that
  /// has no null properties, and where all of the [WidgetStateProperty]
  /// properties resolve to non-null values.
  ///
  /// See also:
  ///
  ///  * [themeStyleOf], Returns the ButtonStyle of this button's component theme.
  @protected
  DuoButtonStyle defaultStyleOf(BuildContext context);

  /// Returns the [DuoButtonStyle] that belongs to the button's component theme.
  ///
  /// The returned style can be overridden by the [style] parameter.
  ///
  /// Concrete button subclasses should return the [DuoButtonStyle] for the
  /// nearest subclass-specific inherited theme, and if no such theme
  /// exists, then the same value from the overall [Theme].
  ///
  /// See also:
  ///
  ///  * [defaultStyleOf], Returns the default [DuoButtonStyle] for this button.
  @protected
  DuoButtonStyle? themeStyleOf(BuildContext context);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
    properties.add(DiagnosticsProperty<DuoButtonStyle>('style', style, defaultValue: null));
  }

  @override
  State<StyledDuoButton> createState() => _StyledDuoButtonState();
}

class _StyledDuoButtonState extends State<StyledDuoButton> with TickerProviderStateMixin {
  final WidgetStatesController statesController = WidgetStatesController();

  void handleStatesControllerChange() {
    // Force a rebuild to resolve WidgetStateProperty propertiesstatesController
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    super.initState();

    statesController.update(WidgetState.disabled, !widget.enabled);
    statesController.addListener(handleStatesControllerChange);
  }

  @override
  void dispose() {
    statesController.removeListener(handleStatesControllerChange);
    statesController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(StyledDuoButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.enabled != oldWidget.enabled) {
      statesController.update(WidgetState.disabled, !widget.enabled);
      if (!widget.enabled) {
        // The button may have been disabled while a press gesture is currently underway.
        statesController.update(WidgetState.pressed, false);
      }
    }
  }

  Border _computeBorder(Border? resolvedBorder, Color resolvedOutlineColor, double chinHeight) {
    final BorderSide chinBorderSide = BorderSide(
      color: resolvedOutlineColor,
      strokeAlign: BorderSide.strokeAlignOutside,
      width: chinHeight,
    );

    return Border(
      top: resolvedBorder?.top.copyWith(color: resolvedOutlineColor) ?? BorderSide.none,
      left: resolvedBorder?.left.copyWith(color: resolvedOutlineColor) ?? BorderSide.none,
      right: resolvedBorder?.right.copyWith(color: resolvedOutlineColor) ?? BorderSide.none,
      bottom: switch (statesController.value.contains(WidgetState.pressed)) {
        false => chinBorderSide,
        true => resolvedBorder?.bottom.copyWith(
              color: resolvedOutlineColor,
              strokeAlign: BorderSide.strokeAlignOutside,
            ) ??
            BorderSide(strokeAlign: BorderSide.strokeAlignOutside, color: resolvedOutlineColor),
      },
    );
  }

  BoxConstraints _computeConstraints(
    VisualDensity resolvedVisualDensity,
    Size? resolvedMinimumSize,
    Size? resolvedMaximumSize,
    Size? resolvedFixedSize,
  ) {
    BoxConstraints effectiveConstraints = resolvedVisualDensity.effectiveConstraints(
      BoxConstraints(
        minWidth: resolvedMinimumSize!.width,
        minHeight: resolvedMinimumSize.height,
        maxWidth: resolvedMaximumSize!.width,
        maxHeight: resolvedMaximumSize.height,
      ),
    );

    if (resolvedFixedSize != null) {
      final Size size = effectiveConstraints.constrain(resolvedFixedSize);
      if (size.width.isFinite) {
        effectiveConstraints = effectiveConstraints.copyWith(
          minWidth: size.width,
          maxWidth: size.width,
        );
      }
      if (size.height.isFinite) {
        effectiveConstraints = effectiveConstraints.copyWith(
          minHeight: size.height,
          maxHeight: size.height,
        );
      }
    }

    return effectiveConstraints;
  }

  @override
  Widget build(BuildContext context) {
    final DuoButtonStyle? widgetStyle = widget.style;
    final DuoButtonStyle? themeStyle = widget.themeStyleOf(context);
    final DuoButtonStyle defaultStyle = widget.defaultStyleOf(context);

    T? effectiveValue<T>(T? Function(DuoButtonStyle? style) getProperty) {
      final T? widgetValue = getProperty(widgetStyle);
      final T? themeValue = getProperty(themeStyle);
      final T? defaultValue = getProperty(defaultStyle);
      return widgetValue ?? themeValue ?? defaultValue;
    }

    T? resolve<T>(WidgetStateProperty<T>? Function(DuoButtonStyle? style) getProperty) {
      return effectiveValue(
        (DuoButtonStyle? style) {
          return getProperty(style)?.resolve(statesController.value);
        },
      );
    }

    // MARK: - Padding
    final EdgeInsetsGeometry? resolvedPadding = resolve<EdgeInsetsGeometry?>((style) => style?.padding);

    final VisualDensity resolvedVisualDensity = effectiveValue((DuoButtonStyle? style) => style?.visualDensity)!;

    final double dy = resolvedVisualDensity.baseSizeAdjustment.dy;
    final double dx = math.max(0, resolvedVisualDensity.baseSizeAdjustment.dx);
    final EdgeInsetsGeometry padding =
        resolvedPadding!.add(EdgeInsets.fromLTRB(dx, dy, dx, dy)).clamp(EdgeInsets.zero, EdgeInsetsGeometry.infinity);

    Widget effectiveChild = Padding(
      padding: padding,
      child: Align(
        alignment: Alignment.center,
        widthFactor: 1.0,
        heightFactor: 1.0,
        child: widget.child,
      ),
    );

    // MARK: - Border
    final Color resolvedOutlineColor = resolve<Color?>((style) => style?.outlineColor)!;

    final Border? resolvedBorder = resolve<Border?>((style) => style?.border);

    final double chinHeight = effectiveValue((style) => style?.chinHeight)!;

    final Border border = _computeBorder(resolvedBorder, resolvedOutlineColor, chinHeight);

    final double effectiveBorderRadius = resolve<double?>((style) => style?.borderRadius) ?? 0.0;

    /// To compense border and keep a fixed height, we need to add margin to our container
    /// If we don't do this, all the UI will move on button press
    final EdgeInsetsGeometry resolvedContainerMargin = EdgeInsets.only(
      top: chinHeight - border.bottom.width,
      bottom: border.bottom.width,
    );

    // MARK: - Size
    final Size? resolvedMinimumSize = resolve<Size?>((DuoButtonStyle? style) => style?.minimumSize);
    final Size? resolvedFixedSize = resolve<Size?>((DuoButtonStyle? style) => style?.fixedSize);
    final Size? resolvedMaximumSize = resolve<Size?>((DuoButtonStyle? style) => style?.maximumSize);

    final BoxConstraints effectiveConstraints = _computeConstraints(
      resolvedVisualDensity,
      resolvedMinimumSize,
      resolvedMaximumSize,
      resolvedFixedSize,
    );

    effectiveChild = ConstrainedBox(
      constraints: effectiveConstraints,
      child: effectiveChild,
    );

    // MARK: - Others
    final Color? resolvedForegroundColor = resolve<Color?>((style) => style?.foregroundColor);

    final Color? resolvedBackgroundColor = resolve<Color?>((style) => style?.backgroundColor);

    final TextStyle? resolvedTextStyle = resolve<TextStyle?>((style) => style?.textStyle);

    final Duration effectiveAnimationDuration = effectiveValue(
      (DuoButtonStyle? style) => style?.animationDuration,
    )!;

    return AnimatedContainer(
      duration: effectiveAnimationDuration,
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: border,
        color: resolvedBackgroundColor,
      ),
      margin: resolvedContainerMargin,
      child: DefaultTextStyle(
        style: resolvedTextStyle?.copyWith(color: resolvedForegroundColor) ?? const TextStyle(),
        child: InkWell(
          onTapDown: widget.enabled
              ? (_) {
                  if (widget.enabled) {
                    HapticFeedback.lightImpact();
                  }
                }
              : null,
          onTap: widget.onPressed,
          onLongPress: widget.onLongPress,
          canRequestFocus: widget.enabled,
          statesController: statesController,
          borderRadius: BorderRadius.circular(effectiveBorderRadius),
          overlayColor: const WidgetStatePropertyAll(Colors.transparent),
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          child: IconTheme.merge(
            data: IconThemeData(color: resolvedForegroundColor),
            child: effectiveChild,
          ),
        ),
      ),
    );
  }
}
