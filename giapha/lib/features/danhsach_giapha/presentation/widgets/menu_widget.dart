import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
import 'package:giapha/shared/widget/image.dart';

import '../../../../shared/themes/theme_layouts.dart';
import 'menu_custom_paint.dart';

class MenuWidget extends StatelessWidget {
  final double paddingTop;
  final Function() onClickBarrier;
  final GiaPha giaPha;
  final Function() onClickDelete;
  final Function() onClickEdit;
  const MenuWidget(
      {super.key,
      required this.paddingTop,
      required this.onClickBarrier,
      required this.giaPha,
      required this.onClickDelete,
      required this.onClickEdit});

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
          painter: MenuCustomPaint(
            popupHeight: popUpHeight,
            paddingTop: paddingTop - 10.h,
          ),
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
                SizedBox(
                  height: 16.h,
                ),
                itemMenu(
                  context,
                  pathIcon: IconConstants.icSuaChucVu,
                  title: "Chỉnh sửa",
                  onClick: onClickEdit,
                ),
                itemMenu(context,
                    pathIcon: IconConstants.icXoaGiaPha,
                    title: "Xóa", onClick: () {
                  DialogShared.showDialogSelect(
                    context,
                    "Bạn có chắc chắn muốn xoá gia phả này không?",
                    textAlign: TextAlign.center,
                    leftButton: "Có",
                    onTapLeftButton: () {
                      onClickDelete();
                    },
                    rightButton: "Không",
                    onTapRightButton: () {},
                    rootNavigate: true,
                  );
                  // showDialog(
                  //     context: context,
                  //     builder: (context) => AlertDialog(
                  //           title: const Text("Xác nhận xoá"),
                  //           content: const Text(
                  //               "Bạn có chắc chắn muốn xoá gia phả này không?"),
                  //           actions: [
                  //             TextButton(
                  //                 onPressed: () {
                  //                   onClickDelete();
                  //                   Navigator.of(context).pop();
                  //                 },
                  //                 child: const Text("Có")),
                  //             TextButton(
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 },
                  //                 child: const Text("Không"))
                  //           ],
                  //         ));
                }),
                // itemMenu(context,
                //     pathIcon: IconConstants.icGhepGiaPha,
                //     title: "Ghép gia phả", onClick: () {
                //   Navigator.of(context)
                //       .push(MaterialPageRoute(builder: ((context) {
                //     return ghepGiaPhaBuilder(
                //       context,
                //       giaPha.id,
                //     );
                //   })));
                // }),
                // itemMenu(
                //   context,
                //   pathIcon: IconConstants.icShare,
                //   title: "Chia sẻ",
                //   onClick: () {
                //     Navigator.of(context)
                //         .push(MaterialPageRoute(builder: ((context) {
                //       return chiaSeBuilder(context, giaPha.id);
                //     })));
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget itemMenu(BuildContext context,
      {required String pathIcon,
      required String title,
      required void Function() onClick}) {
    return Container(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: () {
          onClick();
          onClickBarrier();
        },
        child: Row(
          children: [
            SizedBox(
              width: 18.w,
            ),
            imageFromLocale(url: pathIcon, width: 24.w, height: 24.w),
            SizedBox(
              width: 18.w,
            ),
            Text(
              title,
              style: Theme.of(context).primaryTextTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
