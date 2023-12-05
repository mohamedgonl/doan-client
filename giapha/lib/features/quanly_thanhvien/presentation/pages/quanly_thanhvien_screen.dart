import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/data/models/chucvu_model.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_chucvu/quanly_chucvu_bloc.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_thanhvien/quanly_thanhvien_bloc.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/widget/button_shared.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/option_widget.dart';
import 'package:giapha/shared/widget/textfield_shared.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/widgets/date_picker_ver2/show_dialog_picker_view.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widget/tab_moi_quan_he.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

import '../../../../core/constants/array_constrants.dart';
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
  List<String>? arrayMaChiaSe,
}) =>
    MultiBlocProvider(
        providers: [
          BlocProvider<QuanLyThanhVienBloc>(
              create: (context) => GetIt.I<QuanLyThanhVienBloc>()),
          BlocProvider<QuanLyChucVuBloc>(
              create: (context) => GetIt.I<QuanLyChucVuBloc>())
        ],
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
          arrayMaChiaSe: arrayMaChiaSe,
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
  final List<String>? arrayMaChiaSe;

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
    this.arrayMaChiaSe,
    super.key,
  });

  @override
  State<QuanLyThanhVienScreen> createState() => _QuanLyThanhVienScreenState();
}

class _QuanLyThanhVienScreenState extends State<QuanLyThanhVienScreen>
    with SingleTickerProviderStateMixin {
  // text controller
  final TextEditingController maChiaSeController = TextEditingController();
  final TextEditingController hoTenController = TextEditingController();
  final TextEditingController tenKhacController = TextEditingController();
  final TextEditingController ngaySinhController = TextEditingController();
  final TextEditingController gioSinhController = TextEditingController();
  final TextEditingController soDienThoaiController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController chucVuController = TextEditingController();
  final TextEditingController trinhDoController = TextEditingController();
  final TextEditingController ngheNghiepController = TextEditingController();
  final TextEditingController diaChiController = TextEditingController();
  final TextEditingController ngayMatController = TextEditingController();
  final TextEditingController ngayGioController = TextEditingController();
  final TextEditingController noiThoCungController = TextEditingController();
  final TextEditingController nguoiPhuTrachCungController =
      TextEditingController();
  final TextEditingController moTangController = TextEditingController();
  final TextEditingController tieuSuController = TextEditingController();
  final TextEditingController lyDoTrucXuatController = TextEditingController();
  final TextEditingController themChucVuController = TextEditingController();
  final TextEditingController suaChucVuController = TextEditingController();

  final GlobalKey<FormState> _maLichVietFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _hoTenFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _phoneFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _lydotrucxuatFormKey = GlobalKey<FormState>();

  // wrap controller
  WrapScrollController gioSinhScrollController =
      WrapScrollController(FixedExtentScrollController(initialItem: 0));

  // value notifier
  final ValueNotifier<int> moiQuanHeSelected = ValueNotifier(0);
  final ValueNotifier<int> gioiTinhSelected = ValueNotifier(0);
  final ValueNotifier<String> chucVuSelected = ValueNotifier("-1");
  final ValueNotifier<bool> daMatSelected = ValueNotifier(false);
  final ValueNotifier<bool> trucXuatSelected = ValueNotifier(false);
  ValueNotifier<String> birthDate = ValueNotifier('');

  List<ChucVuModel> chucVuOptions = [];

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
  late QuanLyChucVuBloc quanLyChucVuBloc;

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
  final _platform = GetIt.I<MethodChannel>();

  void _unFocus() {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  Future<void> _onImageButtonPressed(ImageSource source) async {
    _unFocus();
    if (Platform.isAndroid) {
      String path = '';
      if (source == ImageSource.camera) {
        path = await _platform.invokeMethod(ChannelEndpoint.getImageFromCamera);
      } else if (source == ImageSource.gallery) {
        path =
            await _platform.invokeMethod(ChannelEndpoint.getImageFromGallery);
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

  _showDialogChucVu(
    String title,
    String iconTitle,
    ValueNotifier notifiSelect,
    TextEditingController textController,
  ) {
    // List<String> optionsText = options.map((e) => e.tenChucVu).toList();
    _unFocus();
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: true,
        builder: (builder) {
          return BlocBuilder(
              bloc: quanLyChucVuBloc,
              builder: (context, setState) {
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
                                child: SafeArea(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 23),
                                    alignment: Alignment.topRight,
                                    child: SvgPicture.asset(
                                      IconConstants.icCancel,
                                      height: 20,
                                      width: 20,
                                      package: PackageName.namePackageAddImage,
                                    ),
                                  ),
                                ))),
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.45,
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
                                            child: imageFromLocale(
                                                url: iconTitle)),
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
                                thickness: 1,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      if (chucVuOptions.isEmpty)
                                        Center(
                                          heightFactor: 10.h,
                                          child: const Text("Chưa có chức vụ"),
                                        ),
                                      Expanded(
                                          child: ValueListenableBuilder(
                                              valueListenable: notifiSelect,
                                              builder: (context, value, child) {
                                                return OptionWidget(
                                                  indexSelected: chucVuOptions
                                                      .map((e) => e.id)
                                                      .toList()
                                                      .indexOf(
                                                          notifiSelect.value),
                                                  onTap: (value) {
                                                    Navigator.pop(context);
                                                    textController.text =
                                                        chucVuOptions
                                                            .map((e) =>
                                                                e.tenChucVu)
                                                            .toList()[value];
                                                    notifiSelect.value =
                                                        chucVuOptions
                                                            .map((e) => e.id)
                                                            .toList()[value];
                                                  },
                                                  listOption: chucVuOptions
                                                      .map((e) => e.tenChucVu)
                                                      .toList(),
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  verticalDirection: true,
                                                );
                                              })),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          if (chucVuOptions.isNotEmpty)
                                            Expanded(
                                              child: ButtonShared(
                                                title: "QUẢN LÝ CHỨC VỤ",
                                                onClickButton: () {
                                                  _showDialogQuanLyChucVu(
                                                    'QUẢN LÝ CHỨC VỤ',
                                                    IconConstants
                                                        .icQuanLyChucVu,
                                                  );
                                                },
                                                paddingHorizon: 15.w,
                                              ),
                                            ),
                                          ButtonShared(
                                            widthButton: 183.w,
                                            title: "THÊM MỚI",
                                            onClickButton: () {
                                              _showDialogThemSuaChucVu(
                                                  "THÊM CHỨC VỤ",
                                                  IconConstants.icThemChucVu,
                                                  //     (String newChucVU) {
                                                  //   print("CALL FUNCTION");
                                                  //   quanLyChucVuBloc.add(
                                                  //       ThemChucVuEvent(newChucVU));
                                                  // }
                                                  () {},
                                                  true,
                                                  null,
                                                  null);
                                            },
                                            paddingHorizon: 15.w,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 16.w,
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  _showDialogQuanLyChucVu(
    String title,
    String iconTitle,
  ) {
    _unFocus();
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return BlocBuilder(
              bloc: quanLyChucVuBloc,
              builder: (context, state) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      children: [
                        Expanded(
                            child: InkWell(
                                onTap: () {
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
                                      package: PackageName.namePackageAddImage,
                                    ),
                                  ),
                                ))),
                        Container(
                          height:
                              MediaQuery.of(context).copyWith().size.height *
                                  0.5,
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
                                            child: imageFromLocale(
                                                url: iconTitle)),
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
                              Expanded(
                                child: Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount: chucVuOptions.length,
                                            itemBuilder: ((context, index) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 24.w,
                                                            vertical: 16.h),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          chucVuOptions[index]
                                                              .tenChucVu,
                                                          style: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .displayMedium
                                                              ?.copyWith(
                                                                  color: const Color(
                                                                      0xff333333)),
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                suaChucVuController
                                                                        .text =
                                                                    chucVuOptions[
                                                                            index]
                                                                        .tenChucVu;
                                                                _showDialogThemSuaChucVu(
                                                                    "SỬA CHỨC VỤ",
                                                                    IconConstants
                                                                        .icThemChucVu,
                                                                    () {},
                                                                    false,
                                                                    chucVuOptions[
                                                                            index]
                                                                        .tenChucVu,
                                                                    chucVuOptions[
                                                                            index]
                                                                        .id);
                                                              },
                                                              child: imageFromLocale(
                                                                  url: IconConstants
                                                                      .icSuaChucVu),
                                                            ),
                                                            SizedBox(
                                                              width: 29.w,
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                DialogShared
                                                                    .showDialogSelect(
                                                                  context,
                                                                  'Bạn có chắc chắn muốn xoá chức vụ này?',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  leftButton:
                                                                      "Có",
                                                                  onTapLeftButton:
                                                                      () {
                                                                    quanLyChucVuBloc.add(
                                                                        XoaChucVuEvent(
                                                                            chucVuOptions[index].id));
                                                                  },
                                                                  rightButton:
                                                                      "Không",
                                                                  onTapRightButton:
                                                                      () {},
                                                                  rootNavigate:
                                                                      true,
                                                                );
                                                              },
                                                              child: imageFromLocale(
                                                                  url: IconConstants
                                                                      .icDeleteMember),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  if (index !=
                                                      chucVuOptions.length - 1)
                                                    Divider(
                                                      indent: 16.w,
                                                      endIndent: 16.w,
                                                      height: 1,
                                                    ),
                                                ],
                                              );
                                            })),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }

  _showDialogThemSuaChucVu(String title, String iconTitle, Function action,
      bool them, String? oldChucVu, String? idChucVu) {
    _unFocus();
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: SizedBox(
              height: MediaQuery.of(context).copyWith().size.height,
              //color: Colors.black.withOpacity(0.65),
              child: Column(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            themChucVuController.text = "";

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
                                package: PackageName.namePackageAddImage,
                              ),
                            ),
                          ))),
                  Container(
                    //height: 322.h,
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
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                child: TextFieldShared(
                                  textController: them
                                      ? themChucVuController
                                      : suaChucVuController,
                                  pathIcon: IconConstants.icNgheNghiep,
                                  title: "Tên chức vụ",
                                  noPrefixIcon: true,
                                  hintText: "Nhập tên chức vụ",
                                  paddingBottom: 0,
                                ),
                              ),
                              ButtonShared(
                                title: "LƯU",
                                onClickButton: () {
                                  if (them) {
                                    if (themChucVuController.text
                                        .trim()
                                        .isNotEmpty) {
                                      bool isContain = false;
                                      for (var e in chucVuOptions) {
                                        if (e.tenChucVu.toLowerCase() ==
                                            themChucVuController.text
                                                .trim()
                                                .toLowerCase()) {
                                          isContain = true;
                                          break;
                                        }
                                      }
                                      if (isContain) {
                                        AppToast.share.showToast(
                                            "Chức vụ đã có trong danh sách");
                                      } else {
                                        quanLyChucVuBloc.add(ThemChucVuEvent(
                                            themChucVuController.text.trim(),
                                            widget.giaPhaId));
                                        themChucVuController.text = "";
                                        Navigator.pop(context);
                                      }
                                    } else {
                                      AppToast.share
                                          .showToast("Chưa nhập chức vụ");
                                      AppToast.share
                                          .showToast("Chưa nhập chức vụ");
                                    }
                                  } else {
                                    if (suaChucVuController.text
                                        .trim()
                                        .isNotEmpty) {
                                      bool isContain = false;
                                      if ((suaChucVuController.text
                                              .trim()
                                              .toLowerCase() !=
                                          oldChucVu?.toLowerCase())) {
                                        for (var e in chucVuOptions) {
                                          if (e.tenChucVu.toLowerCase() ==
                                              suaChucVuController.text
                                                  .trim()
                                                  .toLowerCase()) {
                                            isContain = true;
                                            break;
                                          }
                                        }
                                      }
                                      if (isContain) {
                                        AppToast.share.showToast(
                                            "Chức vụ đã có trong danh sách");
                                      } else {
                                        quanLyChucVuBloc.add(CapNhapChucVuEvent(
                                            idChucVu!,
                                            suaChucVuController.text.trim()));
                                        suaChucVuController.text = "";
                                        Navigator.pop(context);
                                      }
                                    }
                                  }

                                  // themChucVuController.text = "";
                                },
                                paddingHorizon: 115.w,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _showBottomDialog(String title, WrapScrollController wrapScrollController,
      TextEditingController textController, List<String> options) {
    _unFocus();
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              height: MediaQuery.of(context).copyWith().size.height,
              color: Colors.black.withOpacity(0.65),
              child: Column(
                children: [
                  Expanded(
                      child: InkWell(
                          onTap: () {
                            wrapScrollController.controller =
                                FixedExtentScrollController(
                                    initialItem: wrapScrollController
                                        .controller!.initialItem);
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
                                package: PackageName.namePackageAddImage,
                              ),
                            ),
                          ))),
                  SizedBox(
                    height: MediaQuery.of(context).copyWith().size.height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
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
                                      ?.copyWith(
                                          color: const Color(0xff005cac)),
                                ),
                                InkWell(
                                  onTap: () {
                                    textController.text = options[
                                        wrapScrollController
                                            .controller!.selectedItem];
                                    wrapScrollController.controller =
                                        FixedExtentScrollController(
                                            initialItem: wrapScrollController
                                                .controller!.selectedItem);
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.check,
                                    color: Color(0xff237BD3),
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
                                    color:
                                        const Color(0xff3F85FB).withAlpha(20),
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
                            onSelectedItemChanged: (value) {
                              // textController.text = options[wrapScrollController
                              //     .controller!.selectedItem];
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void setAllTextFields({MemberInfo? memberInfo, bool hardReplace = true}) {
    if (memberInfo != null) {
      if (hardReplace) {
        hoTenController.text = memberInfo.ten ?? "";
        maChiaSeController.text = memberInfo.maChiaSe ?? "";
        tenKhacController.text = memberInfo.tenKhac ?? "";
        if (memberInfo.ngaySinh != null) {
          ngaySinhController.text = DateTimeShared.dateTimeToStringDefault1(
              DateTimeShared.formatStringReverseToDate8(
                  memberInfo.ngaySinh ?? ""));
        } else {
          ngaySinhController.text = "";
        }
        if (memberInfo.gioSinh == null || memberInfo.gioSinh == "-1") {
          gioSinhController.text = "";
        } else {
          gioSinhController.text = ArrayConstants.gioSinh
              .elementAt(int.parse(memberInfo.gioSinh ?? ""));
        }

        soDienThoaiController.text = memberInfo.soDienThoai ?? "";
        emailController.text = memberInfo.email ?? "";
        chucVuController.text = memberInfo.chucVu ?? "";
        chucVuSelected.value = memberInfo.chucVuId ?? "-1";
        trinhDoController.text = memberInfo.trinhDo ?? "";
        ngheNghiepController.text = memberInfo.ngheNghiep ?? "";
        diaChiController.text = memberInfo.diaChiHienTai ?? "";
        lyDoTrucXuatController.text = memberInfo.lyDoTrucXuat ?? "";

        daMatSelected.value =
            memberInfo.trangThaiMat == TrangThaiMatConst.daMat ? true : false;
        tieuSuController.text = memberInfo.tieuSu ?? "";
        if (daMatSelected.value == true) {
          ngayMatController.text = memberInfo.ngayMat.isNotNullOrEmpty
              ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(memberInfo.ngayMat!))} (ÂL)"
              : "";
          ngayGioController.text = memberInfo.ngayGio.isNotNullOrEmpty
              ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(memberInfo.ngayGio!))} (ÂL)"
              : "";
          noiThoCungController.text = memberInfo.noiThoCung ?? "";
          nguoiPhuTrachCungController.text = memberInfo.nguoiPhuTrachCung ?? "";
          moTangController.text = memberInfo.nguoiPhuTrachCung ?? "";
        }
        gioiTinhSelected.value =
            memberInfo.gioiTinh == GioiTinhConst.nam ? 0 : 1;
        trucXuatSelected.value =
            memberInfo.trucXuat == TrucXuatConst.biTrucXuat ? true : false;
        lyDoTrucXuatController.text = memberInfo.lyDoTrucXuat ?? "";
      } else {
        if (hoTenController.text.isNullOrEmpty ||
            memberInfo.maChiaSe.isNotNullOrEmpty) {
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
        if (gioSinhController.text.isNullOrEmpty) {
          if (memberInfo.gioSinh == null || memberInfo.gioSinh == "-1") {
            gioSinhController.text = "";
          } else {
            gioSinhController.text = ArrayConstants.gioSinh
                .elementAt(int.parse(memberInfo.gioSinh ?? ""));
          }
        }

        if (soDienThoaiController.text.isNullOrEmpty) {
          soDienThoaiController.text = memberInfo.soDienThoai ?? "";
        }
        if (emailController.text.isNullOrEmpty) {
          emailController.text = memberInfo.email ?? "";
        }
        //  if(chucVuController.text.isNullOrEmpty) chucVuController.text = memberInfo.chucVu ?? "";
        //  if(chucVuSelected.value.isNullOrEmpty) chucVuSelected.value = memberInfo.chucVuId ?? "-1";
        if (trinhDoController.text.isNullOrEmpty) {
          trinhDoController.text = memberInfo.trinhDo ?? "";
        }
        if (ngheNghiepController.text.isNullOrEmpty) {
          ngheNghiepController.text = memberInfo.ngheNghiep ?? "";
        }
        if (diaChiController.text.isNullOrEmpty) {
          diaChiController.text = memberInfo.diaChiHienTai ?? "";
        }
        // if(lyDoTrucXuatController.text.isNullOrEmpty)  lyDoTrucXuatController.text = memberInfo.lyDoTrucXuat ?? "";

        // daMatSelected.value =
        //     memberInfo.trangThaiMat == TrangThaiMatConst.daMat ? true : false;
        if (tieuSuController.text.isNullOrEmpty) {
          tieuSuController.text = memberInfo.tieuSu ?? "";
        }
        // if (daMatSelected.value == true) {
        //   ngayMatController.text = memberInfo.ngayMat.isNotNullOrEmpty
        //       ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(memberInfo.ngayMat!))} (ÂL)"
        //       : "";
        //   ngayGioController.text = memberInfo.ngayGio.isNotNullOrEmpty
        //       ? "${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(memberInfo.ngayGio!))} (ÂL)"
        //       : "";
        //   noiThoCungController.text = memberInfo.noiThoCung ?? "";
        //   nguoiPhuTrachCungController.text = memberInfo.nguoiPhuTrachCung ?? "";
        //   moTangController.text = memberInfo.nguoiPhuTrachCung ?? "";
        // }
        // gioiTinhSelected.value =
        //     memberInfo.gioiTinh == GioiTinhConst.nam ? 0 : 1;
        // trucXuatSelected.value =
        //     memberInfo.trucXuat == TrucXuatConst.biTrucXuat ? true : false;
        // lyDoTrucXuatController.text = memberInfo.lyDoTrucXuat ?? "";
      }
    }
  }

  _onTapCreateOrUpdate() async {
    if (trucXuatSelected.value) {
      _lydotrucxuatFormKey.currentState!.validate();
    }

    if (maChiaSeController.text.isNotEmpty &&
        widget.arrayMaChiaSe != null &&
        widget.arrayMaChiaSe!.isNotEmpty) {
      if (widget.arrayMaChiaSe!.contains(maChiaSeController.text)) {
        errorMaChiaSe = "Tồn tại thành viên có mã chia sẻ này";
        _maLichVietFormKey.currentState?.validate();
        return;
      }
    }

    if (maChiaSeController.text.isNotEmpty && callRefreshMaChiaSe == false) {
      callRefreshMaChiaSe = true;
      quanLyThanhVienBloc.add(
        XacThucMaLichVietEvent(maChiaSeController.text.trim(), widget.giaPhaId),
      );
      return;
    }
    if (!_hoTenFormKey.currentState!.validate()) {
      AppToast.share.showToast("Vui lòng nhập họ tên", type: ToastType.warning);
      return;
    }
    if (trucXuatSelected.value &&
        !_lydotrucxuatFormKey.currentState!.validate()) {
      if (trucXuatSelected.value == true &&
          lyDoTrucXuatController.text.isNullOrEmpty) {
        AppToast.share.showToast("Vui lòng nhập lí do trục xuất",
            type: ToastType.warning);
        return;
      }
    } else {
      String? avatarUploadFile;
      if (avatarFile != null) {
        final bytes = avatarFile!.readAsBytesSync();
        final result = base64Encode(bytes);
        avatarUploadFile = 'data:image/jpeg;base64,$result';
      }

      String? idChucVu;
      if (chucVuSelected.value == "-1") {
        idChucVu = null;
      } else {
        for (var e in chucVuOptions) {
          if (e.tenChucVu == chucVuController.text) {
            idChucVu = e.id;
          }
        }
      }

      MemberInfo memberInfo = MemberInfo(
        maChiaSe: maChiaSeHopLe,
        memberId: widget.memberInfo?.memberId,
        ancestorId: widget.memberInfo?.ancestorId,
        depth: widget.memberInfo?.depth,
        descendantId: widget.memberInfo?.descendantId,
        nguyenQuan: widget.memberInfo?.nguyenQuan,
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
        gioSinh: !ArrayConstants.gioSinh.contains(gioSinhController.text)
            ? null
            : ArrayConstants.gioSinh.indexOf(gioSinhController.text).toString(),
        soDienThoai: soDienThoaiController.text.trim(),
        email: emailController.text.trim(),
        chucVu:
            chucVuSelected.value == "-1" ? null : chucVuController.text.trim(),
        chucVuId: idChucVu,
        trinhDo: trinhDoController.text.trim(),
        ngheNghiep: ngheNghiepController.text.trim(),
        diaChiHienTai: diaChiController.text.trim(),

        trangThaiMat: daMatSelected.value
            ? TrangThaiMatConst.daMat
            : TrangThaiMatConst.conSong,
        moTang: daMatSelected.value ? moTangController.text.trim() : null,
        ngayMat: daMatSelected.value
            ? (ngayMatController.text.isNotNullOrEmpty
                ? DateTimeShared.dateTimeToStringReverse(cacheDateNgayMat)
                : null)
            : null,
        ngayGio: daMatSelected.value
            ? (ngayGioController.text.isNotNullOrEmpty
                ? DateTimeShared.dateTimeToStringReverse(cacheDateNgayGio)
                : null)
            : null,
        nguoiPhuTrachCung: daMatSelected.value
            ? nguoiPhuTrachCungController.text.trim()
            : null,
        noiThoCung:
            daMatSelected.value ? noiThoCungController.text.trim() : null,

        trucXuat: trucXuatSelected.value
            ? TrucXuatConst.biTrucXuat
            : TrucXuatConst.khongTrucXuat,
        lyDoTrucXuat:
            trucXuatSelected.value ? lyDoTrucXuatController.text : null,

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

    quanLyChucVuBloc = BlocProvider.of<QuanLyChucVuBloc>(context);
    quanLyThanhVienBloc = BlocProvider.of<QuanLyThanhVienBloc>(context);
    // if (widget.memberInfo != null) {
    quanLyChucVuBloc.add(LayChucVuEvent(widget.giaPhaId));
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
              if (widget.memberInfo == null) {
                Navigator.pop(context);
              } else {
                int? index;
                index = chucVuOptions.indexWhere(
                    (element) => element.id == widget.memberInfo?.chucVuId);
                // không tìm thấy id đã truyền vào
                if (index == -1) {
                  // trường hợp truyền vào null
                  if (widget.memberInfo?.chucVu == null) {
                    Navigator.pop(context);
                  }
                  // không truyền null nhưng vẫn không tìm thấy => chức vụ đã bị xoá
                  else {
                    MemberInfo? info = widget.memberInfo?.copyWith();
                    info?.chucVu = null;
                    info?.chucVuId = null;
                    Navigator.pop(context, info);
                  }
                }
                // tìm thấy id đã truyền
                else {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(
                        context,
                        chucVuOptions[index].tenChucVu !=
                                widget.memberInfo?.chucVu
                            ? widget.memberInfo?.copyWith(
                                chucVu: chucVuOptions[index].tenChucVu)
                            : null);
                  }
                }
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
            if (widget.memberInfo != null && widget.showTabBar)
              Container(
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
                      child: Text("Cá Nhân"),
                    ),
                    Tab(
                      child: Text("Mối quan hệ"),
                    ),
                  ],
                  onTap: (index) {
                    //setState(() {
                    _tabController.index = index;
                    if (index == 1 && _showButtonSave.value == true) {
                      _showButtonSave.value = false;
                    }
                    if (index == 0 && _showButtonSave.value == false) {
                      _showButtonSave.value = true;
                    }
                    //});
                  },
                ),
              ),
            Expanded(
              child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    BlocListener<QuanLyThanhVienBloc, QuanLyThanhVienState>(
                      listener: (context, state) {
                        print(state);
                        if (state is QuanLyThanhVienLoading) {
                          EasyLoading.show();
                        }
                        if (state is! QuanLyThanhVienLoading) {
                          EasyLoading.dismiss();
                        }
                        if (state is MaLichVietHopLe) {
                          maChiaSeHopLe = state.lichVietMember.id ?? '';
                          setAllTextFields(
                              memberInfo: MemberInfo(
                                  maChiaSe: widget.memberInfo?.maChiaSe,
                                  ten: state.lichVietMember.fullName),
                              hardReplace: false);

                          if (trucXuatSelected.value) {
                            _lydotrucxuatFormKey.currentState!.validate();
                          }
                          _hoTenFormKey.currentState!.validate();
                          if (callRefreshMaChiaSe) {
                            _onTapCreateOrUpdate();
                          }
                        } else if (state is ThemThanhVienError) {
                          callRefreshMaChiaSe = false;
                          AppToast.share.showToast(
                              state.msg ?? "Thêm thành viên thất bại",
                              type: ToastType.error);
                        } else if (state is SuaThanhVienError) {
                          callRefreshMaChiaSe = false;
                          AppToast.share.showToast(
                              state.msg ?? "Cập nhập thành viên thất bại",
                              type: ToastType.error);
                        } else if (state is LayThanhVienSuccess) {
                          setAllTextFields(memberInfo: state.member.info);
                        }

                        if (state is SuaThanhVienSuccess) {
                          AppToast.share.showToast(
                              "Cập nhập thành viên thành công",
                              type: ToastType.success);
                          for (var e in chucVuOptions) {
                            if (e.id == state.editedMemberInfo.chucVuId) {
                              state.editedMemberInfo.chucVu = e.tenChucVu;
                              break;
                            }
                          }
                          Navigator.pop(
                              context,
                              state.editedMemberInfo.copyWith(
                                  soCon: widget.memberInfo?.soCon,
                                  soVoChong: widget.memberInfo?.soVoChong));
                          // AppToast.share.showToast(
                          //     "Cập nhập thành viên thành công",
                          //     type: ToastType.success);
                        } else if (state is ThemThanhVienSuccess) {
                          for (var e in chucVuOptions) {
                            if (e.id == state.newMemberInfo.chucVuId) {
                              state.newMemberInfo.chucVu = e.tenChucVu;
                              break;
                            }
                          }
                          AppToast.share.showToast("Thêm thành viên thành công",
                              type: ToastType.success);
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
                                InkWell(
                                  onTap: () {
                                    _showActionSheet(context);
                                  },
                                  child: Stack(
                                    children: [
                                      SizedBox(
                                        width: 100.w,
                                        height: 100.w,
                                        child: Center(
                                          child: Container(
                                            width: 98.w,
                                            height: 98.w,
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                            ),
                                            child: SizedBox(
                                              width: 98.w,
                                              height: 98.w,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          49.w),
                                                  child: avatarFile != null
                                                      ? Image.file(
                                                          File(
                                                              avatarFile!.path),
                                                          fit: BoxFit.cover,
                                                        )
                                                      : (widget.memberInfo !=
                                                                  null &&
                                                              widget.memberInfo!
                                                                      .avatar !=
                                                                  null
                                                          ? CachedNetworkImage(
                                                              imageUrl: ImageNetworkUtils
                                                                  .getNetworkUrl(
                                                                      url: widget
                                                                          .memberInfo!
                                                                          .avatar!),
                                                              width: 98.w,
                                                              height: 98.w,
                                                              fit: BoxFit.cover,
                                                              errorWidget: (context,
                                                                      _, __) =>
                                                                  imageFromLocale(
                                                                      url: ImageConstants
                                                                          .imgDefaultAvatar),
                                                              placeholder: (context,
                                                                      _) =>
                                                                  imageFromLocale(
                                                                      url: ImageConstants
                                                                          .imgDefaultAvatar),
                                                            )
                                                          : SvgPicture.asset(
                                                              ImageConstants
                                                                  .imgDefaultAvatar,
                                                              width: 98.w,
                                                              height: 98.w,
                                                            ))),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                          bottom: 2.w,
                                          right: 2.w,
                                          child: Container(
                                            width: 28.w,
                                            height: 28.w,
                                            decoration: BoxDecoration(
                                              color: const Color(0xffE4E6EB),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                    color: Colors.black
                                                        .withOpacity(0.5))
                                              ],
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                IconConstants.icCamera,
                                                fit: BoxFit.cover,
                                                package: PackageName
                                                    .namePackageAddImage,
                                              ),
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 16.h,
                                ),
                                Focus(
                                  onFocusChange: (isFocus) {
                                    if (!isFocus) {
                                      quanLyThanhVienBloc.add(
                                        XacThucMaLichVietEvent(
                                            maChiaSeController.text.trim(),
                                            widget.giaPhaId),
                                      );
                                    }
                                  },
                                  child: BlocBuilder(
                                      bloc: quanLyThanhVienBloc,
                                      builder: (context, state) {
                                        String? errorText;
                                        if (state is MaLichVietKhongHopLe) {
                                          callRefreshMaChiaSe = false;
                                          errorText = state.msg;
                                        }
                                        return Form(
                                          key: _maLichVietFormKey,
                                          child: TextFieldShared(
                                            textController: maChiaSeController,
                                            pathIcon: IconConstants.icCodeShare,
                                            title: 'Mã chia sẻ',
                                            hintText: 'Nhập mã chia sẻ',
                                            errorText: errorText,
                                            textInputType: TextInputType.number,
                                            validate: (value) {
                                              if (errorMaChiaSe
                                                  .isNotNullOrEmpty) {
                                                return errorMaChiaSe;
                                              }
                                            },
                                            suffixIcon:
                                                (state is MaLichVietLoading)
                                                    ? Container(
                                                        margin: EdgeInsets.only(
                                                            right: 4.w),
                                                        child: SizedBox(
                                                            height: 4.h,
                                                            width: 4.w,
                                                            child:
                                                                const CircularProgressIndicator()),
                                                      )
                                                    : null,
                                          ),
                                        );
                                      }),
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
                                  title: 'Ngày sinh dương lịch',
                                  hintText: "Nhập ngày sinh dương lịch",
                                  textInputType: TextInputType.number,
                                  // hasSuffixIcon: true,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(14.w),
                                    child: SvgPicture.asset(
                                      IconBaseConstants.icArrowDown,
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
                                TextFieldShared(
                                  textController: gioSinhController,
                                  pathIcon: IconConstants.icGioSinh,
                                  title: 'Giờ sinh',
                                  hintText: "Nhập giờ sinh",
                                  textInputType: TextInputType.number,
                                  // hasSuffixIcon: true,
                                  readOnly: true,
                                  enabled: false,
                                  suffixIcon: Padding(
                                    padding: EdgeInsets.all(14.w),
                                    child: SvgPicture.asset(
                                      IconBaseConstants.icArrowDown,
                                      width: 16.w,
                                    ),
                                  ),
                                  onClickField: () {
                                    _showBottomDialog(
                                        'NHẬP GIỜ SINH',
                                        gioSinhScrollController,
                                        gioSinhController,
                                        ArrayConstants.gioSinh);
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
                                BlocConsumer<QuanLyChucVuBloc,
                                    QuanLyChucVuState>(
                                  listener: (context, state) {
                                    print(state);
                                    if (state is LayChucVuSuccess) {
                                      chucVuOptions = state.danhsachChucVu;
                                    } else if (state is CapNhapChucVuSuccess) {
                                      Fluttertoast.cancel();
                                      AppToast.share.showToast(
                                          "Cập nhập chức vụ thành công",
                                          type: ToastType.success);
                                      setState(() {
                                        chucVuOptions
                                            .firstWhere((element) =>
                                                element.id == state.chucVuId)
                                            .tenChucVu = state.tenChucVu;
                                        chucVuController.text = state.tenChucVu;
                                      });
                                    } else if (state is CapNhapChucVuError) {
                                      Fluttertoast.cancel();
                                      AppToast.share.showToast(
                                          "Cập nhập chức vụ thất bại",
                                          type: ToastType.error);
                                    } else if (state is XoaChucVuSuccess) {
                                      for (var e in chucVuOptions) {
                                        if (e.id == state.chucVuId) {
                                          chucVuOptions.remove(e);
                                          if (state.chucVuId ==
                                                  widget.memberInfo?.chucVuId ||
                                              chucVuSelected.value ==
                                                  state.chucVuId) {
                                            chucVuController.text = "";
                                          }
                                          break;
                                        }
                                      }
                                      // chucVuOptions.removeWhere((element) =>
                                      //     element.id == state.chucVuId);
                                      if (chucVuOptions.isEmpty) {
                                        Navigator.pop(context);
                                      }
                                      Fluttertoast.cancel();
                                      AppToast.share.showToast(
                                          "Xoá chức vụ thành công",
                                          type: ToastType.success);
                                    } else if (state is ThemChucVuSuccess) {
                                      chucVuOptions.add(state.chucVu);
                                      Fluttertoast.cancel();
                                      AppToast.share.showToast(
                                          "Thêm chức vụ mới thành công",
                                          type: ToastType.success);
                                    } else if (state is ThemChucVuError) {
                                      Fluttertoast.cancel();
                                      AppToast.share.showToast(
                                          "Thêm chức vụ mới thất bại",
                                          type: ToastType.error);
                                    }
                                  },
                                  builder: (context, state) {
                                    print(state);
                                    // print(chucVuOptions.map((e) => e.tenChucVu));
                                    // if (state is LayChucVuError) {
                                    //   return const ErrorCommonWidget(
                                    //       content: "Không có dữ liệu");
                                    // } else
                                    {
                                      return TextFieldShared(
                                        textController: chucVuController,
                                        pathIcon: IconConstants.icNgheNghiep,
                                        title: 'Chức vụ',
                                        hintText: "Chọn chức vụ",
                                        // hasSuffixIcon: true,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(14.w),
                                          child: SvgPicture.asset(
                                            IconBaseConstants.icArrowDown,
                                            width: 16.w,
                                          ),
                                        ),
                                        readOnly: true,
                                        enabled: false,
                                        onClickField: () {
                                          //load chuc vu

                                          _showDialogChucVu(
                                            'CHỌN CHỨC VỤ',
                                            IconConstants.icBigChucVu,
                                            chucVuSelected,
                                            chucVuController,
                                          );
                                        },
                                      );
                                    }
                                  },
                                ),
                                TextFieldShared(
                                  textController: trinhDoController,
                                  pathIcon: IconConstants.icTrinhDo,
                                  title: 'Trình độ',
                                  hintText: "Nhập trình độ",
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
                                              if (val == false) {
                                                ngayMatController.text = '';
                                                ngayGioController.text = '';
                                                noiThoCungController.text = '';
                                                nguoiPhuTrachCungController
                                                    .text = '';
                                                moTangController.text = '';
                                              }
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
                                  Column(
                                    children: [
                                      TextFieldShared(
                                        textController: ngayMatController,
                                        pathIcon: IconConstants.icNgayMat,
                                        title: 'Ngày mất',
                                        hintText: "Nhập ngày mất",
                                        // hasSuffixIcon: true,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(14.w),
                                          child: SvgPicture.asset(
                                            IconBaseConstants.icArrowDown,
                                            width: 16.w,
                                          ),
                                        ),
                                        readOnly: true,
                                        enabled: false,
                                        onClickField: () {
                                          _unFocus();
                                          ShowDialogPickerView
                                              .showDialogPickerV2(
                                                  context: context,
                                                  dateTime: cacheDateNgayMat,
                                                  minDate: ngaySinhController
                                                          .text.isNotEmpty
                                                      ? cacheDateNgaySinh
                                                      : null,
                                                  maxDate: DateTime.now(),
                                                  isLunar: true,
                                                  onSelect: (date, isLunar) {
                                                    cacheDateNgayMat = date;
                                                    ngayMatController.text =
                                                        "${DateTimeShared.convertSolarToLunar(date)} (ÂL)";
                                                  });
                                        },
                                      ),
                                      TextFieldShared(
                                        textController: ngayGioController,
                                        pathIcon: IconConstants.icNgayMat,
                                        title: 'Ngày giỗ',
                                        hintText: "Nhập ngày giỗ",
                                        //hasSuffixIcon: true,
                                        suffixIcon: Padding(
                                          padding: EdgeInsets.all(14.w),
                                          child: SvgPicture.asset(
                                            IconBaseConstants.icArrowDown,
                                            width: 16.w,
                                          ),
                                        ),
                                        readOnly: true,
                                        enabled: false,
                                        onClickField: () {
                                          _unFocus();
                                          ShowDialogPickerView
                                              .showDialogPickerV2(
                                                  context: context,
                                                  dateTime: cacheDateNgayGio,
                                                  maxDate: DateTime.now(),
                                                  minDate: ngaySinhController
                                                          .text.isNotEmpty
                                                      ? cacheDateNgaySinh
                                                      : null,
                                                  isLunar: true,
                                                  onSelect: (date, isLunar) {
                                                    cacheDateNgayGio = date;
                                                    ngayGioController.text =
                                                        "${DateTimeShared.convertSolarToLunar(date)} (ÂL)";
                                                  });
                                        },
                                      ),
                                      TextFieldShared(
                                        textController: noiThoCungController,
                                        pathIcon: IconConstants.icDiaChi,
                                        title: 'Nơi thờ cúng',
                                        hintText: "Nhập nơi thờ cúng",
                                      ),
                                      TextFieldShared(
                                        textController:
                                            nguoiPhuTrachCungController,
                                        pathIcon: IconConstants.icHoTen,
                                        title: 'Người phụ trách cúng giỗ',
                                        hintText: "Nhập tên",
                                      ),
                                      TextFieldShared(
                                        textController: moTangController,
                                        pathIcon: IconConstants.icMo,
                                        title: 'Mộ táng',
                                        hintText: "Nhập nơi mai táng",
                                      ),
                                    ],
                                  ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Trục xuất khỏi dòng họ',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: const Color(0xff222222)),
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: trucXuatSelected,
                                        builder: (context, value, child) {
                                          return FlutterSwitch(
                                            width: 51.0,
                                            height: 31.0,
                                            toggleSize: 28.0,
                                            value: trucXuatSelected.value,
                                            borderRadius: 30.0,
                                            padding: 1.5,
                                            showOnOff: false,
                                            onToggle: (val) {
                                              setState(() {
                                                trucXuatSelected.value = val;
                                              });
                                            },
                                          );
                                        }),
                                  ],
                                ),
                                Visibility(
                                  maintainState: true,
                                  visible: (trucXuatSelected.value),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 18.h,
                                      ),
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            IconConstants.icMoTa,
                                            package:
                                                PackageName.namePackageAddImage,
                                          ),
                                          SizedBox(
                                            width: 12.w,
                                          ),
                                          Text('Lý do bị trục xuất',
                                              style: Theme.of(context)
                                                  .primaryTextTheme
                                                  .displaySmall
                                                  ?.copyWith(
                                                      color: const Color(
                                                          0xff666666))),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 12.h,
                                      ),
                                      Focus(
                                        onFocusChange: (isFocus) {
                                          if (!isFocus) {
                                            _lydotrucxuatFormKey.currentState!
                                                .validate();
                                          }
                                        },
                                        child: Form(
                                          key: _lydotrucxuatFormKey,
                                          child: TextFormField(
                                            controller: lyDoTrucXuatController,
                                            enableInteractiveSelection: true,
                                            maxLines: 5,
                                            style: Theme.of(context)
                                                .primaryTextTheme
                                                .displayMedium!
                                                .copyWith(
                                                    color: const Color(
                                                        0xff222222)),
                                            onChanged: (value) {},
                                            validator: (value) {
                                              if (value.isNullOrEmpty) {
                                                return "Vui lòng nhập lý do trục xuất";
                                              } else {
                                                return null;
                                              }
                                            },
                                            decoration: InputDecoration(
                                              isCollapsed: true,
                                              isDense: true,
                                              contentPadding:
                                                  EdgeInsets.symmetric(
                                                      vertical: 8.h,
                                                      horizontal: 10.w),
                                              border: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xffD8D8D8),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              disabledBorder:
                                                  OutlineInputBorder(
                                                      borderSide:
                                                          const BorderSide(
                                                              color: Color(
                                                                  0xffD8D8D8)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xffD8D8D8)),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                    color: Color(0xff3F85FB),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(4)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 21.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    BlocProvider(
                        create: (context) => GetIt.I<QuanLyThanhVienBloc>(),
                        child: MoiQuanHeScreen(
                          memberId: widget.memberInfo?.memberId ?? "",
                          gioiTinhMember: widget.memberInfo?.gioiTinh ?? "",
                        ))
                  ]),
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
