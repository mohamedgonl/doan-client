// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get_it/get_it.dart';
// import 'package:giapha/core/constants/api_value_constants.dart';
// import 'package:giapha/core/constants/icon_constrants.dart';
// import 'package:giapha/core/constants/image_constrants.dart';
// import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
// import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
// import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
// import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
// import 'package:giapha/features/tu_duong/presentation/tim_kiem_nguoi_mat_screen.dart';
// import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
// import 'package:giapha/shared/datetime/datetime_shared.dart';
// import 'package:giapha/shared/widget/error_common_widget.dart';
// import 'package:giapha/shared/widget/image.dart';
// import 'package:giapha/shared/widget/no_data_widget.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

// Widget tuDuongBuilder(BuildContext context, GiaPha giaPha) => BlocProvider(
//       create: (context) => GetIt.I<CayGiaPhaBloc>(),
//       child: TuDuongScreen(giaPha: giaPha),
//     );

// class TuDuongScreen extends StatefulWidget {
//   final GiaPha giaPha;
//   const TuDuongScreen({super.key, required this.giaPha});

//   @override
//   State<TuDuongScreen> createState() => _TuDuongScreenState();
// }

// class _TuDuongScreenState extends State<TuDuongScreen> {
//   late CayGiaPhaBloc cayGiaPhaBloc;
//   //late CayGiaPhaModel cayGiaPhaModel;
//   //List<MemberInfo> danhSach = [];

//   @override
//   void initState() {
//     cayGiaPhaBloc = BlocProvider.of<CayGiaPhaBloc>(context);
//     cayGiaPhaBloc.add(LayDanhSachNguoiMat(widget.giaPha.id));
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         actions: [
//           AcAppBarButton.custom(
//               onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return timKiemNguoiMatScreen(context, widget.giaPha.id);
//                 }));
//               },
//               child: imageFromLocale(url: IconConstants.icSearch)),
//         ],
//         title: Text(
//           "Từ đường ${widget.giaPha.tenGiaPha}",
//           overflow: TextOverflow.ellipsis,
//         ),
//         leading: AcAppBarButton.custom(
//             onPressed: () {
//               if (Navigator.canPop(context)) {
//                 Navigator.pop(context);
//               }
//             },
//             child: SvgPicture.asset(
//               IconConstants.icBack,
//               fit: BoxFit.cover,
//               height: 19.h,
//               width: 10.w,
//               color: Colors.white,
//             )),
//       ),
//       body: BlocConsumer<CayGiaPhaBloc, CayGiaPhaState>(
//           bloc: cayGiaPhaBloc,
//           listener: (context, state) {
//             if (state is GetDanhSachNguoiMatSuccess) {
//               //   cayGiaPhaModel = CayGiaPhaModel(state.listMember);
//               //   for (var e in cayGiaPhaModel.rawData) {
//               //     for (var i in e) {
//               //       if (i.info != null) {
//               //         if (i.info?.trangThaiMat == TrangThaiMatConst.daMat) {
//               //           danhSach.add(i.info!);
//               //         }
//               //         if (i.pids!.isNotEmpty) {
//               //           for (var y in i.pids!) {
//               //             var partner = y;
//               //             if (y.trangThaiMat == TrangThaiMatConst.daMat) {
//               //               partner.depth = i.info?.depth;
//               //               danhSach.add(y);
//               //             }
//               //           }
//               //         }
//               //       }
//               //     }
//               //   }
//             }
//           },
//           builder: (context, state) {
//             return (state is GetDanhSachNguoiMatSuccess)
//                 ? state.listTVDaMat.isEmpty
//                     ? const NoDataWidget(
//                         content: "Chưa có thành viên nào trong từ đường")
//                     : ListView.separated(
//                         itemCount: state.listTVDaMat.length,
//                         separatorBuilder: (context, index) {
//                           return Container(
//                             height: 10.h,
//                             color: Theme.of(context).scaffoldBackgroundColor,
//                           );
//                         },
//                         itemBuilder: (context, index) {
//                           ValueNotifier<MemberInfo> user =
//                               ValueNotifier(state.listTVDaMat[index]);
//                           // String ngayMat = (user.value.ngayMat.isNotNullOrEmpty)
//                           //     ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(user.value.ngayMat!))} (ÂL)"
//                           //     : "Chưa có dữ liệu";
//                           // String ngayGio = (user.value.ngayGio.isNotNullOrEmpty)
//                           //     ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(user.value.ngayGio!))} (ÂL)"
//                           //     : "Chưa có dữ liệu";

//                           //  String ngayGio = DateTimeShared.dateTimeToStringDefault1(
//                           //     DateTimeShared.formatStringReverseToDate8(user.ngayMat!));
//                           // int childCount = user.value.soCon;
//                           // cayGiaPhaModel.getChildCount(
//                           //     user.memberId, user.depth);
//                           // int? partnerCount =
//                           //     int.parse(user.value.soVoChong ?? "0");
//                           //cayGiaPhaModel.getPartnerCount(user.memberId!);

//                           return ValueListenableBuilder(
//                             valueListenable: user,
//                             builder: (context, value, child) => InkWell(
//                               onTap: () async {
//                                 final info = await Navigator.of(context)
//                                     .push(MaterialPageRoute(
//                                   builder: (context) {
//                                     return quanLyThanhVienBuilder(
//                                         context,
//                                         false,
//                                         widget.giaPha.id,
//                                         null,
//                                         null,
//                                         null,
//                                         user.value);
//                                   },
//                                 ));
//                                 if (info != null && info is MemberInfo) {
//                                   final MemberInfo memberTemp = info.copyWith(
//                                       soCon: user.value.soCon,
//                                       soVoChong: user.value.soVoChong);
//                                   user.value = memberTemp;
//                                 }
//                               },
//                               child: Container(
//                                 color: Colors.white,
//                                 child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Divider(
//                                         color: const Color.fromRGBO(
//                                             229, 229, 229, 1),
//                                         height: 1.h,
//                                         thickness: 1.h,
//                                       ),
//                                       ListTile(
//                                         // contentPadding: const EdgeInsets.symmetric(vertical: 20),
//                                         leading: SizedBox(
//                                           width: 36.w,
//                                           height: 36.w,
//                                           child: user.value.avatar != null
//                                               ? ClipRRect(
//                                                   borderRadius:
//                                                       BorderRadius.circular(
//                                                           33.w),
//                                                   child: (user.value.avatar !=
//                                                           null
//                                                       ? CachedNetworkImage(
//                                                           imageUrl: ImageNetworkUtils
//                                                               .getNetworkUrl(
//                                                                   url: user
//                                                                       .value
//                                                                       .avatar!),
//                                                           fit: BoxFit.cover,
//                                                           errorWidget: (context,
//                                                                   _, __) =>
//                                                               Image.asset(
//                                                                   ImageConstants
//                                                                       .imgDefaultAvatar),
//                                                           placeholder: (context,
//                                                                   _) =>
//                                                               imageFromLocale(
//                                                                   url: ImageConstants
//                                                                       .imgDefaultAvatar),
//                                                         )
//                                                       : imageFromLocale(
//                                                           url: ImageConstants
//                                                               .imgDefaultAvatar)))
//                                               : imageFromLocale(
//                                                   url: ImageConstants
//                                                       .imgDefaultAvatar),
//                                         ),
//                                         title: Text(
//                                           user.value.ten ?? "",
//                                           overflow: TextOverflow.ellipsis,
//                                           style: Theme.of(context)
//                                               .primaryTextTheme
//                                               .displayMedium,
//                                         ),
//                                         // isThreeLine: true,
//                                         // dense: true,

//                                         contentPadding: EdgeInsets.only(
//                                             bottom: 15.5.h,
//                                             left: 16.w,
//                                             top: 12.5,
//                                             right: 16.w),
//                                         subtitle: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             SizedBox(
//                                               height: 8.h,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Container(
//                                                   width: 46.w,
//                                                   height: 22.h,
//                                                   alignment: Alignment.center,
//                                                   decoration: BoxDecoration(
//                                                       color: user.value
//                                                                   .gioiTinh ==
//                                                               GioiTinhConst.nam
//                                                           ? const Color.fromRGBO(
//                                                               231, 243, 254, 1)
//                                                           : const Color
//                                                               .fromRGBO(
//                                                               255, 219, 203, 1),
//                                                       borderRadius:
//                                                           BorderRadius.all(
//                                                               Radius.circular(
//                                                                   10.5.r))),
//                                                   child: Text(
//                                                     user.value.gioiTinh ==
//                                                             GioiTinhConst.nam
//                                                         ? "Nam"
//                                                         : "Nữ",
//                                                     style: Theme.of(context)
//                                                         .tabBarTheme
//                                                         .labelStyle
//                                                         ?.copyWith(
//                                                             color: user.value
//                                                                         .gioiTinh ==
//                                                                     GioiTinhConst
//                                                                         .nam
//                                                                 ? const Color
//                                                                     .fromRGBO(
//                                                                     23,
//                                                                     99,
//                                                                     207,
//                                                                     1)
//                                                                 : const Color
//                                                                     .fromRGBO(
//                                                                     217,
//                                                                     116,
//                                                                     89,
//                                                                     1)),
//                                                   ),
//                                                 ),
//                                                 Row(
//                                                   children: [
//                                                     // if (partnerCount != 0)
//                                                     Container(
//                                                       width: 72.w,
//                                                       height: 22.h,
//                                                       alignment:
//                                                           Alignment.center,
//                                                       decoration: BoxDecoration(
//                                                           color: const Color
//                                                               .fromRGBO(
//                                                               240, 241, 245, 1),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius.circular(
//                                                                       10.5.r))),
//                                                       child: Text(
//                                                         "${user.value.soVoChong} ${user.value.gioiTinh == GioiTinhConst.nam ? "vợ" : "chồng"}",
//                                                         style: Theme.of(context)
//                                                             .tabBarTheme
//                                                             .labelStyle
//                                                             ?.copyWith(
//                                                                 color: const Color
//                                                                     .fromRGBO(
//                                                                     138,
//                                                                     141,
//                                                                     145,
//                                                                     1)),
//                                                       ),
//                                                     ),
//                                                     SizedBox(
//                                                       width: 16.w,
//                                                     ),
//                                                     // if (childCount != 0)
//                                                     Container(
//                                                       width: 72.w,
//                                                       height: 22.h,
//                                                       alignment:
//                                                           Alignment.center,
//                                                       decoration: BoxDecoration(
//                                                           color: const Color
//                                                               .fromRGBO(
//                                                               240, 241, 245, 1),
//                                                           borderRadius:
//                                                               BorderRadius.all(
//                                                                   Radius.circular(
//                                                                       10.5.r))),
//                                                       child: Text(
//                                                         "${user.value.soCon} con",
//                                                         style: Theme.of(context)
//                                                             .tabBarTheme
//                                                             .labelStyle
//                                                             ?.copyWith(
//                                                                 color: const Color
//                                                                     .fromRGBO(
//                                                                     138,
//                                                                     141,
//                                                                     145,
//                                                                     1)),
//                                                       ),
//                                                     ),
//                                                   ],
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                         // dense: tr,
//                                       ),
//                                       Container(
//                                         padding: EdgeInsets.only(
//                                             left: 16.w, bottom: 16.h),
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             Divider(
//                                               height: 1.h,
//                                               thickness: 1.h,
//                                             ),
//                                             SizedBox(
//                                               height: 12.5.h,
//                                             ),
//                                             Text(
//                                               "Ngày mất: ${(user.value.ngayMat.isNotNullOrEmpty) ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(user.value.ngayMat!))} (ÂL)" : "Chưa có thông tin"}",
//                                               style: Theme.of(context)
//                                                   .primaryTextTheme
//                                                   .bodySmall,
//                                             ),
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
                                            
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
                                            
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
                                           
//                                             SizedBox(
//                                               height: 3.h,
//                                             ),
                                           
//                                           ],
//                                         ),
//                                       ),
//                                       Divider(
//                                         color: const Color(0xffE5E5E5),
//                                         height: 1.h,
//                                         thickness: 1.h,
//                                       ),
//                                     ]),
//                               ),
//                             ),
//                           );
//                         })
//                 : (state is GetDanhSachNguoiMatLoading)
//                     ? const Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : (state is GetDanhSachNguoiMatError)
//                         ? Center(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 16.w),
//                               child: ErrorCommonWidget(
//                                 content: state.message.isNotEmpty
//                                     ? state.message
//                                     : "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại",
//                               ),
//                             ),
//                           )
//                         : const SizedBox.shrink();
//           }),
//     );
//   }
// }
