import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ThemeDataShared {
  static ThemeData themeMain = ThemeData(
      primarySwatch: Colors.blue,
      fontFamily: 'SFUIText',
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: const Color(0xff005CAC),
        iconTheme: const IconThemeData(
          color: Color(0xffffffff),
        ),
        titleTextStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w600),
        actionsIconTheme:
            IconThemeData(color: const Color(0xffffffff), size: 25.w),
      ),
      tabBarTheme: TabBarTheme(
          labelStyle: TextStyle(
            fontFamily: "SFUIText",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          labelColor: const Color(0xff3F85FB),
          unselectedLabelStyle: TextStyle(
            fontFamily: "SFUIText",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelColor: const Color(0xffB2BCC8),
          overlayColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.white)),
      scaffoldBackgroundColor: const Color(0xffFBFBFB),
      primaryTextTheme: TextTheme(
        titleLarge: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff333333)),
        titleMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff333333)),
        titleSmall: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff333333)),
        displayLarge: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333)),
        displayMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333)),
        displaySmall: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff333333)),
        bodyLarge: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff333333)),
        bodyMedium: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff333333)),
        bodySmall: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff333333)),
      ),
      dividerTheme: const DividerThemeData(
        color: Color(0xffE5E5E5),
        thickness: 0.25,
      ));
}
