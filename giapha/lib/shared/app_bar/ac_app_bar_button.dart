import 'package:flutter/material.dart';

import '../themes/theme_layouts.dart';

class AcAppBarButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;

  /// [AcAppBarButton.custom] allow provide any widget as [child]
  ///
  /// [onPressed] callback once button is pressed
  ///

  const AcAppBarButton.custom({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  /// [AcAppBarButton.text] allow provide a string into the button
  ///
  /// [onPressed] callback once button is pressed
  ///

  AcAppBarButton.text(
    String text, {
    Key? key,
    TextStyle? textStyle,
    required this.onPressed,
  })  : child = Text(
          text,
          style: textStyle,
        ),
        super(key: key);

  /// [AcAppBarButton.icon] allow provide a icon into the button
  ///
  /// [onPressed] callback once button is pressed
  ///
  /// [iconSize] size of icon inside the button
  ///

  AcAppBarButton.icon(
    IconData icon, {
    Key? key,
    required this.onPressed,
    double iconSize = 22,
  })  : child = Icon(
          icon,
          size: iconSize,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: ThemeLayouts.appBarButtonWidth,
          height: ThemeLayouts.appBarHeight,
          child: Center(child: child),
        ),
      ),
    );
  }
}
