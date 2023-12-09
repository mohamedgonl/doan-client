import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';

class MenuChiaSeCustomPaint extends CustomPainter {
  final double positionTop;
  final double popupHeight;

  MenuChiaSeCustomPaint({required this.popupHeight, required this.positionTop});
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    if (positionTop + ThemeLayouts.appBarHeight + popupHeight + 20.h + 35.h >
        ScreenUtil().screenHeight) {
      path.moveTo(220.w, -8 + positionTop - 70.h);
      path.arcToPoint(Offset(220.w + 8, positionTop - 70.h),
          radius: const Radius.circular(8), clockwise: false);

      path.lineTo(
          ScreenUtil().screenWidth - 9.w - 25.w - 28, 0 + positionTop - 70.h);
      path.lineTo(ScreenUtil().screenWidth - 9.w - 25.w - 14,
          20.h + positionTop - 70.h);
      path.lineTo(
          ScreenUtil().screenWidth - 9.w - 25.w, 0 + positionTop - 70.h);
      path.lineTo(ScreenUtil().screenWidth - 9.w - 8, 0 + positionTop - 70.h);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - 9.w, -8 + positionTop - 70.h),
          radius: const Radius.circular(8),
          clockwise: false);
      path.lineTo(
          ScreenUtil().screenWidth - 9.w, -popupHeight + positionTop - 70.h);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - 9.w - 8,
              -popupHeight + -8 + positionTop - 70.h),
          radius: const Radius.circular(8),
          clockwise: false);
      path.lineTo(220.w + 8, -popupHeight - 8 + positionTop - 70.h);
      path.arcToPoint(Offset(220.w, -popupHeight + positionTop - 70.h),
          radius: const Radius.circular(8), clockwise: false);
      path.lineTo(220.w, 8 + positionTop - 70.h);
      path.fillType = PathFillType.evenOdd;
      canvas.drawPath(path, Paint());
      canvas.drawPath(
          path,
          Paint()
            ..style = PaintingStyle.fill
            ..strokeWidth = 1
            ..color = Colors.white);
    } else {
      path.moveTo(220.w, 8 + positionTop);
      path.arcToPoint(Offset(220.w + 8, positionTop),
          radius: const Radius.circular(8));

      path.lineTo(ScreenUtil().screenWidth - 9.w - 25.w - 28, 0 + positionTop);
      path.lineTo(
          ScreenUtil().screenWidth - 9.w - 25.w - 14, -20.h + positionTop);
      path.lineTo(ScreenUtil().screenWidth - 9.w - 25.w, 0 + positionTop);
      path.lineTo(ScreenUtil().screenWidth - 9.w - 8, 0 + positionTop);
      path.arcToPoint(Offset(ScreenUtil().screenWidth - 9.w, 8 + positionTop),
          radius: const Radius.circular(8));
      path.lineTo(ScreenUtil().screenWidth - 9.w, popupHeight + positionTop);
      path.arcToPoint(
          Offset(ScreenUtil().screenWidth - 9.w - 8,
              popupHeight + 8 + positionTop),
          radius: const Radius.circular(8));
      path.lineTo(220.w + 8, popupHeight + 8 + positionTop);
      path.arcToPoint(Offset(220.w, popupHeight + positionTop),
          radius: const Radius.circular(8));
      path.lineTo(220.w, 8 + positionTop);
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
  bool shouldRepaint(MenuChiaSeCustomPaint oldDelegate) {
    return false;
  }
}
