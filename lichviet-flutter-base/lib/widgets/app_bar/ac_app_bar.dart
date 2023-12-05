import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/theme/theme_layouts.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';
import 'ac_app_bar_button.dart';

// Display App bar with appbar of Scafold widget
class AcAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final Color backgroundColor;

  /// App bar widget with full custom. You can provide any [child] as widget
  ///
  /// [backgroundColor] is background color of app bar. Default is white
  ///

  AcAppBar({
    Key? key,
    required this.child,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  /// [AcAppBar.primary] with defined a frame for child. [_PrimaryAppBar] widget is using for this type
  ///
  /// [_PrimaryAppBar] with back button in the left, center title and optional button in the right
  ///
  /// [title] title of app bar
  ///
  /// [backgroundColor] is background color of app bar. Default is white
  ///
  /// [centerTitle] alignment title of app bar. Default is true
  ///
  /// [optionButton] provide button in the right of app bar, such as more, share...
  ///

  AcAppBar.primary(
    String title, {
    Key? key,
    required VoidCallback onBackPressed,
    this.backgroundColor = Colors.orange,
    bool centerTitle = true,
    Widget? optionButton,
  })  : child = _PrimaryAppBar(
          title: title,
          onBackPressed: onBackPressed,
          centerTitle: centerTitle,
          optionButton: optionButton,
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: backgroundColor,
            height: ThemeLayouts.appBarHeight,
          ),
          child
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(ThemeLayouts.appBarHeight);
}

class _PrimaryAppBar extends StatelessWidget {
  final String title;
  final VoidCallback onBackPressed;
  final bool centerTitle;
  final Widget? optionButton;

  const _PrimaryAppBar({
    Key? key,
    required this.title,
    required this.onBackPressed,
    this.centerTitle = true,
    this.optionButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        AcAppBarButton.icon(Icons.arrow_back, onPressed: onBackPressed),
        Expanded(
          child: Align(
            alignment: centerTitle ? Alignment.center : Alignment.centerLeft,
            child: Text(
              title,
              style: ThemeStyles.appBar,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        if (centerTitle && optionButton == null)
          SizedBox(
            width: ThemeLayouts.appBarButtonWidth,
            height: ThemeLayouts.appBarHeight,
          ),
        optionButton ?? const SizedBox()
      ],
    );
  }
}
