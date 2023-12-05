import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lichviet_flutter_base/core/constants/image_base_constants.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';
import 'package:lichviet_flutter_base/widgets/image.dart';

class EmptyDataWidget extends StatelessWidget {
  const EmptyDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imageFromLocale(url: ImageBaseConstants.imgNoData, height: 165.w, width: 282.w),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Không có dữ liệu.',
            style: ThemeStyles.medium600.copyWith(color: Colors.black),
          ),
        ],
      ),
    );
  }
}
