import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';


class MenuCustomPaint extends CustomPainter {
  final double paddingTop;
  final double? paddingLeft;
  final double? paddingRight;
  final double? paddingRightClick;
  final double popupHeight;

  MenuCustomPaint({
    required this.popupHeight,
    required this.paddingTop,
    this.paddingLeft,
    this.paddingRight,
    this.paddingRightClick,
  });
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();
    final paddingRClick = (paddingRightClick != null
        ? (paddingRightClick! - (paddingRight ?? 9.w)) - 14
        : 25.w);
    final positionL = paddingLeft ?? 220.w;
    final positionR = paddingRight ?? 9.w;

    if (paddingTop + ThemeLayouts.appBarHeight + popupHeight + 20.h + 35.h >
        ScreenUtil().screenHeight) {
      path.moveTo(positionL, -8 + paddingTop - 70.h);
      path.arcToPoint(Offset(positionL + 8, paddingTop - 70.h),
          radius: const Radius.circular(8), clockwise: false);

      path.lineTo(ScreenUtil().screenWidth - positionR - paddingRClick - 28,
          0 + paddingTop - 70.h);
      path.lineTo(ScreenUtil().screenWidth - positionR - paddingRClick - 14,
          20.h + paddingTop - 70.h);
      path.lineTo(ScreenUtil().screenWidth - positionR - paddingRClick,
          0 + paddingTop - 70.h);
      path.lineTo(
          ScreenUtil().screenWidth - positionR - 8, 0 + paddingTop - 70.h);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - positionR, -8 + paddingTop - 70.h),
          radius: const Radius.circular(8),
          clockwise: false);
      path.lineTo(ScreenUtil().screenWidth - positionR,
          -popupHeight + paddingTop - 70.h);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - positionR - 8,
              -popupHeight + -8 + paddingTop - 70.h),
          radius: const Radius.circular(8),
          clockwise: false);
      path.lineTo(positionL + 8, -popupHeight - 8 + paddingTop - 70.h);
      path.arcToPoint(Offset(positionL, -popupHeight + paddingTop - 70.h),
          radius: const Radius.circular(8), clockwise: false);
      path.lineTo(positionL, 8 + paddingTop - 70.h);
      path.fillType = PathFillType.evenOdd;
      canvas.drawPath(path, Paint());
      canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 1
            ..color = Colors.white);
    } else {
      path.moveTo(positionL, 8 + paddingTop);
      path.arcToPoint(Offset(positionL + 8, paddingTop),
          radius: const Radius.circular(8));

      path.lineTo(ScreenUtil().screenWidth - positionR - paddingRClick - 28,
          0 + paddingTop);
      path.lineTo(ScreenUtil().screenWidth - positionR - paddingRClick - 14,
          -20.h + paddingTop);
      path.lineTo(
          ScreenUtil().screenWidth - positionR - paddingRClick, 0 + paddingTop);
      path.lineTo(ScreenUtil().screenWidth - positionR - 8, 0 + paddingTop);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - positionR, 8 + paddingTop),
          radius: const Radius.circular(8));
      path.lineTo(
          ScreenUtil().screenWidth - positionR, popupHeight + paddingTop);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - positionR - 8,
              popupHeight + 8 + paddingTop),
          radius: const Radius.circular(8));
      path.lineTo(positionL + 8, popupHeight + 8 + paddingTop);
      path.arcToPoint(Offset(positionL, popupHeight + paddingTop),
          radius: const Radius.circular(8));
      path.lineTo(positionL, 8 + paddingTop);
      path.fillType = PathFillType.evenOdd;
      canvas.drawPath(path, Paint());
      canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 1
            ..color = Colors.white);
    }
  }

  @override
  bool shouldRepaint(MenuCustomPaint oldDelegate) {
    return false;
  }
}
