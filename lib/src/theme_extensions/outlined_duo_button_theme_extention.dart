import 'package:duolingo_buttons/src/styles/duolingo_button_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// A [DuoButtonStyle] that overrides the default appearance of
/// [OutlinedDuoButton]s when it's used as [ThemeExtension].
///
/// The [style]'s properties override [OutlinedDuoButton]'s default style,
/// i.e. the [DuoButtonStyle] returned by [OutlinedDuoButton.defaultStyleOf]. Only
/// the style's non-null property values or resolved non-null
/// [WidgetlStateProperty] values are used.
@immutable
class OutlinedDuoButtonThemeExtension extends ThemeExtension<OutlinedDuoButtonThemeExtension> with Diagnosticable {
  /// Creates a [OutlinedDuoButtonThemeExtension].
  ///
  /// The [style] may be null.
  const OutlinedDuoButtonThemeExtension({this.style});

  /// Overrides for [OutlinedDuoButton]'s default style.
  ///
  /// Non-null properties or non-null resolved [WidgetStateProperty]
  /// values override the [DuoButtonStyle] returned by
  /// [OutlinedDuoButton.defaultStyleOf].
  ///
  /// If [style] is null, then this theme doesn't override anything.
  final DuoButtonStyle? style;

  /// Linearly interpolate between two outlined duo button themes.
  @override
  OutlinedDuoButtonThemeExtension lerp(OutlinedDuoButtonThemeExtension? other, double t) {
    if (identical(this, other)) {
      return this;
    }
    return OutlinedDuoButtonThemeExtension(
      style: DuoButtonStyle.lerp(style, other?.style, t),
    );
  }

  @override
  ThemeExtension<OutlinedDuoButtonThemeExtension> copyWith({DuoButtonStyle? style}) {
    return OutlinedDuoButtonThemeExtension(style: style ?? this.style);
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
    return other is OutlinedDuoButtonThemeExtension && other.style == style;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<DuoButtonStyle>('style', style, defaultValue: null));
  }
}
