import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/shared/widget/image.dart';

class ErrorCommonWidget extends StatelessWidget {
  final String content;
  const ErrorCommonWidget({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageFromLocale(url: ImageConstants.imgNoData, height: 165.w, width: 282.w),
          SizedBox(
            height: 20.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: Theme.of(context).primaryTextTheme.titleMedium!.copyWith(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
