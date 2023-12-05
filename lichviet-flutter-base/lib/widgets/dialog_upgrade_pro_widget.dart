import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';

class DialogUpgradeProWidget extends StatelessWidget {
  final String icon;
  final String title;
  final String content;
  final String buttonContent;
  final Function() onTapButton;
  final bool dimissClose;
  const DialogUpgradeProWidget({
    Key? key,
    required this.icon,
    required this.title,
    required this.content,
    required this.buttonContent,
    required this.onTapButton,
    this.dimissClose = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        dimissClose
            ? Expanded(
                child: Container(
                alignment: Alignment.topRight,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top > 0
                        ? MediaQuery.of(context).padding.top
                        : 20.h,
                    right: 16.w),
              ))
            : Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                      alignment: Alignment.topRight,
                      height: double.infinity,
                      width: double.infinity,
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top > 0
                              ? MediaQuery.of(context).padding.top
                              : 20.h,
                          right: 16.w),
                      child: SvgPicture.asset(IconBaseConstants.icCancel)),
                ),
              ),
        Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 40.w),
              child: Container(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 20.h, bottom: 20.h),
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
                          color: const Color(0xff999999),
                          fontWeight: FontWeight.w700),
                    ),
                    Container(
                      height: 0.25,
                      color: const Color(0xffCDCED3),
                      margin: EdgeInsets.only(top: 16.h, bottom: 12.h),
                    ),
                    Text(
                      content,
                      style: ThemeStyles.small400.copyWith(height: 1.6),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    InkWell(
                      onTap: onTapButton,
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xff3F85FB),
                            borderRadius: BorderRadius.circular(30.w)),
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 8.h),
                        child: Text(
                          buttonContent.toUpperCase(),
                          style: ThemeStyles.small500
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 12.h,
                    // ),
                  ],
                ),
              ),
            ),
            Positioned.fill(
                child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      padding: const EdgeInsets.all(2),
                      child: Image.asset(
                        icon,
                        height: 80.w,
                        width: 80.w,
                      ),
                    )))
          ],
        ),
        Expanded(
          child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const SizedBox(
                width: double.infinity,
                height: double.infinity,
              )),
        )
      ],
    );
  }
}
