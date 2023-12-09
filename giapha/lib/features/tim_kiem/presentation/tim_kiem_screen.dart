import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';

import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
import 'package:giapha/features/tim_kiem/bloc/tim_kiem_gia_pha/tim_kiem_gia_pha_bloc.dart';
import 'package:giapha/features/tim_kiem/bloc/tim_kiem_thanh_vien/tim_kiem_thanh_vien_bloc.dart';
import 'package:giapha/features/tim_kiem/presentation/widget/tab_thanh_vien.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/widget/button_shared.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/cubit/user_cubit/user_cubit.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';
import 'package:lichviet_flutter_base/widgets/date_picker_ver2/show_dialog_picker_view.dart';

import 'widget/tab_gia_pha.dart';

Widget timKiemScreen({String? idGiaPha, int? indexTabInit}) {
  return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return GetIt.I<TimKiemThanhVienBloc>();
        }),
        BlocProvider(create: (context) {
          return GetIt.I<TimKiemGiaPhaBloc>();
        }),
      
      ],
      child: TimKiemScreen(
        idGiaPha: idGiaPha,
        indexTabInit: indexTabInit,
      ));
}

class TimKiemScreen extends StatefulWidget {
  final String? idGiaPha;
  final int? indexTabInit;
  const TimKiemScreen({
    super.key,
    this.idGiaPha,
    this.indexTabInit,
  });

  @override
  State<TimKiemScreen> createState() => _TimKiemScreenState();
}

class _TimKiemScreenState extends State<TimKiemScreen>
    with SingleTickerProviderStateMixin {
  final UserCubit _userCubit = GetIt.I<UserCubit>();
  final TextEditingController _textSearchController = TextEditingController();
  late TabController _tabController;
  late TimKiemGiaPhaBloc _timKiemGiaPhaBloc;
  late TimKiemThanhVienBloc _timKiemThanhVienBloc;
  Timer? timer;
  Timer? timerSaveSearch;
  int tabCurrent = 0;
  ValueNotifier showCancelText = ValueNotifier(false);
  late List<String> listTextThanhVien;
  late List<String> listTextGiaPha;
  bool isShowTabBar = false;
  final ValueNotifier<bool> _showSearchRecent = ValueNotifier(true);
  final ValueNotifier<String> _gioiTinhFillter = ValueNotifier("");
  final ValueNotifier<dynamic> _namSinhFillter = ValueNotifier(null);
  WrapScrollController gioiTinhScrollController =
      WrapScrollController(FixedExtentScrollController(initialItem: 0));
  late ValueNotifier<bool> _showButtonFillter;

  @override
  void initState() {
    if (widget.indexTabInit != null && widget.indexTabInit == 1) {
      _showButtonFillter = ValueNotifier(false);
    } else {
      _showButtonFillter = ValueNotifier(true);
    }
    if (widget.indexTabInit != null) {
      tabCurrent = widget.indexTabInit!;
    }

    _timKiemGiaPhaBloc = BlocProvider.of<TimKiemGiaPhaBloc>(context);
    _timKiemThanhVienBloc = BlocProvider.of<TimKiemThanhVienBloc>(context);
    listTextThanhVien = _timKiemThanhVienBloc.getLocalSaveSearch(
      _userCubit.state.userInfo!.id ?? "",
    );
    listTextGiaPha = _timKiemGiaPhaBloc.getLocalSaveSearch(
      _userCubit.state.userInfo!.id ?? "",
    );
    _tabController = TabController(
        length: 2, vsync: this, initialIndex: widget.indexTabInit ?? 0);
    super.initState();
  }

  _showBottomDialog(String title, WrapScrollController wrapScrollController,
      ValueNotifier valueNotifier, List<String> options,
      {Function()? onSelect}) {
    FocusScope.of(context).requestFocus(FocusNode());
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height,
            color: Colors.black.withOpacity(0.65),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    wrapScrollController.controller =
                        FixedExtentScrollController(
                            initialItem:
                                wrapScrollController.controller!.initialItem);
                    Navigator.pop(context);
                  },
                  child: SafeArea(
                    child: Container(
                      margin: const EdgeInsets.only(right: 23),
                      alignment: Alignment.topRight,
                      child: SvgPicture.asset(
                        IconConstants.icCancel,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child: InkWell(
                        onTap: () {
                          wrapScrollController.controller =
                              FixedExtentScrollController(
                                  initialItem: wrapScrollController
                                      .controller!.initialItem);
                          Navigator.pop(context);
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).copyWith().size.height * 0.3,
                  child: Column(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(18),
                                topLeft: Radius.circular(18))),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: Icon(
                                  Icons.check,
                                  color: Color(0xfff2f2f2),
                                ),
                              ),
                              Text(
                                title,
                                style: ThemeStyles.small600
                                    .copyWith(color: const Color(0xff005cac)),
                              ),
                              InkWell(
                                onTap: () {
                                  valueNotifier.value = options[
                                      wrapScrollController
                                          .controller!.selectedItem];
                                  wrapScrollController.controller =
                                      FixedExtentScrollController(
                                          initialItem: wrapScrollController
                                              .controller!.selectedItem);
                                  if (onSelect != null) {
                                    onSelect();
                                  }
                                  Navigator.pop(context);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: Icon(
                                    Icons.check,
                                    color: Color(0xff237BD3),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          backgroundColor: Colors.white,
                          itemExtent: 40,
                          selectionOverlay: Column(
                            children: [
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: const Color(0xffcdced3),
                              ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: const Color(0xff3F85FB).withAlpha(20),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: const Color(0xffcdced3),
                              ),
                            ],
                          ),
                          scrollController: wrapScrollController.controller,
                          children: List.generate(options.length,
                              (index) => Center(child: Text(options[index]))),
                          onSelectedItemChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }


  _showDialogFillThanhVien(
    String title,
    String iconTitle,
    Function() onClickApply,
    Function() onClickXoaBoLoc,
  ) {
    FocusScope.of(context).requestFocus(FocusNode());
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).copyWith().size.height,
              color: Colors.black.withOpacity(0.65),
              child: Column(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container())),
                  Container(
                    padding: EdgeInsets.only(bottom: 24.h),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18),
                            topLeft: Radius.circular(18))),
                    child: Column(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  topLeft: Radius.circular(18))),
                          child: Column(
                            children: [
                              Transform.translate(
                                offset: Offset(0, -41.w),
                                child: Container(
                                  width: 88.w,
                                  height: 88.w,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffD9F2FF),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      width: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Center(
                                      child: imageFromLocale(url: iconTitle)),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, -17.h),
                                child: Text(
                                  title,
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .titleSmall
                                      ?.copyWith(
                                          color: const Color(0xff666666)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Divider(
                          indent: 16.w,
                          endIndent: 16.w,
                          height: 1,
                        ),
                        Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              // Expanded(
                              //     child: ValueListenableBuilder(
                              //         valueListenable: notifiSelect,
                              //         builder: (context, value, child) {
                              //           return OptionWidget(
                              //             indexSelected: chucVuOptions
                              //                 .map((e) => e.tenChucVu)
                              //                 .toList()
                              //                 .indexOf(
                              //                     notifiSelect.value),
                              //             onTap: (value) {
                              //               Navigator.pop(context);
                              //               textController.text =
                              //                   chucVuOptions
                              //                       .map((e) =>
                              //                           e.tenChucVu)
                              //                       .toList()[value];
                              //               notifiSelect.value =
                              //                   chucVuOptions
                              //                       .map((e) =>
                              //                           e.tenChucVu)
                              //                       .toList()[value];
                              //             },
                              //             listOption: chucVuOptions
                              //                 .map((e) => e.tenChucVu)
                              //                 .toList(),
                              //             mainAxisAlignment:
                              //                 MainAxisAlignment
                              //                     .spaceBetween,
                              //             verticalDirection: true,
                              //           );
                              //         })),

                              if (widget.idGiaPha.isNotNullOrEmpty)
                            

                              ValueListenableBuilder(
                                  valueListenable: _gioiTinhFillter,
                                  builder: (context, _, __) {
                                    return itemFill(
                                        IconConstants.icGioiTinh,
                                        "Giới tính",
                                        _gioiTinhFillter.value, onSelect: () {
                                      _showBottomDialog(
                                        'CHỌN GIỚI TÍNH',
                                        gioiTinhScrollController,
                                        _gioiTinhFillter,
                                        ["Nam", "Nữ"],
                                      );
                                    });
                                  }),
                              ValueListenableBuilder(
                                  valueListenable: _namSinhFillter,
                                  builder: (context, _, __) {
                                    return itemFill(
                                      IconConstants.icNgayMat,
                                      "Năm sinh",
                                      _namSinhFillter.value != null
                                          ? _namSinhFillter.value.toString()
                                          : "",
                                      onSelect: () {
                                        ShowDialogPickerView.showDialogPickerV2(
                                          context: context,
                                          dateTime: _namSinhFillter.value !=
                                                  null
                                              ? DateTime(
                                                  _namSinhFillter.value, 6, 1)
                                              : DateTime.now(),
                                          titleButton: "CHỌN NĂM",
                                          isShowViewLunar: false,
                                          isShowViewDay: false,
                                          isShowViewMonth: false,
                                          popAfterSelect: false,
                                          isOnlyYear: true,
                                          onSelect: (date, isLunar) {
                                            Navigator.pop(context);
                                            _namSinhFillter.value = date.year;
                                          },
                                        );
                                      },
                                    );
                                  }),
                              Divider(
                                thickness: 0.25.h,
                                height: 0.25.h,
                                indent: 16.w,
                                endIndent: 16.w,
                              ),
                              SizedBox(
                                height: 24.h,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: ButtonShared(
                                        //widthButton: 230.w,
                                        title: "Xóa bộ lọc".toUpperCase(),
                                        onClickButton: onClickXoaBoLoc,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 24.w,
                                    ),
                                    Expanded(
                                      child: ButtonShared(
                                        //widthButton: 230.w,
                                        title: "Áp dụng".toUpperCase(),
                                        onClickButton: onClickApply,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).padding.bottom != 0
                                        ? 0
                                        : 12.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
          //});
        });
  }

  Widget itemFill(String pathIcon, String title, String valueCurrent,
      {required Function() onSelect}) {
    return Column(
      children: [
        Divider(
          thickness: 0.25.h,
          height: 0.25.h,
          indent: 16.w,
          endIndent: 16.w,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
          child: Row(
            children: [
              imageFromLocale(url: pathIcon, color: const Color(0xffB2BCC8)),
              SizedBox(
                width: 24.w,
              ),
              Text(
                title,
                style: Theme.of(context).primaryTextTheme.bodyMedium,
              ),
              Expanded(
                child: InkWell(
                  onTap: onSelect,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        valueCurrent,
                        style: Theme.of(context).primaryTextTheme.displayMedium,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      imageFromLocale(url: IconConstants.icButtonMore)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void onClickSearchRecent(String value) {
    setState(() {
      isShowTabBar = true;
    });
    _textSearchController.text = value;
    _textSearchController.selection = TextSelection.fromPosition(
        TextPosition(offset: _textSearchController.text.length));
    onSearch();
  }

  void onSearch() {
    if (_tabController.index == 0 &&
        (_textSearchController.text.isNotEmpty ||
          
            _gioiTinhFillter.value.isNotNullOrEmpty ||
            _namSinhFillter.value != null)) {
      _showSearchRecent.value = false;
      showCancelText.value = true;

      _timKiemThanhVienBloc.add(TimKiemThanhVienTheoText(
        _textSearchController.text,
        idGiaPha: widget.idGiaPha,
        gioiTinh: _gioiTinhFillter.value.isNotNullOrEmpty
            ? _gioiTinhFillter.value == "Nam"
                ? 'male'
                : 'female'
            : "",
        year: _namSinhFillter.value,
      ));
    } else if (_textSearchController.text.isNotEmpty &&
        _tabController.index == 1) {
      _showSearchRecent.value = false;
      showCancelText.value = true;
      _timKiemGiaPhaBloc.add(TimKiemGiaPhaTheoText(_textSearchController.text));
    } else {
      _showSearchRecent.value = true;
      showCancelText.value = false;
      _timKiemGiaPhaBloc.emit(TimKiemGiaPhaInitial());
      _timKiemThanhVienBloc.emit(TimKiemThanhVienInitial());
    }
  }

  bool checkHasBoLoc() {
    if (tabCurrent == 0) {
      if (    _gioiTinhFillter.value.isNotNullOrEmpty ||
          _namSinhFillter.value != null) {
        return true;
      }
      return false;
    }
    return false;
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
          resizeToAvoidBottomInset: true,
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
                    if (_tabController.index == 0) {
                      if (!listTextThanhVien.any(
                          (element) => element == _textSearchController.text)) {
                        listTextThanhVien.add(_textSearchController.text);
                        _timKiemThanhVienBloc.saveLocalSearch(
                            _userCubit.state.userInfo!.id ?? "",
                            listTextThanhVien);
                      }
                    } else {
                      if (!listTextGiaPha.any(
                          (element) => element == _textSearchController.text)) {
                        listTextGiaPha.add(_textSearchController.text);
                        _timKiemGiaPhaBloc.saveLocalSearch(
                            _userCubit.state.userInfo!.id ?? "",
                            listTextGiaPha);
                      }
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
                        if (_showSearchRecent.value == false &&
                            !checkHasBoLoc()) {
                          _showSearchRecent.value = true;
                        }
                      } else {
                        setState(() {
                          isShowTabBar = true;
                        });
                        if (showCancelText.value == false) {
                          showCancelText.value = true;
                        }
                        if (_showSearchRecent.value == true) {
                          _showSearchRecent.value = false;
                        }
                      }
                      if (timer != null) {
                        timer!.cancel();
                      }

                      timer = Timer(const Duration(milliseconds: 300), () {
                        onSearch();
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
                          child: SvgPicture.asset(
                            IconConstants.icSearchV2,
                            package: PackageName.namePackageAddImage,
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
                                    if (!checkHasBoLoc()) {
                                      _showSearchRecent.value = true;
                                    }
                                    _textSearchController.text = "";
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
              ValueListenableBuilder(
                  valueListenable: _showButtonFillter,
                  builder: (context, _, __) {
                    if (_showButtonFillter.value) {
                      return AcAppBarButton.custom(
                          onPressed: () {
                            _showDialogFillThanhVien(
                                "Lọc Thành Viên".toUpperCase(),
                                IconConstants.icFilterV2, () {
                              Navigator.pop(context);
                              if (tabCurrent == 0) {
                                setState(() {
                                  isShowTabBar = true;
                                });
                                _showSearchRecent.value = false;
                                _timKiemThanhVienBloc.add(
                                  TimKiemThanhVienTheoText(
                                    _textSearchController.text,
                                    idGiaPha: widget.idGiaPha,
                                
                                    gioiTinh: _gioiTinhFillter
                                            .value.isNotNullOrEmpty
                                        ? _gioiTinhFillter.value == "Nam"
                                            ? 'male'
                                            : 'female'
                                        : "",
                                    year: _namSinhFillter.value,
                                  ),
                                );
                              }
                              // else {
                              //   _timKiemGiaPhaBloc
                              //       .add(TimKiemGiaPhaTheoText(
                              //     _textSearchController.text,
                              //   ));
                              // }
                            }, () {
                              Navigator.pop(context);

                              if (tabCurrent == 0) {
                          
                                _namSinhFillter.value = null;
                                _gioiTinhFillter.value = "";
                                if (_textSearchController.text.isEmpty) {
                                  _showSearchRecent.value = true;
                                } else {
                                  onSearch();
                                }
                              }
                            });
                          },
                          child: SvgPicture.asset(
                            IconConstants.icFilter,
                            color: Colors.white,
                            package: PackageName.namePackageAddImage,
                          ));
                    }
                    return AcAppBarButton.custom(
                        onPressed: () {},
                        child: const SizedBox(
                          width: 24,
                          height: 24,
                        ));
                  })
            ],
          ),
          body: Column(
            children: [
              Visibility(
                visible: isShowTabBar,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 2, color: Colors.black.withOpacity(0.15))
                    ],
                  ),
                  child: TabBar(
                    labelColor: const Color(0xff3F85FB),
                    controller: _tabController,
                    indicatorWeight: 3,
                    indicatorColor: const Color(0xff3F85FB),
                    tabs: const [
                      Tab(
                        child: Text("Thành viên"),
                      ),
                      Tab(
                        child: Text("Gia phả"),
                      ),
                    ],
                    onTap: (index) {
                      if (index != tabCurrent) {
                        if (index == 0) {
                          listTextThanhVien =
                              _timKiemThanhVienBloc.getLocalSaveSearch(
                            _userCubit.state.userInfo!.id ?? "",
                          );
                        } else {
                          listTextGiaPha =
                              _timKiemGiaPhaBloc.getLocalSaveSearch(
                            _userCubit.state.userInfo!.id ?? "",
                          );
                        }
                        tabCurrent = index;
                        _tabController.index = index;
                        if (index == 1) {
                          _showButtonFillter.value = false;
                        } else {
                          _showButtonFillter.value = true;
                        }
                        onSearch();
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    ValueListenableBuilder(
                      valueListenable: _showSearchRecent,
                      builder: (context, _, __) {
                        if (_showSearchRecent.value) {
                          return TabThanhVien(
                            giaPhaId: widget.idGiaPha ?? "",
                            onClickSearchRecent: (value) {
                              onClickSearchRecent(value);
                            },
                            listTextRecent: listTextThanhVien,
                          );
                        }
                        return BlocBuilder<TimKiemThanhVienBloc,
                            TimKiemThanhVienState>(
                          builder: (context, stateThanhVien) {
                            if (stateThanhVien is TimKiemThanhVienLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (stateThanhVien is TimKiemThanhVienSuccess) {
                              return TabThanhVien(
                                listResult: stateThanhVien.listMember,
                                giaPhaId: widget.idGiaPha ?? "",
                              );
                            }
                            return TabThanhVien(
                              onClickSearchRecent: (value) {
                                onClickSearchRecent(value);
                              },
                              listTextRecent: listTextThanhVien,
                              giaPhaId: widget.idGiaPha ?? "",
                            );
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: _showSearchRecent,
                      builder: (context, _, __) {
                        if (_showSearchRecent.value) {
                          return TabGiaPha(
                            onClickSearchRecent: (value) {
                              onClickSearchRecent(value);
                            },
                            listTextRecent: listTextGiaPha,
                          );
                        }
                        return BlocBuilder<TimKiemGiaPhaBloc,
                            TimKiemGiaPhaState>(
                          builder: (context, stateGiaPha) {
                            if (stateGiaPha is TimKiemGiaPhaLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (stateGiaPha is TimKiemGiaPhaSuccess) {
                              return TabGiaPha(
                                listResult: stateGiaPha.listGiaPha,
                              );
                            }
                            return TabGiaPha(
                              onClickSearchRecent: (value) {
                                onClickSearchRecent(value);
                              },
                              listTextRecent: listTextGiaPha,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchRecent {
  static List<String> listThanhVienSearchRecent = [];
  static List<String> listGiaPhaSearchRecent = [];
  static List<String> listNguoiMatSearchRecent = [];
}
