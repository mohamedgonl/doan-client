import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/theme/theme_color.dart';
import 'package:giapha/core/theme/theme_styles.dart';
import 'package:giapha/shared/widget/image.dart';


class DialogPopupWidget extends StatelessWidget {
  final String title;
  final String? content;
  final String icon;
  final Widget? widgetRichText;
  final Widget? buttonWidget;
  final TextAlign? textAlign;
  const DialogPopupWidget(
      {Key? key,
      required this.title,
      this.content,
      this.widgetRichText,
      required this.icon,
      required this.buttonWidget,
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: (() {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                Navigator.pop(context);
              }),
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top > 0
                          ? MediaQuery.of(context).padding.top
                          : 20.h,
                      right: 16.w),
                  child: InkWell(
                      onTap: (() {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        Navigator.pop(context);
                      }),
                      child: SvgPicture.asset(IconConstants.icCancel))),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.w),
                child: Container(
                  padding: EdgeInsets.only(
                    top: 20.h,
                    bottom: 20.h,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.sp)),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 24.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: ThemeStyles.medium400.copyWith(
                              color: ThemeColor.blue,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: widgetRichText != null
                            ? widgetRichText!
                            : Text(
                                content ??
                                    'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.',
                                textAlign: textAlign,
                                maxLines: 10,
                                style: ThemeStyles.medium400.copyWith(
                                    color: const Color(0xff333333),
                                    fontWeight: FontWeight.w400),
                              ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      if (buttonWidget != null) ...[
                        buttonWidget!,
                      ]
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: imageFromLocale(
                        url: IconConstants.icWarningV2,
                        height: 80.w,
                        width: 80.w,
                      )))
            ],
          ),
          Expanded(
            child: InkWell(
                onTap: (() {
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  Navigator.pop(context);
                }),
                child: const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                )),
          )
        ],
      ),
    );
  }
}
