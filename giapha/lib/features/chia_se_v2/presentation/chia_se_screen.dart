import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/access/data/models/user_info.dart';

import 'package:giapha/features/chia_se_v2/presentation/bloc/share_bloc.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/widget/option_widget.dart';

Widget chiaSeBuilder(
  BuildContext context,
) =>
    BlocProvider(
        create: (context) => GetIt.I<ShareBloc>(),
        child: const ChiaSeScreen2());

class ChiaSeScreen2 extends StatefulWidget {
  const ChiaSeScreen2({super.key});

  @override
  State<ChiaSeScreen2> createState() => _ChiaSeScreen2State();
}

class _ChiaSeScreen2State extends State<ChiaSeScreen2> {
  List<UserInfo> peoplePicked = [
    UserInfo("1", "People 1", "", "", "085528484515484"),
    UserInfo("1", "People 1", "", "", "085528484515484"),
    UserInfo("1", "People 1", "", "", "085528484515484"),
  ];
  List<UserInfo> peopleSearched = [
    UserInfo("1", "People 1", "", "", "085528484515484"),
    UserInfo("1", "People 1", "", "", "085528484515484"),
    UserInfo("1", "People 1", "", "", "085528484515484"),
  ];

  final ValueNotifier<int> quyenHanSelector = ValueNotifier(0);
  final ValueNotifier<int> quyenTruyCapChungSelector = ValueNotifier(0);
  final ValueNotifier<List<UserInfo>> danhSachNguoiDuocChonNotifier =
      ValueNotifier([]);

  final TextEditingController searchController = TextEditingController();

  final ValueNotifier<bool> showMenuChonQuyen = ValueNotifier(false);

  double paddingTopClick = 0;

  bool showDanhSachDuocChiaSe = true;

  late ShareBloc shareBloc;

  @override
  void initState() {
    danhSachNguoiDuocChonNotifier.value = peoplePicked;
    shareBloc = BlocProvider.of<ShareBloc>(context);
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
                                controller: searchController,
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
                                  hintText:
                                      "Nhập tên, số điện thoại hoặc email",
                                  hintStyle: const TextStyle(
                                      color: Color.fromRGBO(118, 118, 118, 1)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(6.r),
                                      borderSide: BorderSide.none),
                                ),
                              ),
                            ),
                            // Icon
                            Container(
                              margin: EdgeInsets.only(left: 10.w),
                              child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  shareBloc
                                      .add(TimKiemUser(searchController.text));
                                },
                                icon: SvgPicture.asset(
                                  IconConstants.icSearchV2,
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
                                  child: SvgPicture.asset(
                                      IconConstants.icDefaultAvatar),
                                ),
                              ),
                              title: Text(peoplePicked[index].name ),
                              subtitle: Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(peoplePicked[index].phone ),
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
                    ],
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(left: 16.w, top: 12.5.h, bottom: 20.h),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
            Positioned(
              left: 16.w,
              top: 92.h,
              right: 70.w,
              child: BlocBuilder<ShareBloc, ShareState>(
                bloc: shareBloc,
                builder: (context, state) {
                  if (state is TimKiemUserSuccess) {
                    peopleSearched = state.listUser;
                  }
                  return Visibility(
                    visible: true,
                    child: Container(
                      height: peopleSearched.length >= 3
                          ? 180.h
                          : peopleSearched.length.h,
                      color: Colors.grey,
                      child: ListView.separated(
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => Divider(
                          height: 0,
                          thickness: 1.h,
                          color: const Color(0xffE5E5E5),
                        ),
                        itemCount: peopleSearched.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            minLeadingWidth: 0,
                            contentPadding: EdgeInsets.only(left: 10.w),
                            isThreeLine: false,
                            leading: SizedBox(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(18.r),
                                child: SvgPicture.asset(
                                    IconConstants.icDefaultAvatar),
                              ),
                            ),
                            title: Text(peopleSearched[index].name),
                            subtitle: Padding(
                                padding: EdgeInsets.only(top: 4.h),
                                child: Text(peopleSearched[index].phone)),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            )
          ]))),
    );
  }
}
