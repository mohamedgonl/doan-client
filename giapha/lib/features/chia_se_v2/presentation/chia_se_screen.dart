import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/chia_se_v2/presentation/widget/menu_chia_se_widget.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/widget/dropdownlist_shared.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/option_widget.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';

class ChiaSeScreen2 extends StatefulWidget {
  const ChiaSeScreen2({super.key});

  @override
  State<ChiaSeScreen2> createState() => _ChiaSeScreen2State();
}

class _ChiaSeScreen2State extends State<ChiaSeScreen2> {
  List<MemberInfo> peoplePicked = [
    MemberInfo(ten: "People 1", soDienThoai: "085528484515484"),
    MemberInfo(ten: "People 2", soDienThoai: "18408"),
    MemberInfo(ten: "People 3", soDienThoai: "40644984894"),
  ];
  List<MemberInfo> peopleShared = [
    MemberInfo(ten: "People 4", soDienThoai: "085528484515484"),
    MemberInfo(ten: "People 5", soDienThoai: "18408"),
    MemberInfo(ten: "People 6", soDienThoai: "40644984894"),
  ];

  final ValueNotifier<int> quyenHanSelector = ValueNotifier(0);
  final ValueNotifier<int> quyenTruyCapChungSelector = ValueNotifier(0);
  final ValueNotifier<List<MemberInfo>> danhSachNguoiDuocChonNotifier =
      ValueNotifier([]);

  final ValueNotifier<bool> showMenuChonQuyen = ValueNotifier(false);

  double paddingTopClick = 0;

  bool showDanhSachDuocChiaSe = true;

  @override
  void initState() {
    danhSachNguoiDuocChonNotifier.value = peoplePicked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chia sẻ"),
        leading: AcAppBarButton.custom(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            child: SvgPicture.asset(
              IconConstants.icBack,
              fit: BoxFit.cover,
              height: 19.h,
              width: 10.w,
              color: Colors.white,
            )),
      ),
      body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
              child: Stack(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // main
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, top: 16.h, bottom: 15.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Chọn người dùng để chia sẻ',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              ?.copyWith(
                                  color: const Color.fromRGBO(0, 92, 172, 1))),
                      SizedBox(height: 16.h),
                      // Search Input
                      Padding(
                        padding: EdgeInsets.only(right: 8.w),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            // Search Input field
                            Expanded(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                    left: 12.w,
                                    top: 9.h,
                                    bottom: 10.h,
                                    right: 12.w,
                                  ),
                                  fillColor:
                                      const Color.fromRGBO(239, 242, 245, 1),
                                  hintText: "Nhập mã chia sẻ",
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(118, 118, 118, 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            // Icon danh bạ
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: SvgPicture.asset(
                                  IconConstants.icDanhBa,
                                  height: 28.h,
                                  width: 22.75.w,
                                  fit: BoxFit.fill,
                                  // package: PackageName.namePackageAddImage
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // danh sách người được chọn từ search field
                      ValueListenableBuilder(
                        valueListenable: danhSachNguoiDuocChonNotifier,
                        builder: (context, value, child) => ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => Divider(
                            height: 0,
                            thickness: 1.h,
                            color: const Color(0xffE5E5E5),
                          ),
                          itemCount: peoplePicked.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              minLeadingWidth: 0,
                              contentPadding: EdgeInsets.zero,
                              isThreeLine: true,
                              leading: SizedBox(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(18.r),
                                  child: peoplePicked[index].avatar == null
                                      ? SvgPicture.asset(
                                          IconConstants.icDefaultAvatar)
                                      : imageFromNetWork(
                                          url: peoplePicked[index].avatar!,
                                          height: 36.h,
                                          width: 36.w),
                                ),
                              ),
                              title: Text(peoplePicked[index].ten ?? ""),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child:
                                    Text(peoplePicked[index].soDienThoai ?? ""),
                              ),
                              trailing: Padding(
                                padding: EdgeInsets.only(right: 12.w),
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      danhSachNguoiDuocChonNotifier.value
                                          .remove(peoplePicked[index]);
                                    });
                                  },
                                  constraints: BoxConstraints(
                                    minHeight: 20.h,
                                    minWidth: 20.w,
                                  ),
                                  icon: SvgPicture.asset(
                                    IconConstants.icDeleteChoice,
                                    height: 20.h,
                                    width: 20.w,
                                    fit: BoxFit.cover,
                                    // package: PackageName.namePackageAddImage,
                                  ),
                                ),
                              ),
                              minVerticalPadding: 12.5.h,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.h,
                  color: const Color.fromRGBO(229, 229, 229, 1),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, top: 10.h, bottom: 15.5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Quyền hạn',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              ?.copyWith(
                                  color: const Color.fromRGBO(0, 92, 172, 1))),
                      ValueListenableBuilder(
                        valueListenable: quyenHanSelector,
                        builder: (context, value, child) {
                          return OptionWidget(
                              indexSelected: quyenHanSelector.value,
                              onTap: (value) {
                                setState(() {
                                  quyenHanSelector.value = value;
                                });
                              },
                              listOption: const [
                                "Người xem",
                                "Người chỉnh sửa"
                              ]);
                        },
                      ),
                      SizedBox(height: 18.h),
                      if (quyenHanSelector.value == 1)
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: DropDownListShared(
                            borderRadius: 6.r,
                            items:
                                ["Nhánh 1", "Nhánh 2", "Nhánh 3"].map((nhanh) {
                              return DropdownMenuItem(
                                value: nhanh,
                                child: Text(nhanh),
                              );
                            }).toList(),
                            title: "",
                            noPrefixIcon: true,
                            hintText: "Chọn nhánh cho phép chỉnh sửa",
                            pathIcon: "",
                            paddingBottom: 0.h,
                            enabled: true,
                            onChanged: (nhanh) {},
                          ),
                        )
                    ],
                  ),
                ),
                const CustomDivider(),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, top: 12.5.h, right: 23.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Đã chia sẻ với',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .titleSmall
                              ?.copyWith(
                                  color: const Color.fromRGBO(0, 92, 172, 1))),
                      Transform.rotate(
                        angle: showDanhSachDuocChiaSe ? 0 : math.pi,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              showDanhSachDuocChiaSe = !showDanhSachDuocChiaSe;
                            });
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: SvgPicture.asset(
                            IconConstants.iicButtonMoreBlue,
                            fit: BoxFit.contain,
                            // package: PackageName.namePackageAddImage,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1.h,
                  color: const Color.fromRGBO(229, 229, 229, 1),
                ),
                // danh sách người dùng đã được chia sẻ
                Visibility(
                  maintainState: true,
                  visible: showDanhSachDuocChiaSe,
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => Divider(
                        height: 0,
                        thickness: 1.h,
                        color: const Color(0xffE5E5E5),
                      ),
                      itemCount: peoplePicked.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          minLeadingWidth: 0,
                          contentPadding: EdgeInsets.zero,
                          isThreeLine: true,
                          leading: SizedBox(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18.r),
                              child: peoplePicked[index].avatar == null
                                  ? SvgPicture.asset(
                                      IconConstants.icDefaultAvatar)
                                  : imageFromNetWork(
                                      url: peoplePicked[index].avatar!,
                                      height: 36.h,
                                      width: 36.w),
                            ),
                          ),
                          title: Text(peoplePicked[index].ten ?? ""),
                          subtitle: Padding(
                            padding: EdgeInsets.only(top: 4.h),
                            child: Text(peoplePicked[index].soDienThoai ?? ""),
                          ),
                          trailing: GestureDetector(
                            // Ấn hiện menu
                            onTapUp: (tapDetail) {
                              setState(() {
                                paddingTopClick = tapDetail.globalPosition.dy -
                                    tapDetail.localPosition.dy;
                                showMenuChonQuyen.value =
                                    !showMenuChonQuyen.value;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 12.w),
                              child: Container(
                                // width: 114.w,
                                padding: EdgeInsets.symmetric(horizontal: 12.w),
                                height: 22.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            178, 188, 200, 1),
                                        width: 1.w),
                                    borderRadius:
                                        BorderRadius.circular(10.5.r)),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      peopleShared[index].trangThai ??
                                          "Người sửa",
                                      style: Theme.of(context)
                                          .tabBarTheme
                                          .labelStyle
                                          ?.copyWith(
                                              color: const Color.fromRGBO(
                                                  118, 118, 118, 1),
                                              fontSize: 13.sp),
                                    ),
                                    SizedBox(width: 10.w),
                                    SvgPicture.asset(
                                      IconConstants.icButtonMore,
                                      // color: Colors.amber,
                                      // height: 6.86.h,
                                      width: 12.w,
                                      // package: PackageName.namePackageAddImage,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          minVerticalPadding: 12.5.h,
                        );
                      },
                    ),
                  ),
                ),

                // Quyền truy cập chung
                CustomDivider(hasFirstDivider: showDanhSachDuocChiaSe),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, top: 12.5.h, bottom: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Quyền truy cập chung',
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color:
                                          const Color.fromRGBO(0, 92, 172, 1))),
                          Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Container(
                              // width: 114.w,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              height: 22.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromRGBO(
                                          178, 188, 200, 1),
                                      width: 1.w),
                                  borderRadius: BorderRadius.circular(10.5.r)),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Người sửa",
                                    style: Theme.of(context)
                                        .tabBarTheme
                                        .labelStyle
                                        ?.copyWith(
                                            color: const Color.fromRGBO(
                                                118, 118, 118, 1),
                                            fontSize: 13.sp),
                                  ),
                                  SizedBox(width: 10.w),
                                  SvgPicture.asset(
                                    IconConstants.icButtonMore,
                                    // color: Colors.amber,
                                    // height: 6.86.h,
                                    width: 12.w,
                                    // package: PackageName.namePackageAddImage,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 11.h),
                      // text view
                      ValueListenableBuilder(
                        valueListenable: quyenTruyCapChungSelector,
                        builder: (context, value, child) {
                          return Text(
                            "Bất kỳ ai có kết nối Internet & có đường liên kết này đều có thể ${quyenTruyCapChungSelector.value == 0 ? "xem" : "chỉnh sửa"} gia phả.",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: const Color.fromRGBO(51, 51, 51, 1),
                                ),
                          );
                        },
                      ),
                      SizedBox(height: 16.h),
                      // quyền truy cập chung buttons
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(255, 255, 255, 1),
                                fixedSize: Size(180.w, 42.h),
                                onPrimary:
                                    const Color.fromRGBO(63, 133, 251, 1),
                                side: BorderSide(
                                    color:
                                        const Color.fromRGBO(229, 229, 229, 1),
                                    width: 0.5.w)),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              IconConstants.icCopyLink,
                              // package: PackageName.namePackageAddImage,
                            ),
                            label: Text(
                              'Sao chép liên kết',
                              style: Theme.of(context)
                                  .tabBarTheme
                                  .labelStyle
                                  ?.copyWith(
                                      color:
                                          const Color.fromRGBO(51, 51, 51, 1)),
                            ),
                          ),
                          SizedBox(width: 22.w),
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                alignment: Alignment.centerLeft,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                backgroundColor:
                                    const Color.fromRGBO(63, 133, 251, 1),
                                fixedSize: Size(180.w, 42.h),
                                side: BorderSide(
                                    color:
                                        const Color.fromRGBO(229, 229, 229, 1),
                                    width: 0.5.w)),
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              IconConstants.icDoneButton,
                              // package: PackageName.namePackageAddImage,
                            ),
                            label: Padding(
                              padding: EdgeInsets.only(left: 18.w),
                              child: Text(
                                'Hoàn tất',
                                style: Theme.of(context)
                                    .tabBarTheme
                                    .labelStyle
                                    ?.copyWith(
                                        color: const Color.fromRGBO(
                                            255, 255, 255, 1)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            ValueListenableBuilder(
                valueListenable: showMenuChonQuyen,
                builder: (context, _, __) {
                  if (showMenuChonQuyen.value) {
                    return MenuChiaSeWidget(
                      onClickBarrier: () {
                        showMenuChonQuyen.value = !showMenuChonQuyen.value;
                      },
                      paddingTop:
                          paddingTopClick - ThemeLayouts.appBarHeight + 15.h,
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
          ]))),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final bool hasFirstDivider;
  const CustomDivider({super.key, this.hasFirstDivider = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hasFirstDivider)
          Divider(
            thickness: 1.h,
            color: const Color.fromRGBO(229, 229, 229, 1),
            height: 0,
          ),
        Container(
          height: 10.h,
          color: Colors.white10,
        ),
        Divider(
          thickness: 1.h,
          height: 0,
          color: const Color.fromRGBO(229, 229, 229, 1),
        ),
      ],
    );
  }
}
