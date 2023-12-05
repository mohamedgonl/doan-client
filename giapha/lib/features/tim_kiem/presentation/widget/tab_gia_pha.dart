import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/cay_gia_pha/presentation/cay_gia_pha_screen.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/no_data_widget.dart';

class TabGiaPha extends StatefulWidget {
  final List<GiaPhaModel>? listResult;
  final Function(String)? onClickSearchRecent;
  final List<String> listTextRecent;

  const TabGiaPha({
    super.key,
    this.listResult,
    this.onClickSearchRecent,
    this.listTextRecent = const [],
  });

  @override
  State<TabGiaPha> createState() => _TabGiaPhaState();
}

class _TabGiaPhaState extends State<TabGiaPha> {
  @override
  Widget build(BuildContext context) {
    return widget.listResult != null
        ? widget.listResult!.isNotEmpty
            ? Container(
                color: const Color(0xffFBFBFB),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Text(
                          "${widget.listResult!.length} kết quả",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .displaySmall!
                              .copyWith(color: const Color(0xff767676)),
                        ),
                      ),
                      const Divider(
                        thickness: 0.25,
                        height: 0.25,
                        color: Color(0xffCDCED3),
                      ),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: ListView.builder(
                              itemCount: widget.listResult!.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return MemBerResultItem(
                                    giaPha: widget.listResult![index]);
                              }),
                        ),
                      )
                    ]),
              )
            : const NoDataWidget(content: "Không tìm thấy gia phả nào")
        : widget.listTextRecent.isEmpty
            ? const NoDataWidget(content: "Chưa tìm kiếm gần đây")
            : Container(
                color: const Color(0xffFBFBFB),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        child: Text(
                          "Tìm kiếm gần đây",
                          style: Theme.of(context)
                              .primaryTextTheme
                              .displaySmall!
                              .copyWith(color: const Color(0xff767676)),
                        ),
                      ),
                      const Divider(
                        thickness: 0.25,
                        height: 0.25,
                        color: Color(0xffCDCED3),
                      ),
                      if (widget.listTextRecent.isNotEmpty)
                        Expanded(
                          child: Container(
                            color: Colors.white,
                            child: ListView.builder(
                                itemCount: widget.listTextRecent.length > 5
                                    ? 5
                                    : widget.listTextRecent.length,
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return itemSearchRecent(widget.listTextRecent[
                                      (widget.listTextRecent.length - 1) -
                                          index]);
                                }),
                          ),
                        )
                    ]),
              );
  }

  // Widget itemMemberResult(GiaPhaModel giaPha) {}

  Widget itemSearchRecent(String textRecent) {
    return InkWell(
      onTap: () {
        if (widget.onClickSearchRecent != null) {
          widget.onClickSearchRecent!(textRecent);
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.5.w),
        child: Row(
          children: [
            imageFromLocale(url: IconConstants.icClockV2),
            SizedBox(
              width: 24.w,
            ),
            Text(
              textRecent,
              style: Theme.of(context)
                  .primaryTextTheme
                  .bodyMedium!
                  .copyWith(color: Colors.black),
            )
          ],
        ),
      ),
    );
  }
}

class MemBerResultItem extends StatefulWidget {
  GiaPhaModel giaPha;
  MemBerResultItem({
    Key? key,
    required this.giaPha,
  }) : super(key: key);

  @override
  State<MemBerResultItem> createState() => _MemBerResultItemState();
}

class _MemBerResultItemState extends State<MemBerResultItem> {
  late GiaPhaModel giaPha;
  @override
  void initState() {
    giaPha = widget.giaPha;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        List<int> data = await Navigator.push(context,
            MaterialPageRoute(builder: ((context) {
          return cayGiaPhaBuilder(context, giaPha);
        })));
        setState(() {
          giaPha.soThanhVien = data[1].toString();
        });
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 16.h, left: 20.w, right: 16.w, bottom: 15.5.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffF0F1F5),
                  ),
                  child: Center(
                      child: imageFromLocale(url: IconConstants.icGiaPha)),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        giaPha.tenGiaPha,
                        style: Theme.of(context)
                            .primaryTextTheme
                            .displayMedium!
                            .copyWith(color: Colors.black),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        '${giaPha.soThanhVien} thành viên',
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            indent: 16.5.w,
            height: 1,
            thickness: 1,
            color: const Color(0xffE5E5E5),
          )
        ],
      ),
    );
  }
}
