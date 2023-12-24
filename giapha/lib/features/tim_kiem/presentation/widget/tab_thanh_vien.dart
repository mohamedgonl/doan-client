// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/no_data_widget.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class TabThanhVien extends StatefulWidget {
  final List<UserInfo>? listResult;
  final Function(String)? onClickSearchRecent;
  final List<String> listTextRecent;
  final String giaPhaId;

  const TabThanhVien({
    super.key,
    this.listResult,
    this.onClickSearchRecent,
    required this.giaPhaId,
    this.listTextRecent = const [],
  });

  @override
  State<TabThanhVien> createState() => _TabThanhVienState();
}

class _TabThanhVienState extends State<TabThanhVien> {
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
                                return ItemMemberResult(
                                    giaPhaId: widget.giaPhaId,
                                    member: widget.listResult![index]);
                              }),
                        ),
                      )
                    ]),
              )
            : const NoDataWidget(
                content: "Không tìm thấy thành viên nào trong gia phả")
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

class ItemMemberResult extends StatefulWidget {
  final String giaPhaId;
  final UserInfo member;
  const ItemMemberResult({
    Key? key,
    required this.giaPhaId,
    required this.member,
  }) : super(key: key);

  @override
  State<ItemMemberResult> createState() => ItemMemberResultState();
}

class ItemMemberResultState extends State<ItemMemberResult> {
  late UserInfo memberInfo;

  @override
  void initState() {
    super.initState();
    memberInfo = widget.member;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final info = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => quanLyThanhVienBuilder(context, false,
                    widget.giaPhaId, null, null, null, memberInfo)));
        if (info != null && info is UserInfo) {
          setState(() {
            memberInfo = info;
          });
        }
      },
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: 16.h, left: 20.w, right: 16.w, bottom: 15.5.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 36.w,
                  height: 36.w,
                  child: memberInfo.avatar != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(33.w),
                          child: (memberInfo.avatar != null
                              ? CachedNetworkImage(
                                  imageUrl: ImageNetworkUtils.getNetworkUrl(
                                      url: memberInfo.avatar!),
                                  fit: BoxFit.cover,
                                  errorWidget: (context, _, __) => Image.asset(
                                      ImageConstants.imgDefaultAvatar),
                                  placeholder: (context, _) => imageFromLocale(
                                      url: ImageConstants.imgDefaultAvatar),
                                )
                              : imageFromLocale(
                                  url: ImageConstants.imgDefaultAvatar)))
                      : imageFromLocale(url: ImageConstants.imgDefaultAvatar),
                ),
                SizedBox(
                  width: 23.w,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              memberInfo.ten ?? "",
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium!
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                          Container(
                            width: 46.w,
                            height: 21.w,
                            decoration: BoxDecoration(
                                color:
                                    widget.member.gioiTinh == GioiTinhConst.nam
                                        ? const Color(0xffE7F3FE)
                                        : const Color(0xffFFDBCB),
                                borderRadius: BorderRadius.circular(10.5)),
                            child: Center(
                              child: Text(
                                memberInfo.gioiTinh == GioiTinhConst.nam
                                    ? "Nam"
                                    : "Nữ",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall!
                                    .copyWith(
                                        color: widget.member.gioiTinh ==
                                                GioiTinhConst.nam
                                            ? const Color(0xff1763CF)
                                            : const Color(0xffD97459)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      if (memberInfo.ngaySinh.isNotNullOrEmpty)
                        Container(
                          padding: EdgeInsets.only(bottom: 2.h),
                          child: Text(
                            DateTimeShared.dateTimeToStringDefault1(
                                DateTimeShared.formatStringReverseToDate8(
                                    memberInfo.ngaySinh!)),
                            style: Theme.of(context).primaryTextTheme.bodySmall,
                          ),
                        ),
                      if (memberInfo.diaChiHienTai.isNotNullOrEmpty)
                        Text(
                          memberInfo.diaChiHienTai ?? "",
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
