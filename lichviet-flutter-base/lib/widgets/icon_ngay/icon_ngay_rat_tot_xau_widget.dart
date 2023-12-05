import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';

class IconNgayRatTotXauWidget extends StatelessWidget {
  final bool ratTot;
  final double size;
  const IconNgayRatTotXauWidget(
      {Key? key, required this.ratTot, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: ratTot ? ThemeColor.darkYellow : ThemeColor.blue3),
    );
  }
}
