import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/danhsach_giapha/presentation/bloc/danhsach_giapha_bloc.dart';
import 'package:giapha/features/danhsach_giapha/presentation/widgets/menu_widget.dart';
import 'package:giapha/features/them_gia_pha/presentation/them_gia_pha_screen.dart';
import 'package:giapha/features/tim_kiem/presentation/tim_kiem_screen.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';
import 'package:giapha/shared/widget/error_common_widget.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/no_data_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/icon_constrants.dart';
import '../../../../shared/app_bar/ac_app_bar_button.dart';
import '../../../cay_gia_pha/presentation/cay_gia_pha_screen.dart';
import '../widgets/Item_gia_pha.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

Widget danhSachGiaPhaBuilder(
  BuildContext context,
) =>
    BlocProvider(
        create: (context) => GetIt.I<DanhsachGiaphaBloc>(),
        child: const DanhSachGiaPhaScreen());

class DanhSachGiaPhaScreen extends StatefulWidget {
  const DanhSachGiaPhaScreen({super.key});

  @override
  State<DanhSachGiaPhaScreen> createState() => _DanhSachGiaPhaScreenState();
}

class _DanhSachGiaPhaScreenState extends State<DanhSachGiaPhaScreen> {
  ValueNotifier showMenu = ValueNotifier<bool>(false);
  ValueNotifier showFloatButton = ValueNotifier<bool>(true);
  int giaphaIndex = -1;
  double paddingTopClick = 0;
  late DanhsachGiaphaBloc danhSachGiaPhaBloc;
  List<GiaPha> danhSachGiaPha = [];
  PackageInfo? packageInfo;

  void themOrSuaGiaPhaOnClick(GiaPha? giaPha) async {
    final refresh =
        await Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return themOrSuaGiaPhaBuilder(context, giaPha);
    })));
    if (refresh ?? false) {
      danhSachGiaPhaBloc.add(LayDanhSachGiaPhaEvent());
    }
  }

  @override
  void initState() {
    super.initState();
    getPackage();
    danhSachGiaPhaBloc = BlocProvider.of<DanhsachGiaphaBloc>(context);
    danhSachGiaPhaBloc.add(LayDanhSachGiaPhaEvent());
  }

  void getPackage() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo!.packageName.contains("giapha")) {
      PackageName.namePackageAddImage = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Gia Phả"),
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
        actions: [
          AcAppBarButton.custom(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return timKiemScreen(indexTabInit: 1);
                }));
              },
              child: SvgPicture.asset(IconConstants.icSearch)),
        ],
      ),
      // floatingActionButton: ValueListenableBuilder(
      //     valueListenable: showFloatButton,
      //     builder: (context, _, __) {
      //       if (showFloatButton.value) {
      //         return InkWell(
      //           onTap: () => themOrSuaGiaPhaOnClick(null),
      //           child: Container(
      //             decoration: BoxDecoration(
      //                 shape: BoxShape.circle,
      //                 border: Border.all(
      //                     width: 4.w,
      //                     color: const Color(0xffD6ECFC).withOpacity(0.6))),
      //             child: Container(
      //               width: 60.w,
      //               height: 60.w,
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   color: Colors.white,
      //                   border: Border.all(
      //                       width: 4.w, color: const Color(0xffD6ECFC))),
      //               child: Center(
      //                 child: imageFromLocale(
      //                   url: IconConstants.icThemGiaPha,
      //                   width: 36.w,
      //                   height: 36.w,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         );
      //       }
      //       return const SizedBox.shrink();
      //     }),

      body: BlocConsumer<DanhsachGiaphaBloc, DanhsachGiaphaState>(
        listener: (context, state) {
          if (state is XoaGiaPhaSuccess) {
            AnimatedSnackBar.material("Xoá gia phả thành công",
                    type: AnimatedSnackBarType.success,
                    duration: const Duration(milliseconds: 2000))
                .show(context);

            danhSachGiaPhaBloc.add(LayDanhSachGiaPhaEvent());
          } else if (state is LayDanhSachError) {
            AnimatedSnackBar.material("Lấy danh sách gia phả thất bại",
                    type: AnimatedSnackBarType.error,
                    duration: const Duration(milliseconds: 2000))
                .show(context);
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LayDanhSachError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ErrorCommonWidget(
                  content: state.message,
                ),
              ),
            );
          } else if (state is Loaded) {
            danhSachGiaPha = state.danhSachGiaPha;
            if (danhSachGiaPha.isEmpty) {
              showFloatButton.value = false;
              return NoDataWidget(
                content: 'Chưa có gia phả nào',
                titleButton: "Thêm gia phả".toUpperCase(),
                onClickButton: () {
                  themOrSuaGiaPhaOnClick(null);
                },
              );
            } else {
              showFloatButton.value = true;
              return GestureDetector(
                onTapUp: (detail) {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(
                          top: 16.h,
                          left: 16.w,
                          right: 16.w,
                          bottom: 16.h + 94.w),
                      itemCount: danhSachGiaPha.length,
                      itemBuilder: ((context, index) {
                        return ItemGiaPha(
                          giaPha: danhSachGiaPha[index],
                          onClick: () async {
                            List<int> data = await Navigator.push(context,
                                MaterialPageRoute(builder: ((context) {
                              return cayGiaPhaBuilder(
                                  context, danhSachGiaPha[index]);
                            })));
                            if (data[0] != -1 && data[1] != -1) {
                              if ((danhSachGiaPha[index].soDoi !=
                                      data[0].toString() ||
                                  danhSachGiaPha[index].soThanhVien !=
                                      data[1].toString())) {
                                setState(() {
                                  danhSachGiaPha[index].soDoi =
                                      data[0].toString();
                                  danhSachGiaPha[index].soThanhVien =
                                      data[1].toString();
                                });
                              }
                            }
                          },
                          onClickMore: (tapDetail) {
                            paddingTopClick = tapDetail.globalPosition.dy -
                                tapDetail.localPosition.dy;
                            showMenu.value = !showMenu.value;
                            giaphaIndex = index;
                          },
                        );
                      }),
                    ),
                    Positioned(
                      bottom: MediaQuery.of(context).padding.bottom + 16.w,
                      right: 16.w,
                      child: ValueListenableBuilder(
                          valueListenable: showFloatButton,
                          builder: (context, _, __) {
                            if (showFloatButton.value) {
                              return InkWell(
                                onTap: () => themOrSuaGiaPhaOnClick(null),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 4.w,
                                          color: const Color(0xffD6ECFC)
                                              .withOpacity(0.6))),
                                  child: Container(
                                    width: 60.w,
                                    height: 60.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(
                                            width: 4.w,
                                            color: const Color(0xffD6ECFC))),
                                    child: Center(
                                      child: imageFromLocale(
                                        url: IconConstants.icThemGiaPha,
                                        width: 36.w,
                                        height: 36.w,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          }),
                    ),
                    ValueListenableBuilder(
                        valueListenable: showMenu,
                        builder: (context, _, __) {
                          if (showMenu.value) {
                            return MenuWidget(
                              paddingTop: paddingTopClick -
                                  ThemeLayouts.appBarHeight +
                                  15.h,
                              onClickBarrier: () {
                                showMenu.value = !showMenu.value;
                              },
                              onClickDelete: () {
                                danhSachGiaPhaBloc.add(XoaGiaPhaEvent(
                                    danhSachGiaPha[giaphaIndex].id));
                              },
                              giaPha: danhSachGiaPha[giaphaIndex],
                              onClickEdit: () => themOrSuaGiaPhaOnClick(
                                  danhSachGiaPha[giaphaIndex]),
                                  familyId: danhSachGiaPha[giaphaIndex].id,
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ],
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
