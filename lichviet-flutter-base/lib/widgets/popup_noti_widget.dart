import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';

class PopupNotiWidget extends StatelessWidget {
  final String title;
  final String? content;
  final String icon;
  final String? buttonTitle;
  final Function()? onTapButton;
  const PopupNotiWidget({
    Key? key,
    required this.title,
    this.content,
    required this.icon,
    this.buttonTitle,
    this.onTapButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenUtil().screenHeight,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: (() => Navigator.pop(context)),
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
                      onTap: (() => Navigator.pop(context)),
                      child: SvgPicture.asset(IconBaseConstants.icCancel))),
            ),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.w),
                child: Container(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, left: 20.w, right: 20.w),
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
                      Text(
                        title.toUpperCase(),
                        style: ThemeStyles.small.copyWith(
                            color: const Color(0xff666666),
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        content ??
                            'Lỗi hệ thống hoặc kết nối mạng. Vui lòng thử lại.',
                        textAlign: TextAlign.center,
                        style: ThemeStyles.small.copyWith(
                            color: const Color(0xff333333),
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      if (buttonTitle != null)
                        InkWell(
                          onTap: onTapButton,
                          child: Container(
                            width: 200.w,
                            decoration: BoxDecoration(
                                color: const Color(0xff3F85FB),
                                borderRadius: BorderRadius.circular(30.w)),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            child: Center(
                              child: Text(
                                buttonTitle!.toUpperCase(),
                                style: ThemeStyles.small500
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 18.h,
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                  child: Align(
                      alignment: Alignment.topCenter,
                      child: SvgPicture.asset(
                        icon,
                        height: 80.w,
                        width: 80.w,
                      )))
            ],
          ),
          Expanded(
            child: InkWell(
                onTap: (() => Navigator.pop(context)),
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
