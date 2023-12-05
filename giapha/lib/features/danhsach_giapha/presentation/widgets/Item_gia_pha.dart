import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/tu_duong/presentation/tu_duong_screen.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/widget/image.dart';

class ItemGiaPha extends StatefulWidget {
  final GiaPha giaPha;
  final Function()? onClick;
  final Function(TapUpDetails) onClickMore;
  const ItemGiaPha(
      {super.key,
      required this.onClick,
      required this.onClickMore,
      required this.giaPha});

  @override
  State<ItemGiaPha> createState() => _ItemGiaPhaState();
}

class _ItemGiaPhaState extends State<ItemGiaPha> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: const Color(0xffD8D8D8),
            ),
            borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        margin: EdgeInsets.only(bottom: 10.h),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.giaPha.tenGiaPha,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleMedium!
                        .copyWith(color: const Color(0xff333333)),
                  ),
                ),
                SizedBox(
                  width: 32.w,
                ),
                GestureDetector(
                  onTapUp: ((details) {
                    widget.onClickMore(details);
                  }),
                  child: imageFromLocale(url: IconConstants.icMore),
                )
              ],
            ),
            SizedBox(
              height: 8.h,
            ),
            itemInfor(
                pathIcon: IconConstants.icPerson,
                title: '${widget.giaPha.soDoi} đời'),
            SizedBox(
              height: 4.h,
            ),
            itemInfor(
                pathIcon: IconConstants.icGroup,
                title: '${widget.giaPha.soThanhVien} thành viên'),
            SizedBox(
              height: 4.h,
            ),
            itemInfor(
              pathIcon: IconConstants.icPersonCreate,
              title: "Người tạo: ${widget.giaPha.tenNguoiTao}",
            ),
            SizedBox(
              height: 4.h,
            ),
            itemInfor(
                pathIcon: IconConstants.icClock,
                title: DateTimeShared.dateTimeToStringDefault1(
                    widget.giaPha.thoiGianTao)),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox.shrink(),
                Container(
                  width: 172.w,
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          width: 0.5, color: const Color(0xffE5E5E5)),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 1),
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.11),
                        )
                      ]),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return tuDuongBuilder(
                            context,
                            widget.giaPha,
                          );
                        },
                      ));
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: 16.w,
                        ),
                        imageFromLocale(
                            url: IconConstants.icNhaThoHo,
                            width: 25.w,
                            height: 30.w),
                        SizedBox(
                          width: 24.w,
                        ),
                        Text(
                          "Nhà thờ họ",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .displaySmall!
                              .copyWith(color: const Color(0xff333333)),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemInfor({required String pathIcon, required String title}) {
    return Row(
      children: [
        imageFromLocale(url: pathIcon),
        SizedBox(
          width: 16.w,
        ),
        Text(
          title,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .primaryTextTheme
              .bodySmall!
              .copyWith(color: const Color(0xff333333)),
        )
      ],
    );
  }
}
