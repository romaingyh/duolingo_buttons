library duolingo_buttons;

import 'package:flutter/material.dart';

export 'src/styles/default_duo_button_style.dart';
export 'src/styles/default_icon_duo_button_style.dart';
export 'src/styles/default_outlined_duo_button_style.dart';
export 'src/styles/duolingo_button_style.dart';
export 'src/theme_extensions/duo_button_theme_extention.dart';
export 'src/theme_extensions/icon_duo_button_theme_extention.dart';
export 'src/theme_extensions/outlined_duo_button_theme_extention.dart';
export 'src/widgets/duo_button.dart';
export 'src/widgets/icon_duo_button.dart';
export 'src/widgets/outlined_duo_button.dart';
export 'src/widgets/styled_duo_button.dart';

extension ColorBrightness on Color {
  Color darken([double amount = .1]) {
    assert(amount >= 0 && amount <= 1);

    final hsl = HSLColor.fromColor(this);
    final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

    return hslDark.toColor();
  }
}
