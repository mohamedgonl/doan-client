import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/tim_kiem/presentation/tim_kiem_screen.dart';
import 'package:giapha/features/tim_kiem/presentation/widget/tab_thanh_vien.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:lichviet_flutter_base/cubit/cubit.dart';
import 'package:lichviet_flutter_base/widgets/app_bar/ac_app_bar_button.dart';

Widget timKiemNguoiMatScreen(BuildContext context, String idGiaPha) =>
    BlocProvider(
      create: (context) => GetIt.I<CayGiaPhaBloc>(),
      child: TimKiemNguoiMatScreen(idGiaPha: idGiaPha),
    );

class TimKiemNguoiMatScreen extends StatefulWidget {
  final String idGiaPha;
  const TimKiemNguoiMatScreen({super.key, required this.idGiaPha});

  @override
  State<TimKiemNguoiMatScreen> createState() => _TimKiemNguoiMatScreenState();
}

class _TimKiemNguoiMatScreenState extends State<TimKiemNguoiMatScreen> {
  final TextEditingController _textSearchController = TextEditingController();
  Timer? timer;
  late CayGiaPhaBloc _timKiemNguoiMatBloc;
  ValueNotifier showCancelText = ValueNotifier(false);
  final UserCubit _userCubit = GetIt.I<UserCubit>();
  late List<String> listTextNguoiMat;

  @override
  void initState() {
    _timKiemNguoiMatBloc = BlocProvider.of<CayGiaPhaBloc>(context);
    listTextNguoiMat = _timKiemNguoiMatBloc.getLocalSaveSearch(
      _userCubit.state.userInfo!.id ?? "",
    );
    super.initState();
  }

  void onClickSearchRecent(String value) {
    _textSearchController.text = value;
    _timKiemNguoiMatBloc.add(LayDanhSachNguoiMat(widget.idGiaPha,
        textSearch: _textSearchController.text, isTabTuDuong: false));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
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
            title: Focus(
              onFocusChange: (value) {
                if (!value) {
                  if (_textSearchController.text.isNotEmpty) {
                    if (!listTextNguoiMat.any(
                        (element) => element == _textSearchController.text)) {
                      listTextNguoiMat.add(_textSearchController.text);
                      _timKiemNguoiMatBloc.saveLocalSearch(
                          _userCubit.state.userInfo!.id ?? "",
                          listTextNguoiMat);
                    }
                  }
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                  height: 40,
                  child: TextFormField(
                    autofocus: true,
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    controller: _textSearchController,
                    onChanged: (value) {
                      if (value.isEmpty) {
                        if (showCancelText.value == true) {
                          showCancelText.value = false;
                        }
                      } else {
                        if (showCancelText.value == false) {
                          showCancelText.value = true;
                        }
                      }
                      if (timer != null) {
                        timer!.cancel();
                      }

                      timer = Timer(const Duration(milliseconds: 300), () {
                        _timKiemNguoiMatBloc.add(LayDanhSachNguoiMat(
                            widget.idGiaPha,
                            textSearch: _textSearchController.text,
                            isTabTuDuong: false));
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "Tìm kiếm",
                        hintMaxLines: 1,
                        hintStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic,
                            color: const Color(0xff9D9D9D),
                            overflow: TextOverflow.ellipsis),
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(left: 12.w, right: 16.w),
                          child: imageFromLocale(
                            url: IconConstants.icSearchV2,
                          ),
                        ),
                        prefixIconConstraints: BoxConstraints(maxHeight: 24.h),
                        suffixIcon: ValueListenableBuilder(
                            valueListenable: showCancelText,
                            builder: (context, _, __) {
                              if (showCancelText.value) {
                                return InkWell(
                                  onTap: () {
                                    showCancelText.value = false;
                                    _textSearchController.text = "";
                                    _timKiemNguoiMatBloc.add(
                                        LayDanhSachNguoiMat(widget.idGiaPha,
                                            textSearch:
                                                _textSearchController.text,
                                            isTabTuDuong: false));
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 12.w),
                                    child: imageFromLocale(
                                        url: IconConstants.icXoaSearch),
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }),
                        suffixIconConstraints: BoxConstraints(maxHeight: 24.h),
                        contentPadding: EdgeInsets.symmetric(vertical: 0.h),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8)),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(8))),
                  ),
                ),
              ),
            ),
            actions: [
              AcAppBarButton.custom(
                onPressed: () {
                  // _showDialogFillThanhVien("Lọc Thành Viên".toUpperCase(),
                  //     IconConstants.icFilterV2);
                },
                child: const SizedBox(
                  width: 24,
                  height: 24,
                ),
                // child: SvgPicture.asset(
                //   IconConstants.icFilter,
                //   color: Colors.white,
                //   package: PackageName.namePackageAddImage,
                // ),
              ),
            ],
          ),
          body: BlocBuilder<CayGiaPhaBloc, CayGiaPhaState>(
              builder: (context, stateNguoiMat) {
            if (_textSearchController.text.isEmpty) {
              return TabThanhVien(
                giaPhaId: widget.idGiaPha,
                onClickSearchRecent: (value) {
                  onClickSearchRecent(value);
                },
                listTextRecent: listTextNguoiMat,
              );
            }
            if (stateNguoiMat is GetDanhSachNguoiMatLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (stateNguoiMat is GetDanhSachNguoiMatSuccess) {
              return TabThanhVien(
                listResult: stateNguoiMat.listTVDaMat,
                giaPhaId: widget.idGiaPha,
              );
            }
            return TabThanhVien(
              onClickSearchRecent: (value) {
                onClickSearchRecent(value);
              },
              listTextRecent: listTextNguoiMat,
              giaPhaId: widget.idGiaPha,
            );
          }),
        ),
      ),
    );
  }
}
