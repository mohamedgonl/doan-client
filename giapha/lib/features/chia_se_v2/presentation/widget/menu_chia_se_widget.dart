import 'package:flutter_svg/svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
import 'package:giapha/shared/widget/option_widget.dart';

import 'menu_chia_se_custom_paint.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';

class MenuChiaSeWidget extends StatelessWidget {
  final double paddingTop;
  final Function() onClickBarrier;

  const MenuChiaSeWidget({
    super.key,
    required this.paddingTop,
    required this.onClickBarrier,
  });

  @override
  Widget build(BuildContext context) {
    final popUpHeight = 90.h;
    return InkWell(
      onTap: onClickBarrier,
      child: Container(
        width: ScreenUtil().screenWidth,
        height: ScreenUtil().screenHeight,
        color: Colors.black.withOpacity(0.15),
        child: CustomPaint(
          painter: MenuChiaSeCustomPaint(
              popupHeight: popUpHeight, positionTop: paddingTop - 10.h),
          child: Padding(
            padding: EdgeInsets.only(
                left: 220.w,
                top: (paddingTop -
                            10.h +
                            ThemeLayouts.appBarHeight +
                            popUpHeight +
                            20.h +
                            35.h >
                        ScreenUtil().screenHeight)
                    ? (paddingTop - 88.h - popUpHeight)
                    : paddingTop - 10.h),
            child: Column(
              children: [
                OptionWidget(
                    verticalDirection: true,
                    indexSelected: 1,
                    onTap: (p0) {},
                    listOption: const ["Người xem", "Người chỉnh sửa"]),
                Divider(
                  thickness: 1.h,
                  color: const Color.fromRGBO(229, 229, 229, 1),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      fixedSize: Size(172.w, 42.h),
                      onPrimary: const Color.fromRGBO(63, 133, 251, 1),
                      side: BorderSide(
                          color: const Color.fromRGBO(229, 229, 229, 1),
                          width: 0.5.w)),
                  onPressed: () {
                    DialogShared.showDialogSelect(
                      context,
                      'Bạn có chắc chắn muốn xoá quyền của người này?',
                      textAlign: TextAlign.center,
                      leftButton: "Có",
                      onTapLeftButton: () {
                        // Remove the box
                      },
                      rightButton: "Không",
                      onTapRightButton: () {},
                      rootNavigate: true,
                    );
                  },
                  icon: SvgPicture.asset(
                    IconConstants.icTrash,
                    // package: PackageName.namePackageAddImage,
                  ),
                  label: Text(
                    'Xoá quyền',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
