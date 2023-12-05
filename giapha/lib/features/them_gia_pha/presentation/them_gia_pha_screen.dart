import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';
import 'package:giapha/features/them_gia_pha/presentation/bloc/them_gia_pha_bloc.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/utils/toast_utils.dart';
import 'package:giapha/shared/widget/textfield_shared.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

Widget themOrSuaGiaPhaBuilder(BuildContext context, GiaPha? giaPha) =>
    BlocProvider(
        create: (context) => GetIt.I<ThemGiaPhaBloc>(),
        child: ThemGiaPhaScreen(giaPha));

class ThemGiaPhaScreen extends StatefulWidget {
  final GiaPha? giaPha;
  const ThemGiaPhaScreen(this.giaPha, {super.key});

  @override
  State<ThemGiaPhaScreen> createState() => _ThemGiaPhaScreenState();
}

class _ThemGiaPhaScreenState extends State<ThemGiaPhaScreen> {
  TextEditingController tenGiaPhaController = TextEditingController();
  TextEditingController tenNhanhController = TextEditingController();
  TextEditingController diaChiController = TextEditingController();
  TextEditingController motaController = TextEditingController();
  late ThemGiaPhaBloc themGiaPhaBloc;

  @override
  void initState() {
    super.initState();
    if (widget.giaPha != null) {
      tenGiaPhaController.text = widget.giaPha!.tenGiaPha;
      tenNhanhController.text = widget.giaPha!.tenNhanh;
      diaChiController.text = widget.giaPha!.diaChi;
      motaController.text = widget.giaPha!.moTa;
    }
    themGiaPhaBloc = BlocProvider.of<ThemGiaPhaBloc>(context);
    themGiaPhaBloc.add(ThemGiaPhaInitEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("${widget.giaPha == null ? "Thêm" : "Sửa"} Gia Phả"),
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
              if (tenGiaPhaController.text.trim().isEmpty) {
                AppToast.share.showToast('Vui lòng nhập tên gia phả');
              } else {
                final ThemOrSuaGiaPhaEntity data = ThemOrSuaGiaPhaEntity(
                    giaPhaId: widget.giaPha?.id,
                    tenGiaPha: tenGiaPhaController.text.trim(),
                    tenNhanh: tenNhanhController.text.trim(),
                    diaChi: diaChiController.text.trim(),
                    moTa: motaController.text.trim());
                themGiaPhaBloc
                    .add(SaveThemOrSuaGiaPhaEvent(data, widget.giaPha?.id));
              }
            },
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
          ),
        ],
      ),
      body: BlocConsumer<ThemGiaPhaBloc, ThemGiaPhaState>(
          listener: (context, state) {
        if (state is! ThemGiaPhaLoading) {
          EasyLoading.dismiss();
        }
        if (state is ThemGiaPhaSuccess) {
          Fluttertoast.cancel();
          AppToast.share.showToast("Thêm gia phả thành công",type:  ToastType.success);
          Navigator.pop(context, true);
        } else if (state is ThemGiaPhaLoading) {
          EasyLoading.show();
        } else if (state is ThemGiaPhaError) {
          Fluttertoast.cancel();
          AppToast.share.showToast("Thêm gia phả thất bại", type:  ToastType.error);
        } else if (state is SuaGiaPhaError) {
          Fluttertoast.cancel();
          AppToast.share.showToast("Cập nhật gia phả thất bại", type:  ToastType.error);
        } else if (state is SuaGiaPhaSuccess) {
          Fluttertoast.cancel();
          AppToast.share.showToast("Cập nhật gia phả thành công", type:  ToastType.success);
          Navigator.pop(context, true);
        }
      }, builder: (context, state) {
        return GestureDetector(
          onTapUp: (detail) {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFieldShared(
                    textController: tenGiaPhaController,
                    pathIcon: IconConstants.icCodeShare,
                    title: 'Tên gia phả',
                    hintText: "Nhập tên gia phả",
                    fieldRequired: true,
                  ),
                  TextFieldShared(
                    textController: tenNhanhController,
                    pathIcon: IconConstants.icHoTen,
                    title: 'Tên nhánh',
                    hintText: "Nhập tên nhánh",
                  ),
                  TextFieldShared(
                    textController: diaChiController,
                    pathIcon: IconConstants.icDiaChi,
                    title: 'Địa chỉ',
                    hintText: "Nhập địa chỉ",
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        IconConstants.icMoTa,
                        package: PackageName.namePackageAddImage,
                      ),
                      SizedBox(
                        width: 12.w,
                      ),
                      Text('Mô tả',
                          style: Theme.of(context)
                              .primaryTextTheme
                              .displaySmall
                              ?.copyWith(color: const Color(0xff666666))),
                    ],
                  ),
                  SizedBox(
                    height: 12.h,
                  ),
                  TextFormField(
                    controller: motaController,
                    enableInteractiveSelection: true,
                    maxLines: 5,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 8.h, horizontal: 15.w),
                        border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffD8D8D8)),
                            borderRadius: BorderRadius.circular(4)),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffD8D8D8)),
                            borderRadius: BorderRadius.circular(4)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xffD8D8D8)),
                            borderRadius: BorderRadius.circular(4)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xff3F85FB)),
                            borderRadius: BorderRadius.circular(4))),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
