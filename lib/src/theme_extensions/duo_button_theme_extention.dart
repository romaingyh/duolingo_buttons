import 'package:duolingo_buttons/src/styles/duolingo_button_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A [DuoButtonStyle] that overrides the default appearance of
/// [DuoButton]s when it's used as [ThemeExtension].
///
/// The [style]'s properties override [DuoButton]'s default style,
/// i.e. the [DuoButtonStyle] returned by [DuoButton.defaultStyleOf]. Only
/// the style's non-null property values or resolved non-null
/// [WidgetlStateProperty] values are used.
@immutable
class DuoButtonThemeExtension extends ThemeExtension<DuoButtonThemeExtension> with Diagnosticable {
  /// Creates a [DuoButtonThemeExtension].
  ///
  /// The [style] may be null.
  const DuoButtonThemeExtension({this.style});

  /// Overrides for [DuoButton]'s default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the [DuoButtonStyle] returned by
  /// [DuoButton.defaultStyleOf].
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final DuoButtonStyle? style;

  /// Linearly interpolate between two duo button themes.
  @override
  DuoButtonThemeExtension lerp(DuoButtonThemeExtension? other, double t) {
    if (identical(this, other)) {
      return this;
    }
    return DuoButtonThemeExtension(
      style: DuoButtonStyle.lerp(style, other?.style, t),
    );
  }

  @override
  ThemeExtension<DuoButtonThemeExtension> copyWith({DuoButtonStyle? style}) {
    return DuoButtonThemeExtension(style: style ?? this.style);
  }

  @override
  int get hashCode => style.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DuoButtonThemeExtension && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DuoButtonStyle>('style', style, defaultValue: null));
  }
}
