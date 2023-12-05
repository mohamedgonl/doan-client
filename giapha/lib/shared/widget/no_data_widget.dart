import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/shared/widget/image.dart';

import 'button_shared.dart';

class NoDataWidget extends StatelessWidget {
  final String content;
  final String? titleButton;
  final Function()? onClickButton;
  const NoDataWidget({
    super.key,
    required this.content,
    this.titleButton,
    this.onClickButton,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: 64.h,
            ),
            imageFromLocale(
                url: ImageConstants.imgDanhSachEmpty, fit: BoxFit.contain),
            SizedBox(
              height: 30.h,
            ),
            Text(
              content,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            ),
            SizedBox(
              height: 96.h,
            ),
            if (titleButton != null)
              ButtonShared(
                onClickButton: onClickButton ?? () {},
                title: titleButton!,
                widthButton: 230.w,
              ),
          ],
        ),
      ),
    );
  }
}
