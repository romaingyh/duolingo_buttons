import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:duolingo_buttons/src/widgets/duo_button_with_icon_child.dart';
import 'package:flutter/material.dart';

class DuoButton extends StyledDuoButton {
  const DuoButton({
    super.key,
    super.onPressed,
    super.onLongPress,
    super.style,
    required super.child,
  });

  DuoButton.icon({
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

  /// A static convenience method that constructs a
  /// [DuoButtonStyle] given simple values.
  static DuoButtonStyle styleFrom({
    TextStyle? textStyle,
    Color? foregroundColor,
    Color? backgroundColor,
    Color? outlineColor,
    Color? disabledForegroundColor,
    Color? disabledBackgroundColor,
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

    final WidgetStateProperty<Color?>? backgroundColorProp = switch ((backgroundColor, disabledBackgroundColor)) {
      (null, null) => null,
      (_, _) => resolveColor(backgroundColor, disabledBackgroundColor),
    };

    final WidgetStateProperty<Color?>? outlineColorProp = switch (outlineColor) {
      null when backgroundColorProp != null => WidgetStateProperty.resolveWith(
          (states) => backgroundColorProp.resolve(states)?.darken(),
        ),
      Color _ => resolveColor(outlineColor, disabledBackgroundColor),
      _ => null,
    };

    return DuoButtonStyle(
      textStyle: WidgetStatePropertyAll<TextStyle?>(textStyle),
      backgroundColor: backgroundColorProp,
      foregroundColor: foregroundColorProp,
      outlineColor: outlineColorProp,
      border: null,
      chinHeight: chinHeight,
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
    return DefaultDuoButtonStyle(context);
  }

  @override
  DuoButtonStyle? themeStyleOf(BuildContext context) {
    return Theme.of(context).extension<DuoButtonThemeExtension>()?.style;
  }
}
