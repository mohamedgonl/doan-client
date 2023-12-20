import 'dart:convert';
import 'dart:io';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/components/profile_image.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/utils/validate_utils.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_thanhvien/quanly_thanhvien_bloc.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';

import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/option_widget.dart';
import 'package:giapha/shared/widget/textfield_shared.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

// import 'package:lichviet_flutter_base/widgets/date_picker_ver2/show_dialog_picker_view.dart';
import 'package:giapha/core/theme/theme_color.dart';

import 'package:permission_handler/permission_handler.dart';
import '../widget/tab_moi_quan_he.dart';

import '../../../../core/constants/icon_constrants.dart';
import '../../../../core/constants/image_constrants.dart';
import '../../../../shared/app_bar/ac_app_bar_button.dart';
import '../../../../shared/widget/dialog_notification.dart';

Widget quanLyThanhVienBuilder(
  BuildContext context,
  bool openRelationOptions,
  String giaPhaId,
  String? fid,
  String? mid,
  String? pid,
  MemberInfo? member, {
  bool onlyVoChong = false,
  bool addBoMe = false,
  bool saveCallApi = true,
  bool showTabBar = true,
}) =>
    BlocProvider<QuanLyThanhVienBloc>(
        create: (context) => GetIt.I<QuanLyThanhVienBloc>(),
        child: QuanLyThanhVienScreen(
          openRelationOptions,
          giaPhaId,
          fid,
          mid,
          pid,
          member,
          onlyVoChong: onlyVoChong,
          addBoMe: addBoMe,
          saveCallApi: saveCallApi,
          showTabBar: showTabBar,
        ));

class QuanLyThanhVienScreen extends StatefulWidget {
  final bool openRelationOptions;
  final String giaPhaId;
  final String? fid;
  final String? mid;
  final String? pid;
  final MemberInfo? memberInfo;
  final bool onlyVoChong;
  final bool addBoMe;
  final bool saveCallApi;
  final bool showTabBar;

  const QuanLyThanhVienScreen(
    this.openRelationOptions,
    this.giaPhaId,
    this.fid,
    this.mid,
    this.pid,
    this.memberInfo, {
    this.onlyVoChong = false,
    this.addBoMe = false,
    this.saveCallApi = true,
    this.showTabBar = true,
    super.key,
  });

  @override
  State<QuanLyThanhVienScreen> createState() => _QuanLyThanhVienScreenState();
}

class _QuanLyThanhVienScreenState extends State<QuanLyThanhVienScreen>
    with SingleTickerProviderStateMixin {
  // text controller

  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController tenKhacController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();

  final TextEditingController soDienThoaiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController ngheNghiepController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  final TextEditingController ngayMatController = TextEditingController();

  final TextEditingController tieuSuController = TextEditingController();

  final GlobalKey<FormState> _hoTenFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();

  // wrap controller
  WrapScrollController gioSinhScrollController =
      WrapScrollController(FixedExtentScrollController(initialItem: 0));

  // value notifier
  final ValueNotifier<int> moiQuanHeSelected = ValueNotifier(0);
  final ValueNotifier<int> gioiTinhSelected = ValueNotifier(0);
  final ValueNotifier<bool> daMatSelected = ValueNotifier(false);
  ValueNotifier<String> birthDate = ValueNotifier('');

  // image
  final ImagePicker _picker = ImagePicker();
  XFile? pickedFile;
  File? avatarFile;

  // date time
  DateTime cacheDateNgaySinh = DateTime(2020, 1, 1);
  DateTime cacheDateNgayMat = DateTime(2020, 1, 1);
  DateTime cacheDateNgayGio = DateTime(2020, 1, 1);

  // bloc
  late QuanLyThanhVienBloc quanLyThanhVienBloc;

  late TabController _tabController;

  final picker = ImagePicker();

  final widgetArrowSuffix = Padding(
    padding: EdgeInsets.only(right: 12.w),
    child: imageFromLocale(url: IconConstants.icButtonMore),
  );

  bool _unFocused = false;
  String maChiaSeHopLe = '';
  final ValueNotifier _showButtonSave = ValueNotifier(true);
  bool callRefreshMaChiaSe = false;
  String errorMaChiaSe = '';
  // final _platform = GetIt.I<MethodChannel>();

  void _unFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<void> _onImageButtonPressed(ImageSource source) async {
    _unFocus();
    if (Platform.isAndroid) {
      String path = '';
      if (source == ImageSource.camera) {
        // path = await _platform.invokeMethod(ChannelEndpoint.getImageFromCamera);
      } else if (source == ImageSource.gallery) {
        // path =
        //     await _platform.invokeMethod(ChannelEndpoint.getImageFromGallery);
      }
      if (path.isNotEmpty) {
        // final bytes = File(path).readAsBytesSync();
        // final result = base64Encode(bytes);
        // _accountInfoCubit.uploadAvatar(
        //     'jpeg', 'data:image/jpeg;base64,$result', 'user', 'avatar');
        // final croppedFile = await _cropImage(path);
        // if (croppedFile != null) {
        setState(() {
          avatarFile = File(path);
        });
        // }
      }
    } else {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.status;
        if (status == PermissionStatus.denied) {
          final statusCamera = await Permission.camera.request();
          if (statusCamera == PermissionStatus.denied) {
            return;
          }
          if (statusCamera == PermissionStatus.permanentlyDenied) {
            // ignore: use_build_context_synchronously
            showDialog(
                context: context,
                builder: (context) {
                  return DialogNotification(
                      title: 'Cấp quyền truy cập Máy ảnh',
                      content:
                          'Lịch Việt cần quyền truy cập Ảnh của bạn, vui lòng vào Settings > Privacy > Camera để bật',
                      okTitle: 'Cài đặt',
                      cancelTitle: 'Hủy',
                      onTapOk: () {
                        openAppSettings();
                      },
                      onTapCancel: () {
                        Navigator.pop(context);
                      });
                });
          }
        } else if (status == PermissionStatus.permanentlyDenied) {
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return DialogNotification(
                    title: 'Cấp quyền truy cập Máy ảnh',
                    content:
                        'Lịch Việt cần quyền truy cập Ảnh của bạn, vui lòng vào Settings > Privacy > Camera để bật',
                    okTitle: 'Cài đặt',
                    cancelTitle: 'Hủy',
                    onTapOk: () {
                      openAppSettings();
                    },
                    onTapCancel: () {
                      Navigator.pop(context);
                    });
              });
        }
      } else {
        final status = await Permission.photos.status;
        if (status == PermissionStatus.denied) {
          final statusCamera = await Permission.photos.request();
          if (statusCamera == PermissionStatus.denied) {
            return;
          }
        } else if (status == PermissionStatus.permanentlyDenied) {
          // ignore: use_build_context_synchronously
          showDialog(
              context: context,
              builder: (context) {
                return DialogNotification(
                    title: 'Cấp quyền truy cập Ảnh',
                    content:
                        'Lịch Việt cần quyền truy cập Ảnh của bạn, vui lòng vào Settings > Privacy > Photos để bật',
                    okTitle: 'Cài đặt',
                    cancelTitle: 'Hủy',
                    onTapOk: () {
                      openAppSettings();
                    },
                    onTapCancel: () {
                      Navigator.pop(context);
                    });
              });
          return;
        }
      }
      try {
        pickedFile = await _picker.pickImage(
          source: source,
        );
        if (pickedFile?.path != null && pickedFile!.path.isNotEmpty) {
          final img.Image? capturedImage =
              img.decodeImage(await File(pickedFile!.path).readAsBytes());
          if (capturedImage != null) {
            final img.Image orientedImage = img.bakeOrientation(capturedImage);
            final file = await File(pickedFile!.path)
                .writeAsBytes(img.encodeJpg(orientedImage));
            pickedFile = XFile(file.path);
          }
          final croppedFile = await _cropImage(pickedFile!.path);
          if (croppedFile != null) {
            setState(() {
              avatarFile = File(croppedFile.path);
            });
          }
        }
      } catch (e) {
        setState(() {});
      }
    }
  }

  Future<CroppedFile?> _cropImage(String path) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Chỉnh sửa ảnh',
            toolbarColor: ThemeColor.primary,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Chỉnh sửa ảnh',
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
    return croppedFile;
  }

  void _showActionSheet(BuildContext context) {
    _unFocus();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            /// This parameter indicates the action would be a default
            /// defualt behavior, turns the action's text to bold text.
            onPressed: () {
              Navigator.pop(context);
              _onImageButtonPressed(ImageSource.gallery);
            },
            child: const Text('Thư viện ảnh'),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              _onImageButtonPressed(ImageSource.camera);
            },
            child: const Text('Máy ảnh'),
          ),
          // CupertinoActionSheetAction(
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          //   child: const Text('Avatar Facebook'),
          // ),
          CupertinoActionSheetAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as delete or exit and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  void _showDialog(Widget child, Function()? onClickNgay, String title) {
    _unFocus();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Scaffold(
        backgroundColor: Colors.black.withOpacity(0.65),
        body: Column(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    SafeArea(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 23),
                          alignment: Alignment.topRight,
                          child: SvgPicture.asset(
                            IconConstants.icCancel,
                            height: 20.w,
                            width: 20.w,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox())
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                  color: Color(0xffF2F2F2),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      topLeft: Radius.circular(18))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Color(0xfff2f2f2),
                    ),
                    Text(
                      title,
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleSmall
                          ?.copyWith(color: const Color(0xff005cac)),
                    ),
                    InkWell(
                      onTap: onClickNgay,
                      child: const Icon(
                        Icons.check,
                        color: Color(0xff237BD3),
                      ),
                    ),
                  ]),
            ),
            Container(
              height: 216.h,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setAllTextFields({MemberInfo? memberInfo, bool hardReplace = true}) {
    if (memberInfo != null) {
      if (hardReplace) {
        hoTenController.text = memberInfo.ten ?? "";
        tenKhacController.text = memberInfo.tenKhac ?? "";
        if (memberInfo.ngaySinh.isNotNullOrEmpty) {
          ngaySinhController.text = DateTimeShared.dateTimeToStringDefault1(
              DateTimeShared.formatStringReverseToDate8(
                  memberInfo.ngaySinh ?? ""));
        } else {
          ngaySinhController.text = "";
        }

        soDienThoaiController.text = memberInfo.soDienThoai ?? "";
        emailController.text = memberInfo.email ?? "";
        ngheNghiepController.text = memberInfo.ngheNghiep ?? "";
        diaChiController.text = memberInfo.diaChiHienTai ?? "";

        daMatSelected.value =
            memberInfo.trangThaiMat == TrangThaiMatConst.daMat ? true : false;
        tieuSuController.text = memberInfo.tieuSu ?? "";
        if (daMatSelected.value == true) {
          ngayMatController.text = memberInfo.ngayMat.isNotNullOrEmpty
              ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(memberInfo.ngayMat!))} (ÂL)"
              : "";
        }
        gioiTinhSelected.value =
            memberInfo.gioiTinh == GioiTinhConst.nam ? 0 : 1;
      } else {
        if (hoTenController.text.isNullOrEmpty) {
          hoTenController.text = memberInfo.ten ?? "";
        }
        if (tenKhacController.text.isNullOrEmpty) {
          tenKhacController.text = memberInfo.tenKhac ?? "";
        }

        if (ngaySinhController.text.isNullOrEmpty) {
          if (memberInfo.ngaySinh != null) {
            ngaySinhController.text = DateTimeShared.dateTimeToStringDefault1(
                DateTimeShared.formatStringReverseToDate8(
                    memberInfo.ngaySinh ?? ""));
          } else {
            ngaySinhController.text = "";
          }
        }

        if (soDienThoaiController.text.isNullOrEmpty) {
          soDienThoaiController.text = memberInfo.soDienThoai ?? "";
        }
        if (emailController.text.isNullOrEmpty) {
          emailController.text = memberInfo.email ?? "";
        }

        if (ngheNghiepController.text.isNullOrEmpty) {
          ngheNghiepController.text = memberInfo.ngheNghiep ?? "";
        }
        if (diaChiController.text.isNullOrEmpty) {
          diaChiController.text = memberInfo.diaChiHienTai ?? "";
        }

        if (tieuSuController.text.isNullOrEmpty) {
          tieuSuController.text = memberInfo.tieuSu ?? "";
        }
      }
    }
  }

  _onTapCreateOrUpdate() async {
    if (!_hoTenFormKey.currentState!.validate()) {
      AnimatedSnackBar.material("Vui lòng nhập họ tên",
              type: AnimatedSnackBarType.warning,
              duration: const Duration(milliseconds: 2000))
          .show(context);
      return;
    }
    {
      String? avatarUploadFile;
      if (avatarFile != null) {
        final bytes = avatarFile!.readAsBytesSync();
        final result = base64Encode(bytes);
        avatarUploadFile = 'data:image/jpeg;base64,$result';
      }

      MemberInfo memberInfo = MemberInfo(
        memberId: widget.memberInfo?.memberId,
        depth: widget.memberInfo?.depth,
        thoiGianTao: widget.memberInfo?.thoiGianTao,
        trangThai: widget.memberInfo?.trangThai,
        userId: widget.memberInfo?.userId,
        giaPhaId: widget.giaPhaId,
        fid: widget.memberInfo?.fid,
        mid: widget.memberInfo?.mid,
        pid: widget.memberInfo?.pid,
        avatar: avatarUploadFile ?? widget.memberInfo?.avatar,
        ten: hoTenController.text.trim(),
        tenKhac: tenKhacController.text.trim(),
        gioiTinh: gioiTinhSelected.value == 0
            ? GioiTinhConst.nam
            : gioiTinhSelected.value == 1
                ? GioiTinhConst.nu
                : GioiTinhConst.khac,
        // chucVu: chucVuController.text,
        ngaySinh: ngaySinhController.text.isNotNullOrEmpty
            ? DateTimeShared.dateTimeToStringReverse(
                DateTimeShared.formatStringToDate8(ngaySinhController.text))
            : null,

        soDienThoai: soDienThoaiController.text.trim(),
        email: emailController.text.trim(),
        ngheNghiep: ngheNghiepController.text.trim(),
        diaChiHienTai: diaChiController.text.trim(),

        trangThaiMat: daMatSelected.value
            ? TrangThaiMatConst.daMat
            : TrangThaiMatConst.conSong,
        ngayMat: daMatSelected.value
            ? (ngayMatController.text.isNotNullOrEmpty
                ? DateTimeShared.dateTimeToStringReverse(cacheDateNgayMat)
                : null)
            : null,

        tieuSu: tieuSuController.text.trim(),
      );
      if (widget.memberInfo == null) {
        if (!widget.addBoMe) {
          // Nếu không phải trực hệ => chỉ có lựa chọn quan hệ "con"
          if (!widget.openRelationOptions) {
            if (!widget.onlyVoChong) {
              memberInfo.fid = widget.fid;
              memberInfo.mid = widget.mid;
            } else {
              memberInfo.pid = widget.pid;
            }
          } else {
            // Nếu chọn con
            if (moiQuanHeSelected.value == 1) {
              memberInfo.fid = widget.fid;
              memberInfo.mid = widget.mid;
            }
            // Nếu chọn vợ/chồng
            else {
              memberInfo.pid = widget.pid;
            }
          }
        }
      }
      if (widget.memberInfo == null) {
        quanLyThanhVienBloc.add(
            ThemThanhVienEvent(memberInfo, saveCallApi: widget.saveCallApi));
      } else {
        quanLyThanhVienBloc.add(
            SuaThanhVienEvent(memberInfo, saveCallApi: widget.saveCallApi));
      }
    }
  }

  late MemberInfo memberInfo;

  ValueNotifier<String> titleNotifier = ValueNotifier('');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    quanLyThanhVienBloc = BlocProvider.of<QuanLyThanhVienBloc>(context);
    // if (widget.memberInfo != null) {
    // }
    if (widget.memberInfo != null) {
      setAllTextFields(memberInfo: widget.memberInfo);
      titleNotifier.value = widget.memberInfo!.ten!;
      quanLyThanhVienBloc.add(LayThanhVienEvent(widget.memberInfo!.memberId!));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFBFB),
      appBar: AppBar(
        title: ValueListenableBuilder(
          valueListenable: titleNotifier,
          builder: (context, value, child) => Text(widget.memberInfo == null
              ? "Thêm thành viên"
              : titleNotifier.value),
        ),
        leading: AcAppBarButton.custom(
            // nút Back
            onPressed: () {
              Navigator.pop(context);
            },
            child: SvgPicture.asset(
              IconConstants.icBack,
              fit: BoxFit.cover,
              height: 19.h,
              width: 10.w,
              color: Colors.white,
            )),
        actions: [
          ValueListenableBuilder(
              valueListenable: _showButtonSave,
              builder: (context, _, __) {
                if (_showButtonSave.value) {
                  return AcAppBarButton.text(
                    "Lưu",
                    onPressed: _onTapCreateOrUpdate,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  );
                }
                return const SizedBox.shrink();
              }),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // if (widget.memberInfo != null && widget.showTabBar)
            //   Container(
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //             blurRadius: 2, color: Colors.black.withOpacity(0.15))
            //       ],
            //     ),
            //     child: TabBar(
            //       labelColor: const Color(0xff3F85FB),
            //       controller: _tabController,
            //       indicatorWeight: 3,
            //       indicatorColor: const Color(0xff3F85FB),
            //       tabs: const [
            //         Tab(
            //           child: Text("Cá Nhân"),
            //         ),
            //         // Tab(
            //         //   child: Text("Mối quan hệ"),
            //         // ),
            //       ],
            //       onTap: (index) {
            //         //setState(() {
            //         _tabController.index = index;
            //         if (index == 1 && _showButtonSave.value == true) {
            //           _showButtonSave.value = false;
            //         }
            //         if (index == 0 && _showButtonSave.value == false) {
            //           _showButtonSave.value = true;
            //         }
            //         //});
            //       },
            //     ),
            //   ),
            Expanded(
              child: BlocListener<QuanLyThanhVienBloc, QuanLyThanhVienState>(
                listener: (context, state) {
                  // if (state is QuanLyThanhVienLoading) {
                  //   EasyLoading.show();
                  // }
                  if (state is! QuanLyThanhVienLoading) {
                    EasyLoading.dismiss();
                  }
                  if (state is ThemThanhVienError) {
                    callRefreshMaChiaSe = false;
                    AnimatedSnackBar.material(
                            state.msg ?? "Thêm thành viên thất bại",
                            type: AnimatedSnackBarType.error,
                            duration: const Duration(milliseconds: 2000))
                        .show(context);
                  } else if (state is SuaThanhVienError) {
                    callRefreshMaChiaSe = false;
                    AnimatedSnackBar.material(
                            state.msg ?? "Cập nhập thành viên thất bại",
                            type: AnimatedSnackBarType.error,
                            duration: const Duration(milliseconds: 2000))
                        .show(context);
                  } else if (state is LayThanhVienSuccess) {
                    setAllTextFields(memberInfo: state.member.info);
                  }
              
                  if (state is SuaThanhVienSuccess) {
                    AnimatedSnackBar.material(
                            "Cập nhập thành viên thành công",
                            type: AnimatedSnackBarType.success,
                            duration: const Duration(milliseconds: 2000))
                        .show(context);
              
                    Navigator.pop(
                        context,
                        state.editedMemberInfo.copyWith(
                            soCon: widget.memberInfo?.soCon,
                            soVoChong: widget.memberInfo?.soVoChong));
                    // AppToast.share.showToast(
                    //     "Cập nhập thành viên thành công",
                    //     type: ToastType.success);
                  } else if (state is ThemThanhVienSuccess) {
                    AnimatedSnackBar.material(
                            "Thêm thành viên thành công",
                            type: AnimatedSnackBarType.success,
                            duration: const Duration(milliseconds: 2000))
                        .show(context);
              
                    Navigator.pop(
                      context,
                      state.newMemberInfo,
                    );
                  }
                },
                child: GestureDetector(
                  onTapUp: (detail) {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            height: 16.h,
                          ),
                          ProfileImage(
                              initals: "", memberInfo: widget.memberInfo),
                          SizedBox(
                            height: 16.h,
                          ),
                          Focus(
                            onFocusChange: (isFocus) {
                              if (!isFocus) {
                                _hoTenFormKey.currentState!.validate();
                              }
                            },
                            child: Form(
                              key: _hoTenFormKey,
                              child: TextFieldShared(
                                textController: hoTenController,
                                pathIcon: IconConstants.icHoTen,
                                title: 'Họ & tên',
                                hintText: 'Nhập họ & tên',
                                textInputType: TextInputType.name,
                                fieldRequired: true,
                                validate: (value) {
                                  if (value.isNotNullOrEmpty) {
                                    return null;
                                    // if (RegExp(
                                    //         r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$")
                                    //     .hasMatch(value!)) {
                                    //   return null;
                                    // } else {
                                    //   return 'Vui lòng nhập đúng tên người';
                                    // }
                                  } else {
                                    return 'Vui lòng nhập họ tên';
                                  }
                                },
                              ),
                            ),
                          ),
                          TextFieldShared(
                            textController: tenKhacController,
                            pathIcon: IconConstants.icHoTen,
                            title: 'Tên khác',
                            hintText: 'Nhập tên khác',
                          ),
                          if (widget.pid.isNotNullOrEmpty ||
                              widget.mid.isNotNullOrEmpty ||
                              widget.fid.isNotNullOrEmpty ||
                              widget.addBoMe)
                            Column(
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      IconConstants.icMoiQuanHe,
                                      package:
                                          PackageName.namePackageAddImage,
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    ),
                                    Text('Mối quan hệ',
                                        style: Theme.of(context)
                                            .primaryTextTheme
                                            .displaySmall
                                            ?.copyWith(
                                                color: const Color(
                                                    0xff666666))),
                                  ],
                                ),
                                ValueListenableBuilder(
                                    valueListenable: moiQuanHeSelected,
                                    builder: (context, value, child) {
                                      return OptionWidget(
                                          indexSelected:
                                              moiQuanHeSelected.value,
                                          onTap: (value) {
                                            moiQuanHeSelected.value =
                                                value;
                                          },
                                          listOption: widget.addBoMe
                                              ? ['Bố', 'Mẹ']
                                              : widget.openRelationOptions
                                                  ? ['Vợ/Chồng', 'Con']
                                                  : widget.onlyVoChong
                                                      ? ["Vợ/Chồng"]
                                                      : ["Con"]);
                                    }),
                                if (widget.memberInfo == null)
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      const Divider(
                                        height: 1,
                                      ),
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          Row(
                            children: [
                              SvgPicture.asset(IconConstants.icGioiTinh,
                                  package:
                                      PackageName.namePackageAddImage),
                              SizedBox(
                                width: 12.w,
                              ),
                              Text('Giới tính',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .displaySmall
                                      ?.copyWith(
                                          color:
                                              const Color(0xff666666))),
                            ],
                          ),
                          ValueListenableBuilder(
                              valueListenable: gioiTinhSelected,
                              builder: (context, value, child) {
                                return OptionWidget(
                                  indexSelected: gioiTinhSelected.value,
                                  onTap: (value) {
                                    gioiTinhSelected.value = value;
                                  },
                                  listOption: const ['Nam', 'Nữ'],
              
                                  // mainAxisAlignment:
                                  //     MainAxisAlignment.spaceBetween,
                                );
                              }),
                          SizedBox(
                            height: 18.h,
                          ),
                          TextFieldShared(
                            textController: ngaySinhController,
                            pathIcon: IconConstants.icNgaySinh,
                            title: 'Ngày sinh',
                            hintText: "Nhập ngày sinh",
                            textInputType: TextInputType.number,
                            // hasSuffixIcon: true,
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(14.w),
                              child: SvgPicture.asset(
                                IconConstants.icArrowDown,
                                width: 16.w,
                              ),
                            ),
                            readOnly: true,
                            enabled: false,
                            onClickField: () {
                              _showDialog(
                                CupertinoDatePicker(
                                  initialDateTime: ngaySinhController
                                          .text.isEmpty
                                      ? DateTime(2020, 1, 1)
                                      : DateTimeShared
                                          .formatStringToDate8(
                                              ngaySinhController.text),
                                  maximumDate:
                                      (daMatSelected.value == true &&
                                              ngayMatController
                                                  .text.isNotEmpty)
                                          ? cacheDateNgayMat
                                          : DateTime.now(),
                                  mode: CupertinoDatePickerMode.date,
                                  use24hFormat: true,
                                  onDateTimeChanged: (DateTime newDate) {
                                    cacheDateNgaySinh = newDate;
                                    // ngaySinhController.text = DateTimeShared
                                    //     .dateTimeToStringDefault1(newDate);
                                  },
                                ),
                                () {
                                  ngaySinhController.text = DateTimeShared
                                      .dateTimeToStringDefault1(
                                          cacheDateNgaySinh);
                                  Navigator.pop(context);
                                },
                                'CHỌN NGÀY SINH',
                              );
                            },
                          ),
                          Focus(
                            onFocusChange: (isFocus) {
                              if (!isFocus) {
                                if (_unFocused == false) {
                                  _unFocused = true;
                                }
                                _phoneFormKey.currentState!.validate();
                              }
                            },
                            child: Form(
                              key: _phoneFormKey,
                              child: TextFieldShared(
                                  textController: soDienThoaiController,
                                  pathIcon: IconConstants.icSdt,
                                  title: 'Số điện thoại',
                                  hintText: 'Nhập số điện thoại',
                                  textInputType: TextInputType.number,
                                  onChange: (value) {
                                    if (_unFocused) {
                                      _phoneFormKey.currentState!
                                          .validate();
                                    }
                                  },
                                  validate: ((p0) {
                                    if (p0.isNotNullOrEmpty) {
                                      final bool phoneReg = ValidateUtils
                                          .validatePhoneNumberSerivce(
                                              p0!);
                                      if (phoneReg) {
                                        return null;
                                      } else {
                                        if (p0.length != 10) {
                                          return 'Số điện thoại không hợp lệ. Vui lòng nhập đúng 10 số';
                                        } else {
                                          return 'Vui lòng nhập đúng số điện thoại của bạn';
                                        }
                                      }
                                    } else {
                                      return null;
                                    }
                                  })),
                            ),
                          ),
                          Focus(
                            onFocusChange: (isFocus) {
                              if (!isFocus) {
                                _emailFormKey.currentState!.validate();
                              }
                            },
                            child: Form(
                              key: _emailFormKey,
                              child: TextFieldShared(
                                textController: emailController,
                                pathIcon: IconConstants.icEmail,
                                title: 'Email',
                                hintText: 'Nhập email',
                                validate: ((p0) {
                                  if (p0.isNotNullOrEmpty) {
                                    final bool emailValid = RegExp(
                                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(p0!);
                                    if (emailValid) {
                                      return null;
                                    } else {
                                      return 'Vui lòng nhập email hợp lệ';
                                    }
                                  } else {
                                    return null;
                                  }
                                }),
                              ),
                            ),
                          ),
                          TextFieldShared(
                            textController: ngheNghiepController,
                            pathIcon: IconConstants.icNgheNghiep,
                            title: 'Nghề nghiệp',
                            hintText: "Nhập nghề nghiệp",
                          ),
                          TextFieldShared(
                            textController: diaChiController,
                            pathIcon: IconConstants.icDiaChi,
                            title: 'Địa chỉ',
                            hintText: "Nhập địa chỉ",
                            paddingBottom: 0,
                          ),
                          SizedBox(
                            height: 18.h,
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
                              Text('Tiểu sử',
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .displaySmall
                                      ?.copyWith(
                                          color:
                                              const Color(0xff666666))),
                            ],
                          ),
                          SizedBox(
                            height: 12.h,
                          ),
                          TextFormField(
                            controller: tieuSuController,
                            enableInteractiveSelection: true,
                            maxLines: 5,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 10.w,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffD8D8D8)),
                                    borderRadius:
                                        BorderRadius.circular(4)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffD8D8D8)),
                                    borderRadius:
                                        BorderRadius.circular(4)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffD8D8D8)),
                                    borderRadius:
                                        BorderRadius.circular(4)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xff3F85FB)),
                                    borderRadius:
                                        BorderRadius.circular(4))),
                          ),
                          SizedBox(
                            height: 22.h,
                          ),
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Đã mất',
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: const Color(0xff222222)),
                              ),
                              ValueListenableBuilder(
                                  valueListenable: daMatSelected,
                                  builder: (context, value, child) {
                                    return FlutterSwitch(
                                      width: 51.0,
                                      height: 31.0,
                                      toggleSize: 28.0,
                                      value: daMatSelected.value,
                                      borderRadius: 30.0,
                                      padding: 1.5,
                                      showOnOff: false,
                                      onToggle: (val) {
                                        setState(() {
                                          daMatSelected.value = val;
                                        });
                                      },
                                    );
                                  }),
                            ],
                          ),
                          SizedBox(
                            height: 18.h,
                          ),
                          if (daMatSelected.value)
                            // Column(
                            //   children: [
                            //     TextFieldShared(
                            //       textController: ngayMatController,
                            //       pathIcon: IconConstants.icNgayMat,
                            //       title: 'Ngày mất',
                            //       hintText: "Nhập ngày mất",
                            //       // hasSuffixIcon: true,
                            //       suffixIcon: Padding(
                            //         padding: EdgeInsets.all(14.w),
                            //         child: SvgPicture.asset(
                            //           IconBaseConstants.icArrowDown,
                            //           width: 16.w,
                            //         ),
                            //       ),
                            //       readOnly: true,
                            //       enabled: false,
                            //       onClickField: () {
                            //         _unFocus();
                            //         ShowDialogPickerView
                            //             .showDialogPickerV2(
                            //                 context: context,
                            //                 dateTime: cacheDateNgayMat,
                            //                 minDate: ngaySinhController
                            //                         .text.isNotEmpty
                            //                     ? cacheDateNgaySinh
                            //                     : null,
                            //                 maxDate: DateTime.now(),
                            //                 isLunar: true,
                            //                 onSelect: (date, isLunar) {
                            //                   cacheDateNgayMat = date;
                            //                   ngayMatController.text =
                            //                       "${DateTimeShared.convertSolarToLunar(date)} (ÂL)";
                            //                 });
                            //       },
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 21.h,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WrapScrollController {
  FixedExtentScrollController? controller;
  WrapScrollController(this.controller);
}
