import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:duolingo_buttons/src/widgets/duo_button_with_icon_child.dart';
import 'package:flutter/material.dart';

class OutlinedDuoButton extends StyledDuoButton {
  const OutlinedDuoButton({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.style,
    required super.child,
  });

  OutlinedDuoButton.icon({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.style,
    required Widget label,
    required Widget icon,
    IconAlignment iconAlignment = IconAlignment.start,
  }) : super(
          child: DuoButtonWithIconChild(
            label: label,
            icon: icon,
            buttonStyle: style,
            iconAlignment: iconAlignment,
          ),
        );

  /// A static convenience method that constructs an outlined duo button
  /// [DuoButtonStyle] given simple values.
  static DuoButtonStyle styleFrom({
    TextStyle? textStyle,
    Color? foregroundColor,
    Color? disabledForegroundColor,
    Color? outlineColor,
    Color? disabledOutlineColor,
    double? outlineWidth,
    double? chinHeight,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    Size? maximumSize,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
  }) {
    WidgetStateProperty<Color?> resolveColor(Color? color, Color? disabledColor) => WidgetStateProperty.resolveWith(
          (states) => switch (states.contains(WidgetState.disabled)) {
            true => disabledColor,
            false => color,
          },
        );

    WidgetStateProperty<T?>? allOrNull<T>(T? value) => value == null ? null : WidgetStatePropertyAll(value);

    final WidgetStateProperty<Color?>? foregroundColorProp = switch ((foregroundColor, disabledForegroundColor)) {
      (null, null) => null,
      _ => resolveColor(foregroundColor, disabledForegroundColor),
    };

    final WidgetStateProperty<Color?>? outlineColorProp = switch ((outlineColor, disabledOutlineColor)) {
          (null, null) => null,
          _ => resolveColor(outlineColor, disabledOutlineColor),
        } ??
        foregroundColorProp;

    final WidgetStateProperty<Border?>? borderProp = switch (outlineWidth) {
      null => null,
      _ => WidgetStatePropertyAll(Border(
          top: BorderSide(width: outlineWidth),
          left: BorderSide(width: outlineWidth),
          right: BorderSide(width: outlineWidth),
          bottom: BorderSide(width: outlineWidth),
        )),
    };

    return DuoButtonStyle(
      textStyle: WidgetStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: null,
      foregroundColor: foregroundColorProp,
      outlineColor: outlineColorProp,
      chinHeight: chinHeight,
      border: borderProp,
      borderRadius: allOrNull<double>(borderRadius),
      padding: allOrNull<EdgeInsetsGeometry>(padding),
      minimumSize: allOrNull<Size>(minimumSize),
      fixedSize: allOrNull<Size>(fixedSize),
      maximumSize: allOrNull<Size>(maximumSize),
      visualDensity: visualDensity,
      tapTargetSize: tapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      alignment: alignment,
    );
  }

  @override
  DuoButtonStyle defaultStyleOf(BuildContext context) {
    return DefaultOutlinedDuoButtonStyle(context);
  }

  @override
  DuoButtonStyle? themeStyleOf(BuildContext context) {
    return Theme.of(context).extension<OutlinedDuoButtonThemeExtension>()?.style;
  }
}
