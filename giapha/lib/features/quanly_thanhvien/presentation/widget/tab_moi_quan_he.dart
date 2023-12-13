import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/data/models/moi_quan_he_model.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_thanhvien/quanly_thanhvien_bloc.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/widget/error_common_widget.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/no_data_widget.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class MoiQuanHeScreen extends StatefulWidget {
  final String memberId;
  final String gioiTinhMember;
  const MoiQuanHeScreen(
      {super.key, required this.memberId, required this.gioiTinhMember});

  @override
  State<MoiQuanHeScreen> createState() => _MoiQuanHeScreenState();
}

class _MoiQuanHeScreenState extends State<MoiQuanHeScreen> {
  late MoiQuanHeModel moiQuanHeModel;
  late QuanLyThanhVienBloc quanLyThanhVienBloc;

  var itemCount = 0;

  @override
  void initState() {
    super.initState();
    quanLyThanhVienBloc = BlocProvider.of<QuanLyThanhVienBloc>(context);
    quanLyThanhVienBloc.add(LayThanhVienEvent(widget.memberId));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffFBFBFB),
      child: BlocConsumer<QuanLyThanhVienBloc, QuanLyThanhVienState>(
          listener: (context, state) {
            if (state is LayThanhVienSuccess) {
              final List<MemberInfo> listFMInfo = [];
              if (state.member.fInfo != null) {
                listFMInfo.add(state.member.fInfo!);
              }
              if (state.member.mInfo != null) {
                listFMInfo.add(state.member.mInfo!);
              }
              moiQuanHeModel = MoiQuanHeModel(
                  boMe: listFMInfo,
                  voChong: state.member.pInfo ?? [],
                  conCai: state.member.cInfo ?? []);
            } else {
              moiQuanHeModel =
                  MoiQuanHeModel(boMe: [], voChong: [], conCai: []);
            }
          },
          bloc: quanLyThanhVienBloc,
          builder: (context, state) {
            if (state is QuanLyThanhVienLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LayThanhVienSuccess) {
              if (moiQuanHeModel.boMe.isEmpty &&
                  moiQuanHeModel.voChong.isEmpty &&
                  moiQuanHeModel.conCai.isEmpty) {
                return const NoDataWidget(
                    content: "Chưa có mối quan hệ nào trong gia phả");
              }
              return ListView(
                shrinkWrap: true,
                children: [
                  if (moiQuanHeModel.boMe.isNotEmpty)
                    ThongTinMoiQuanHeScreen(
                        memberInfo: moiQuanHeModel.boMe,
                        title: "Thông tin Bố/Mẹ"),
                  if (moiQuanHeModel.voChong.isNotEmpty)
                    ThongTinMoiQuanHeScreen(
                        memberInfo: moiQuanHeModel.voChong,
                        gioiTinhMember: widget.gioiTinhMember,
                        title: "Thông tin Vợ/Chồng"),
                  if (moiQuanHeModel.conCai.isNotEmpty)
                    ThongTinMoiQuanHeScreen(
                        memberInfo: moiQuanHeModel.conCai,
                        isConCai: true,
                        title: "Thông tin các con"),
                  Divider(
                    color: const Color.fromRGBO(229, 229, 229, 1),
                    height: 0.5.h,
                    thickness: 0.5.h,
                  ),
                ],
              );
            } else if (state is LayThanhVienError) {
              return const ErrorCommonWidget(
                  content:
                      "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
            } else {
              return const SizedBox();
            }
          }),
    );
  }
}

class ThongTinMoiQuanHeScreen extends StatefulWidget {
  final List<MemberInfo> memberInfo;
  final String title;
  final String? gioiTinhMember;
  final bool isConCai;
  const ThongTinMoiQuanHeScreen({
    super.key,
    required this.memberInfo,
    required this.title,
    this.gioiTinhMember,
    this.isConCai = false,
  });

  @override
  State<ThongTinMoiQuanHeScreen> createState() =>
      _ThongTinMoiQuanHeScreenState();
}

class _ThongTinMoiQuanHeScreenState extends State<ThongTinMoiQuanHeScreen> {
  late List<MemberInfo> memberInfo;
  @override
  void initState() {
    memberInfo = widget.memberInfo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(
            color: const Color.fromRGBO(229, 229, 229, 1),
            thickness: 0.5.h,
            height: 0.5.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.w, top: 14.h, bottom: 12.5.h),
            child: Text(widget.title,
                style: Theme.of(context).primaryTextTheme.titleSmall?.copyWith(
                    color: const Color.fromRGBO(0, 92, 172, 1),
                    fontFamily: "SF UI Display")),
          ),
          Divider(
            color: const Color.fromRGBO(229, 229, 229, 1),
            height: 0.5.h,
            thickness: 0.5.h,
          ),
          ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: memberInfo.length,
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 16.w,
                  thickness: 0.25.h,
                  height: 0.25.h,
                );
              },
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var user = memberInfo[index];
                var gioiTinhChuNhanh = memberInfo[0].gioiTinh;
                return GestureDetector(
                  onTap: () async {
                    final reload = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => quanLyThanhVienBuilder(
                                  context,
                                  false,
                                  user.giaPhaId!,
                                  user.fid,
                                  user.mid,
                                  user.pid,
                                  user,
                                )));
                    if (reload is MemberInfo) {
                      if (reload != user) {
                        setState(() {
                          memberInfo[index] = reload;
                        });
                      }
                    }
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 36.w,
                      height: 36.w,
                      child: user.avatar != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(33.w),
                              child: (user.avatar != null
                                  ? CachedNetworkImage(
                                      imageUrl: ImageNetworkUtils.getNetworkUrl(
                                          url: user.avatar!),
                                      fit: BoxFit.cover,
                                      errorWidget: (context, _, __) =>
                                          Image.asset(
                                              ImageConstants.imgDefaultAvatar),
                                      placeholder: (context, _) =>
                                          imageFromLocale(
                                              url: ImageConstants
                                                  .imgDefaultAvatar),
                                    )
                                  : imageFromLocale(
                                      url: ImageConstants.imgDefaultAvatar)))
                          : imageFromLocale(
                              url: ImageConstants.imgDefaultAvatar),
                    ),
                    title: Text(
                      user.ten ?? "",
                      style: Theme.of(context).primaryTextTheme.displayMedium,
                    ),
                    isThreeLine: true,
                    contentPadding: EdgeInsets.only(
                        bottom: 10.h, left: 16.w, top: 4.h, right: 16.w),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.h,
                        ),
                        Text(
                          user.trangThaiMat == TrangThaiMatConst.daMat
                              ? "Đã mất"
                              : "Còn sống",
                          style: Theme.of(context).primaryTextTheme.bodySmall,
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 46.w,
                              height: 22.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: user.gioiTinh == GioiTinhConst.nam
                                      ? const Color.fromRGBO(231, 243, 254, 1)
                                      : const Color.fromRGBO(255, 219, 203, 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.5.r))),
                              child: Text(
                                user.gioiTinh == GioiTinhConst.nam
                                    ? "Nam"
                                    : "Nữ",
                                style: Theme.of(context)
                                    .tabBarTheme
                                    .labelStyle
                                    ?.copyWith(
                                        color:
                                            user.gioiTinh == GioiTinhConst.nam
                                                ? const Color.fromRGBO(
                                                    23, 99, 207, 1)
                                                : const Color.fromRGBO(
                                                    217, 116, 89, 1)),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 72.w,
                                  height: 22.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          240, 241, 245, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.5.r))),
                                  child: Text(
                                    "${user.soVoChong} ${widget.gioiTinhMember.isNotNullOrEmpty ? widget.gioiTinhMember == GioiTinhConst.nam ? "chồng" : "vợ" : widget.isConCai ? user.gioiTinh == GioiTinhConst.nam ? "vợ" : "chồng" : index == 0 ? gioiTinhChuNhanh == GioiTinhConst.nam ? "vợ" : "chồng" : gioiTinhChuNhanh == GioiTinhConst.nam ? "chồng" : "vợ"}",
                                    style: Theme.of(context)
                                        .tabBarTheme
                                        .labelStyle
                                        ?.copyWith(
                                            color: const Color.fromRGBO(
                                                138, 141, 145, 1)),
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Container(
                                  width: 72.w,
                                  height: 22.h,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: const Color.fromRGBO(
                                          240, 241, 245, 1),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.5.r))),
                                  child: Text(
                                    "${user.soCon} con",
                                    style: Theme.of(context)
                                        .tabBarTheme
                                        .labelStyle
                                        ?.copyWith(
                                            color: const Color.fromRGBO(
                                                138, 141, 145, 1)),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    // dense: tr,
                  ),
                );
              }),
          // Divider(
          //   color: const Color.fromRGBO(229, 229, 229, 1),
          //   thickness: 1.h,
          //   height: 1.h,
          // ),
        ],
      ),
    );
  }
}


// class ThongTinMoiQuanHeScreen extends StatelessWidget {
//   final List<MemberInfo> memberInfo;
//   final String title;
//   final QuanLyThanhVienBloc quanLyThanhVienBloc;
//   const ThongTinMoiQuanHeScreen(
//       {super.key,
//       required this.memberInfo,
//       required this.title,
//       required this.quanLyThanhVienBloc});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Divider(
//           color: const Color.fromRGBO(229, 229, 229, 1),
//           height: 1.h,
//         ),
//         Padding(
//           padding: EdgeInsets.only(left: 16.w, top: 14.h, bottom: 12.5.h),
//           child: Text(title,
//               style: Theme.of(context).primaryTextTheme.titleSmall?.copyWith(
//                   color: const Color.fromRGBO(0, 92, 172, 1),
//                   fontFamily: "SF UI Display")),
//         ),
//         Divider(
//           color: const Color.fromRGBO(229, 229, 229, 1),
//           height: 1.h,
//           thickness: 1.h,
//         ),
//         ListView.separated(
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: memberInfo.length,
//             separatorBuilder: (context, index) {
//               return Divider(
//                 indent: 16.w,
//                 thickness: 1.h,
//                 // height: 1,
//               );
//             },
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               var user = memberInfo[index];
//               return GestureDetector(
//                 onTap: () async {
//                   final reload = await Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => quanLyThanhVienBuilder(
//                                 context,
//                                 false,
//                                 user.giaPhaId!,
//                                 user.fid,
//                                 user.mid,
//                                 user.pid,
//                                 user,
//                               )));
//                   if (reload is MemberInfo) {
//                     print(reload);
//                   }
//                 },
//                 child: ListTile(
//                   // contentPadding: EdgeInsets.symmetric(vertical: 20),
//                   leading: user.avatar != null
//                       ? imageFromNetWork(
//                           url: user.avatar!, width: 36.w, height: 36.h)
//                       : imageFromLocale(url: IconConstants.icDefaultAvatar),
//                   title: Text(
//                     user.ten ?? "",
//                     style: Theme.of(context).primaryTextTheme.displayMedium,
//                   ),
//                   isThreeLine: true,
//                   // dense: true,

//                   contentPadding: EdgeInsets.only(
//                       bottom: 15.5.h, left: 16.w, top: 12.5, right: 16.w),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 8.h,
//                       ),
//                       Text(
//                         user.trangThaiMat == TrangThaiMatConst.daMat
//                             ? "Đã mất"
//                             : "Còn sống",
//                         style: Theme.of(context).primaryTextTheme.bodySmall,
//                       ),
//                       SizedBox(
//                         height: 8.h,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             width: 46.w,
//                             height: 22.h,
//                             alignment: Alignment.center,
//                             decoration: BoxDecoration(
//                                 color: user.gioiTinh == GioiTinhConst.nam
//                                     ? const Color.fromRGBO(231, 243, 254, 1)
//                                     : const Color.fromRGBO(255, 219, 203, 1),
//                                 borderRadius:
//                                     BorderRadius.all(Radius.circular(10.5.r))),
//                             child: Text(
//                               user.gioiTinh == GioiTinhConst.nam ? "Nam" : "Nữ",
//                               style: Theme.of(context)
//                                   .tabBarTheme
//                                   .labelStyle
//                                   ?.copyWith(
//                                       color: user.gioiTinh == GioiTinhConst.nam
//                                           ? const Color.fromRGBO(23, 99, 207, 1)
//                                           : const Color.fromRGBO(
//                                               217, 116, 89, 1)),
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               Container(
//                                 width: 72.w,
//                                 height: 22.h,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     color:
//                                         const Color.fromRGBO(240, 241, 245, 1),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10.5.r))),
//                                 child: Text(
//                                   "${user.soVoChong} ${user.gioiTinh == GioiTinhConst.nam ? "Vợ" : "Chồng"}",
//                                   style: Theme.of(context)
//                                       .tabBarTheme
//                                       .labelStyle
//                                       ?.copyWith(
//                                           color: const Color.fromRGBO(
//                                               138, 141, 145, 1)),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 16.w,
//                               ),
//                               Container(
//                                 width: 72.w,
//                                 height: 22.h,
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                     color:
//                                         const Color.fromRGBO(240, 241, 245, 1),
//                                     borderRadius: BorderRadius.all(
//                                         Radius.circular(10.5.r))),
//                                 child: Text(
//                                   "${user.soCon} Con",
//                                   style: Theme.of(context)
//                                       .tabBarTheme
//                                       .labelStyle
//                                       ?.copyWith(
//                                           color: const Color.fromRGBO(
//                                               138, 141, 145, 1)),
//                                 ),
//                               ),
//                             ],
//                           )
//                         ],
//                       )
//                     ],
//                   ),
//                   // dense: tr,
//                 ),
//               );
//             }),
//         Divider(
//           color: const Color.fromRGBO(229, 229, 229, 1),
//           // thickness: 1.h,
//           height: 1.h,
//         ),
//       ],
//     );
//   }
// }
