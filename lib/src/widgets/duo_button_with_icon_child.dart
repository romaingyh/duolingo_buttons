import 'dart:ui';

import 'package:duolingo_buttons/duolingo_buttons.dart';
import 'package:flutter/material.dart';

class DuoButtonWithIconChild extends StatelessWidget {
  const DuoButtonWithIconChild({
    super.key,
    required this.label,
    required this.icon,
    required this.buttonStyle,
    required this.iconAlignment,
  });

  final Widget label;

  final Widget icon;

  final DuoButtonStyle? buttonStyle;

  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) {
    final double defaultFontSize = buttonStyle?.textStyle?.resolve(const <WidgetState>{})?.fontSize ?? 14.0;
    final double scale = clampDouble(MediaQuery.textScalerOf(context).scale(defaultFontSize) / 14.0, 1.0, 2.0) - 1.0;
    // Adjust the gap based on the text scale factor. Start at 8, and lerp
    // to 4 based on how large the text is.
    final double gap = lerpDouble(8, 4, scale)!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: switch (iconAlignment) {
        IconAlignment.start => [
            icon,
            SizedBox(width: gap),
            Flexible(child: label),
          ],
        IconAlignment.end => [
            Flexible(child: label),
            SizedBox(width: gap),
            icon,
          ],
      },
    );
  }
}
