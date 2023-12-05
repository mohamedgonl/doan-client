import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';

class IconNgayTotXauWidget extends StatelessWidget {
  final double size;
  final bool ngayTot;
  const IconNgayTotXauWidget(
      {Key? key, required this.size, required this.ngayTot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: Row(
        children: [
          Expanded(
              child: Container(
            width: double.infinity,
            height: size,
            decoration: BoxDecoration(
                color: const Color(0xff999999),
                borderRadius: ngayTot
                    ? BorderRadius.only(
                        topLeft: Radius.circular(size / 2),
                        bottomLeft: Radius.circular(size / 2))
                    : BorderRadius.circular(size / 2)),
          )),
          ngayTot
              ? Expanded(
                  child: Container(
                  width: double.infinity,
                  height: size,
                  decoration: BoxDecoration(
                      color: ngayTot
                          ? ThemeColor.darkYellow
                          : const Color(0xff999999),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(size / 2),
                          bottomRight: Radius.circular(size / 2))),
                ))
              : const SizedBox()
        ],
      ),
    );
  }
}
