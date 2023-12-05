import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';
// using for common text styles and some special styles

class ThemeStyles {
  static const String fontSFUIDisplay = "SFUIDisplay";
  static const String fontSFUIText = "SFUIText";
  static const String fontMulish = "Mulish";
  static const String fontSmoothy = "Smoothy";
  // common
  static TextStyle superTiny = TextStyle(fontSize: 10.sp);
  static TextStyle superTiny500 =
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w500);
  static TextStyle superTiny400 =
      TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400);

  static TextStyle mediumTiny600 =
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600);

  static TextStyle mediumTiny500 =
      TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500);

  static TextStyle tiny = TextStyle(fontSize: 12.sp);
  static TextStyle tiny500 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500);
  static TextStyle tiny400 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle tiny600 =
      TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600);
  static TextStyle tiny600White = TextStyle(
      fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.white);

  static TextStyle small = TextStyle(fontSize: 14.sp);
  static TextStyle small400 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle small500 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500);
  static TextStyle small600 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);
  static TextStyle small700 =
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w700);

  static TextStyle medium = TextStyle(fontSize: 16.sp);
  static TextStyle medium500 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500);
  static TextStyle medium600 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle medium400 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400);
  static TextStyle medium700 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700);
  static TextStyle medium800 =
      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w800);

  static TextStyle medium600Black = TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      color: ThemeColor.darkBlack);

  static TextStyle big = TextStyle(fontSize: 18.sp);
  static TextStyle big400 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400);
  static TextStyle big500 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);
  static TextStyle big600 =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600);

  static TextStyle veryBig600 =
      TextStyle(fontSize: 35.sp, fontWeight: FontWeight.w600);

  static TextStyle big600PrimaryColor = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: ThemeColor.primary);

  static TextStyle big600ColorText3 = TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w600, color: ThemeColor.text3);

  static TextStyle extra = TextStyle(fontSize: 20.sp);
  static TextStyle extra500 =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500);
  static TextStyle extra600 =
      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600);

  static TextStyle extraBig =
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500);
  static TextStyle extraBig600 =
      TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600);

  // app bar
  static TextStyle appBar =
      TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500);

  // input text stype
  static TextStyle input = TextStyle(fontSize: 15.sp, color: ThemeColor.text);
  static TextStyle inputPlaceholder =
      TextStyle(fontSize: 15.sp, color: ThemeColor.placeholder);

  // button
  static TextStyle button = TextStyle(
      fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white);

  // bottom navigation
  static TextStyle get bottomNavigationLabelStyle => TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w500,
      );
  // top snack bar
  static TextStyle get topSnackBarStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      );

  // dialog action button
  static TextStyle get dialogTitleStyle => TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get dialogMessageStyle => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      );

  static TextStyle get dialogActionButtonStyle => TextStyle(
        fontSize: 15.sp,
        fontWeight: FontWeight.w500,
      );
  static TextStyle textHintSmallGrey = TextStyle(
    fontSize: 12.sp,
    color: ThemeColor.darkGrey,
    fontWeight: FontWeight.w500,
  );
  static TextStyle textHintBigGrey = TextStyle(
    fontSize: 14.sp,
    color: ThemeColor.darkGrey,
    fontWeight: FontWeight.w600,
  );
  static TextStyle textSmallHintBigGrey500 = TextStyle(
    fontSize: 12.sp,
    color: ThemeColor.darkGrey500,
    fontWeight: FontWeight.w500,
  );
  static TextStyle textHintBigGrey500 = TextStyle(
    fontSize: 14.sp,
    color: ThemeColor.darkGrey500,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bigTextGrey = TextStyle(
    fontSize: 18.sp,
    color: ThemeColor.text2,
    fontWeight: FontWeight.w600,
  );

  static TextStyle textMeidum = TextStyle(
    fontSize: 12.sp,
    color: ThemeColor.text2,
    fontWeight: FontWeight.w500,
  );

  static TextStyle textMeidum600Blue = TextStyle(
    fontSize: 14.sp,
    color: ThemeColor.blueBoder,
    fontWeight: FontWeight.w600,
  );
}
