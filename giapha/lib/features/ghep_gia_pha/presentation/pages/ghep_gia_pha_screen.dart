import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/widget/cay_pha_he.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/widget/dropdownlist_shared.dart';

// import 'package:lichviet_flutter_base/core/core.dart';
// import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

Widget ghepGiaPhaBuilder(BuildContext context, String giaPhaId) => BlocProvider(
    create: (context) => GetIt.I<GhepGiaPhaBloc>(),
    child: GhepGiaPhaScreen(
      giaPhaId,
    ));

class GhepGiaPhaScreen extends StatefulWidget {
  final String giaPhaId;

  const GhepGiaPhaScreen(
    this.giaPhaId, {
    super.key,
  });

  @override
  State<GhepGiaPhaScreen> createState() => _GhepGiaPhaScreenState();
}

class _GhepGiaPhaScreenState extends State<GhepGiaPhaScreen> {
  late GhepGiaPhaBloc ghepGiaPhaBloc;

  late List<GiaPhaModel> danhsachGiaPha;
  late List<Member> danhsachNhanhSrc;
  late List<Member> danhsachNhanhDes;
  Member? valueNhanhDesSelected;

  late String giaPhaChoosed;
  late String nhanhSrcChoosed;
  late String nhanhDesChoosed;

  @override
  void initState() {
    super.initState();

    ghepGiaPhaBloc = BlocProvider.of<GhepGiaPhaBloc>(context);
    danhsachNhanhDes = [];
    danhsachNhanhSrc = [];
    danhsachGiaPha = [];
    giaPhaChoosed = '';
    nhanhSrcChoosed = '';

    nhanhDesChoosed = '';

    ghepGiaPhaBloc.add(LayDanhSachGiaPhaDaTaoEvent());
    ghepGiaPhaBloc.add(LayDanhSachNhanhDesEvent(widget.giaPhaId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: ghepGiaPhaBloc,
      listener: (context, state) {
        if (state is LayDanhSachGiaPhaDaTaoSuccess) {
          danhsachGiaPha = state.danhsach
              .where((element) => element.id != widget.giaPhaId)
              .toList();
        }
        if (state is LayDanhSachNhanhSrcSuccess) {
          danhsachNhanhSrc = state.danhsach;
        }
        if (state is LayDanhSachNhanhDesSuccess) {
          danhsachNhanhDes = state.danhsach;
        }
        if (state is GhepPreviewReady) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CayPhaHePreview(
                  nameGiaPha: "Preview", listMember: state.cayGiaPha)));
        }

        if (state is GhepPreviewFail) {
          AnimatedSnackBar.material(state.message,
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 1));
        }
        if (state is GhepFail) {
          AnimatedSnackBar.material(state.message,
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 1));
        }
        if (state is GhepSuccess) {
          AnimatedSnackBar.material("Ghép thành công",
              type: AnimatedSnackBarType.error,
              duration: const Duration(seconds: 1));
          Navigator.pop(context);
        }
      },
      builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text("Yêu cầu ghép gia phả"),
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
              AcAppBarButton.text(
                "Lưu",
                onPressed: () {
                  if (giaPhaChoosed.isNullOrEmpty) {
                    AnimatedSnackBar.material("Chưa chọn gia phả",
                        type: AnimatedSnackBarType.warning,
                        duration: const Duration(milliseconds: 2000));
                    return;
                  }
                  if (nhanhSrcChoosed.isNullOrEmpty) {
                    if (danhsachNhanhSrc.isEmpty) {
                      AnimatedSnackBar.material(
                          "Gia phả muốn ghép chưa có thành viên nào",
                          type: AnimatedSnackBarType.info,
                          duration: const Duration(milliseconds: 2000));
                    } else {
                      AnimatedSnackBar.material("Chưa chọn nhánh muốn ghép vào",
                          type: AnimatedSnackBarType.info,
                          duration: const Duration(milliseconds: 2000));
                    }
                    return;
                  }
                  if (nhanhDesChoosed.isNullOrEmpty) {
                    AnimatedSnackBar.material("Chưa chọn ghép vào nhánh",
                        type: AnimatedSnackBarType.info,
                        duration: const Duration(milliseconds: 2000));

                    return;
                  }

                  ghepGiaPhaBloc.add(YeuCauGhepGiaPhaEvent(
                      giaPhaId: widget.giaPhaId,
                      nhanhSrcChoosed: nhanhSrcChoosed,
                      nhanhDesChoosed: nhanhDesChoosed));
                },
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          body: GestureDetector(
            onTapUp: (detail) {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    DropDownListShared(
                      items: danhsachGiaPha.map((GiaPhaModel giaPha) {
                        return DropdownMenuItem(
                          value: giaPha,
                          child: Text(giaPha.tenGiaPha),
                        );
                      }).toList(),
                      title: "Chọn gia phả",
                      hintText: "Chọn gia phả",
                      pathIcon: IconConstants.icDocument,
                      enabled: true,
                      onChanged: (giaPha) {
                        giaPhaChoosed = giaPha.id;
                        ghepGiaPhaBloc.add(LayDanhSachNhanhSrcEvent(giaPha.id));
                      },
                    ),
                    DropDownListShared(
                      items: danhsachNhanhSrc.map((Member nhanh) {
                        return DropdownMenuItem(
                          value: nhanh,
                          child: Text(nhanh.info?.ten ?? ""),
                        );
                      }).toList(),
                      title: "Nhánh muốn ghép vào",
                      hintText: "Chọn Nhánh muốn ghép vào",
                      pathIcon: IconConstants.icNhanh,
                      enabled: true,
                      onChanged: (nhanh) {
                        nhanhSrcChoosed = nhanh.info.memberId;
                      },
                    ),
                    DropDownListShared(
                      items: danhsachNhanhDes.map((Member nhanh) {
                        return DropdownMenuItem(
                          value: nhanh,
                          child: Text(nhanh.info?.ten ?? ""),
                        );
                      }).toList(),
                      value: valueNhanhDesSelected,
                      title: "Chọn ghép vào nhánh (của người khác đã tạo)",
                      hintText: "Chọn ghép vào nhánh",
                      pathIcon: IconConstants.icLink,
                      enabled: true,
                      onChanged: (nhanh) {
                        nhanhDesChoosed = nhanh.info.memberId;
                      },
                    ),
                    SizedBox(
                      width: 4.w,
                      height: 15.h,
                    ),
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
                              color: const Color.fromRGBO(229, 229, 229, 1),
                              width: 0.5.w)),
                      onPressed: () {
                        ghepGiaPhaBloc.add(GhepPreviewEvent(
                            giaPhaId: widget.giaPhaId,
                            nhanhSrcChoosed: nhanhSrcChoosed,
                            nhanhDesChoosed: nhanhDesChoosed));
                      },
                      icon: SvgPicture.asset(
                        IconConstants.icSearch,
                        // package: PackageName.namePackageAddImage,
                      ),
                      label: Padding(
                        padding: EdgeInsets.only(left: 18.w),
                        child: Text(
                          'Xem trước',
                          style: Theme.of(context)
                              .tabBarTheme
                              .labelStyle
                              ?.copyWith(
                                  color:
                                      const Color.fromRGBO(255, 255, 255, 1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
