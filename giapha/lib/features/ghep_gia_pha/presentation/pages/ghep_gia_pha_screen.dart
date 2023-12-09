import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/danhsach_giapha/data/models/gia_pha_model.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/utils/toast_utils.dart';
import 'package:giapha/shared/widget/dropdownlist_shared.dart';
import 'package:giapha/shared/widget/textfield_shared.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

Widget ghepGiaPhaBuilder(
  BuildContext context,
  String giaPhaId, {
  String? idNhanhGhep,
}) =>
    BlocProvider(
        create: (context) => GetIt.I<GhepGiaPhaBloc>(),
        child: GhepGiaPhaScreen(
          giaPhaId,
          idNhanhGhep: idNhanhGhep,
        ));

class GhepGiaPhaScreen extends StatefulWidget {
  final String giaPhaId;
  final String? idNhanhGhep;
  const GhepGiaPhaScreen(
    this.giaPhaId, {
    super.key,
    this.idNhanhGhep,
  });

  @override
  State<GhepGiaPhaScreen> createState() => _GhepGiaPhaScreenState();
}

class _GhepGiaPhaScreenState extends State<GhepGiaPhaScreen> {
  late TextEditingController contentController;
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
    contentController = TextEditingController();
    ghepGiaPhaBloc = BlocProvider.of<GhepGiaPhaBloc>(context);
    danhsachNhanhDes = [];
    danhsachNhanhSrc = [];
    danhsachGiaPha = [];
    giaPhaChoosed = '';
    nhanhSrcChoosed = '';
    if (widget.idNhanhGhep != null) {
      nhanhDesChoosed = widget.idNhanhGhep!;
    } else {
      nhanhDesChoosed = '';
    }
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
          if (widget.idNhanhGhep != null) {
            int indexNhanh = danhsachNhanhDes.indexWhere(
                (element) => element.info?.memberId == widget.idNhanhGhep);
            if (indexNhanh != -1) {
              valueNhanhDesSelected = danhsachNhanhDes[indexNhanh];
            }
          }
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
                "Gửi",
                onPressed: () {
                  if (giaPhaChoosed.isNullOrEmpty) {
                    AppToast.share.showToast("Chưa chọn gia phả");
                    return;
                  }
                  if (nhanhSrcChoosed.isNullOrEmpty) {
                    if (danhsachNhanhSrc.isEmpty) {
                      AppToast.share.showToast(
                          "Gia phả muốn ghép chưa có thành viên nào");
                    } else {
                      AppToast.share.showToast(
                          "Chưa chọn nhánh muốn ghép vào");
                    }
                    return;
                  }
                  if (nhanhDesChoosed.isNullOrEmpty) {
                    AppToast.share.showToast("Chưa chọn ghép vào nhánh");
                    return;
                  }
                  if (contentController.text.isNullOrEmpty) {
                    AppToast.share.showToast("Chưa nhập nội dung");
                    return;
                  }

                  ghepGiaPhaBloc.add(GuiYeuCauGhepGiaPhaEvent(
                      contentController.text,
                      giaPhaChoosed: giaPhaChoosed,
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
                  TextFieldShared(
                    textController: contentController,
                    pathIcon: IconConstants.icMoTa,
                    title: 'Nội dung',
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
