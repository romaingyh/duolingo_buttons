// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DuoButtonStyle with Diagnosticable {
  const DuoButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.foregroundColor,
    this.outlineColor,
    this.chinHeight,
    this.border,
    this.borderRadius,
    this.padding,
    this.minimumSize,
    this.fixedSize,
    this.maximumSize,
    this.visualDensity,
    this.tapTargetSize,
    this.animationDuration,
    this.enableFeedback,
    this.alignment,
  });

  /// The style for a button's [Text] widget descendants.
  ///
  /// The color of the [textStyle] is typically not used directly, the
  /// [foregroundColor] is used instead.
  final WidgetStateProperty<TextStyle?>? textStyle;

  /// The button's background fill color.
  ///
  /// This color is typically null for outlined buttons.
  final WidgetStateProperty<Color?>? backgroundColor;

  /// The color for the button's [Text] and [Icon] widget descendants.
  ///
  /// This color is typically used instead of the color of the [textStyle]. All
  /// of the components that compute defaults from [ButtonStyle] values
  /// compute a default [foregroundColor] and use that instead of the
  /// [textStyle]'s color.
  final WidgetStateProperty<Color?>? foregroundColor;

  /// The color the button's outline.
  ///
  /// For filled buttons, it determines only the color of the chin.
  /// For outlined buttons, this is the color of all the border.
  final WidgetStateProperty<Color?>? outlineColor;

  /// The height of the button's chin (=bottom border width)
  ///
  /// It's only visible when not pressed,
  /// when pressed the [border] bottom side is used.
  final double? chinHeight;

  /// The button's border. It determines only the width
  /// and position of the border.
  ///
  /// For a filled button it's typically null.
  /// For an outlined buttons it's the four sides.
  ///
  /// The color of the [BorderSide] is not used, the
  /// above [outlineColor] is used instead.
  ///
  /// See [DefaultDuoButtonStyle.border] and [DefaultOutlinedDuoButtonStyle.border]
  final WidgetStateProperty<Border?>? border;

  /// The border radius of the button's underlying [Material].
  final WidgetStateProperty<double?>? borderRadius;

  /// The padding between the button's boundary and its child.
  ///
  /// The vertical aspect of the default or user-specified padding is adjusted
  /// automatically based on [visualDensity].
  ///
  /// When the visual density is [VisualDensity.compact], the top and bottom insets
  /// are reduced by 8 pixels or set to 0 pixels if the result of the reduced padding
  /// is negative. For example: the visual density defaults to [VisualDensity.compact]
  /// on desktop and web, so if the provided padding is 16 pixels on the top and bottom,
  /// it will be reduced to 8 pixels on the top and bottom. If the provided padding
  /// is 4 pixels, the result will be no padding on the top and bottom.
  ///
  /// When the visual density is [VisualDensity.comfortable], the top and bottom insets
  /// are reduced by 4 pixels or set to 0 pixels if the result of the reduced padding
  /// is negative.
  ///
  /// When the visual density is [VisualDensity.standard] the top and bottom insets
  /// are not changed. The visual density defaults to [VisualDensity.standard] on mobile.
  ///
  /// See [ThemeData.visualDensity] for more details.
  final WidgetStateProperty<EdgeInsetsGeometry?>? padding;

  /// The minimum size of the button itself.
  ///
  /// The size of the rectangle the button lies within may be larger
  /// per [tapTargetSize].
  ///
  /// This value must be less than or equal to [maximumSize].
  final WidgetStateProperty<Size?>? minimumSize;

  /// The button's size.
  ///
  /// This size is still constrained by the style's [minimumSize]
  /// and [maximumSize]. Fixed size dimensions whose value is
  /// [double.infinity] are ignored.
  ///
  /// To specify buttons with a fixed width and the default height use
  /// `fixedSize: Size.fromWidth(320)`. Similarly, to specify a fixed
  /// height and the default width use `fixedSize: Size.fromHeight(100)`.
  final WidgetStateProperty<Size?>? fixedSize;

  /// The maximum size of the button itself.
  ///
  /// A [Size.infinite] or null value for this property means that
  /// the button's maximum size is not constrained.
  ///
  /// This value must be greater than or equal to [minimumSize].
  final WidgetStateProperty<Size?>? maximumSize;

  /// Defines how compact the button's layout will be.
  ///
  /// {@macro flutter.material.themedata.visualDensity}
  ///
  /// See also:
  ///
  ///  * [ThemeData.visualDensity], which specifies the [visualDensity] for all widgets
  ///    within a [Theme].
  final VisualDensity? visualDensity;

  /// Configures the minimum size of the area within which the button may be pressed.
  ///
  /// If the [tapTargetSize] is larger than [minimumSize], the button will include
  /// a transparent margin that responds to taps.
  ///
  /// Always defaults to [ThemeData.materialTapTargetSize].
  final MaterialTapTargetSize? tapTargetSize;

  /// Defines the duration of animated changes for [shape] and [elevation].
  ///
  /// Typically the component default value is [kThemeChangeDuration].
  final Duration? animationDuration;

  /// Whether detected gestures should provide acoustic and/or haptic feedback.
  ///
  /// For example, on Android a tap will produce a clicking sound and a
  /// long-press will produce a short vibration, when feedback is enabled.
  ///
  /// Typically the component default value is true.
  ///
  /// See also:
  ///
  ///  * [Feedback] for providing platform-specific feedback to certain actions.
  final bool? enableFeedback;

  /// The alignment of the button's child.
  ///
  /// Typically buttons are sized to be just big enough to contain the child and its
  /// padding. If the button's size is constrained to a fixed size, for example by
  /// enclosing it with a [SizedBox], this property defines how the child is aligned
  /// within the available space.
  ///
  /// Always defaults to [Alignment.center].
  final AlignmentGeometry? alignment;

  EdgeInsetsGeometry scaledPadding(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final double defaultFontSize = theme.textTheme.labelLarge?.fontSize ?? 14.0;
    final double effectiveTextScale = MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0;
    const double padding1x = 12.0;
    return ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: padding1x),
      const EdgeInsets.symmetric(horizontal: padding1x / 2),
      const EdgeInsets.symmetric(horizontal: padding1x / 2 / 2),
      effectiveTextScale,
    );
  }

  DuoButtonStyle copyWith({
    WidgetStateProperty<TextStyle?>? textStyle,
    WidgetStateProperty<Color?>? backgroundColor,
    WidgetStateProperty<Color?>? foregroundColor,
    WidgetStateProperty<Color?>? outlineColor,
    double? chinHeight,
    WidgetStateProperty<Border?>? border,
    WidgetStateProperty<double?>? borderRadius,
    WidgetStateProperty<EdgeInsetsGeometry?>? padding,
    WidgetStateProperty<Size?>? minimumSize,
    WidgetStateProperty<Size?>? fixedSize,
    WidgetStateProperty<Size?>? maximumSize,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
  }) {
    return DuoButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      outlineColor: outlineColor ?? this.outlineColor,
      chinHeight: chinHeight ?? this.chinHeight,
      border: border ?? this.border,
      borderRadius: borderRadius ?? this.borderRadius,
      padding: padding ?? this.padding,
      minimumSize: minimumSize ?? this.minimumSize,
      fixedSize: fixedSize ?? this.fixedSize,
      maximumSize: maximumSize ?? this.maximumSize,
      visualDensity: visualDensity ?? this.visualDensity,
      tapTargetSize: tapTargetSize ?? this.tapTargetSize,
      animationDuration: animationDuration ?? this.animationDuration,
      enableFeedback: enableFeedback ?? this.enableFeedback,
      alignment: alignment ?? this.alignment,
    );
  }

  @override
  bool operator ==(covariant DuoButtonStyle other) {
    if (identical(this, other)) return true;

    return other.textStyle == textStyle &&
        other.backgroundColor == backgroundColor &&
        other.foregroundColor == foregroundColor &&
        other.outlineColor == outlineColor &&
        other.chinHeight == chinHeight &&
        other.border == border &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.minimumSize == minimumSize &&
        other.fixedSize == fixedSize &&
        other.maximumSize == maximumSize &&
        other.visualDensity == visualDensity &&
        other.tapTargetSize == tapTargetSize &&
        other.animationDuration == animationDuration &&
        other.enableFeedback == enableFeedback &&
        other.alignment == alignment;
  }

  @override
  int get hashCode {
    return textStyle.hashCode ^
        backgroundColor.hashCode ^
        foregroundColor.hashCode ^
        outlineColor.hashCode ^
        chinHeight.hashCode ^
        border.hashCode ^
        borderRadius.hashCode ^
        padding.hashCode ^
        minimumSize.hashCode ^
        fixedSize.hashCode ^
        maximumSize.hashCode ^
        visualDensity.hashCode ^
        tapTargetSize.hashCode ^
        animationDuration.hashCode ^
        enableFeedback.hashCode ^
        alignment.hashCode;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<WidgetStateProperty<TextStyle?>>('textStyle', textStyle, defaultValue: null));
    properties
        .add(DiagnosticsProperty<WidgetStateProperty<Color?>>('backgroundColor', backgroundColor, defaultValue: null));
    properties
        .add(DiagnosticsProperty<WidgetStateProperty<Color?>>('foregroundColor', foregroundColor, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Color?>>('outlineColor', outlineColor, defaultValue: null));
    properties.add(DiagnosticsProperty<double?>('chinHeight', chinHeight, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Border?>>('border', border, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<double?>>('borderRadius', borderRadius, defaultValue: null));
    properties
        .add(DiagnosticsProperty<WidgetStateProperty<EdgeInsetsGeometry?>>('padding', padding, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Size?>>('minimumSize', minimumSize, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Size?>>('fixedSize', fixedSize, defaultValue: null));
    properties.add(DiagnosticsProperty<WidgetStateProperty<Size?>>('maximumSize', maximumSize, defaultValue: null));
    properties.add(DiagnosticsProperty<VisualDensity>('visualDensity', visualDensity, defaultValue: null));
    properties.add(EnumProperty<MaterialTapTargetSize>('tapTargetSize', tapTargetSize, defaultValue: null));
    properties.add(DiagnosticsProperty<Duration>('animationDuration', animationDuration, defaultValue: null));
    properties.add(DiagnosticsProperty<bool>('enableFeedback', enableFeedback, defaultValue: null));
    properties.add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment, defaultValue: null));
  }

  /// Linearly interpolate between two [ButtonStyle]s.
  static DuoButtonStyle? lerp(DuoButtonStyle? a, DuoButtonStyle? b, double t) {
    if (identical(a, b)) {
      return a;
    }
    return DuoButtonStyle(
      textStyle: WidgetStateProperty.lerp<TextStyle?>(a?.textStyle, b?.textStyle, t, TextStyle.lerp),
      backgroundColor: WidgetStateProperty.lerp<Color?>(a?.backgroundColor, b?.backgroundColor, t, Color.lerp),
      foregroundColor: WidgetStateProperty.lerp<Color?>(a?.foregroundColor, b?.foregroundColor, t, Color.lerp),
      outlineColor: WidgetStateProperty.lerp<Color?>(a?.outlineColor, b?.outlineColor, t, Color.lerp),
      chinHeight: lerpDouble(a?.chinHeight, b?.chinHeight, t),
      border: WidgetStateProperty.lerp<Border?>(a?.border, b?.border, t, Border.lerp),
      borderRadius: WidgetStateProperty.lerp<double?>(a?.borderRadius, b?.borderRadius, t, lerpDouble),
      padding: WidgetStateProperty.lerp<EdgeInsetsGeometry?>(a?.padding, b?.padding, t, EdgeInsetsGeometry.lerp),
      minimumSize: WidgetStateProperty.lerp<Size?>(a?.minimumSize, b?.minimumSize, t, Size.lerp),
      fixedSize: WidgetStateProperty.lerp<Size?>(a?.fixedSize, b?.fixedSize, t, Size.lerp),
      maximumSize: WidgetStateProperty.lerp<Size?>(a?.maximumSize, b?.maximumSize, t, Size.lerp),
      visualDensity: t < 0.5 ? a?.visualDensity : b?.visualDensity,
      tapTargetSize: t < 0.5 ? a?.tapTargetSize : b?.tapTargetSize,
      animationDuration: t < 0.5 ? a?.animationDuration : b?.animationDuration,
      enableFeedback: t < 0.5 ? a?.enableFeedback : b?.enableFeedback,
      alignment: AlignmentGeometry.lerp(a?.alignment, b?.alignment, t),
    );
  }
}
