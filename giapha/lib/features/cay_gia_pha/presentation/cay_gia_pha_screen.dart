import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/components/event_bus_handler.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/cay_gia_pha/bloc/xu_ly_nhieu_action/xu_ly_nhieu_action_bloc.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/cay_gia_pha/presentation/widget/tab_danh_sach.dart';
import 'package:giapha/features/danhsach_giapha/domain/entities/gia_pha_entity.dart';
import 'package:giapha/features/tim_kiem/presentation/tim_kiem_screen.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

import 'package:path_provider/path_provider.dart';
import '../../../shared/app_bar/ac_app_bar_button.dart';
import 'widget/tab_cay_pha_he.dart';

Widget cayGiaPhaBuilder(BuildContext context, GiaPha giaPha) =>
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => GetIt.I<CayGiaPhaBloc>()),
          BlocProvider(create: (context) => GetIt.I<XuLyNhieuActionBloc>()),
        ],
        child: CayGiaPhaScreen(
          giaPha: giaPha,
        ));

class CayGiaPhaScreen extends StatefulWidget {
  final GiaPha giaPha;
  const CayGiaPhaScreen({
    Key? key,
    required this.giaPha,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CayGiaPhaScreenState createState() => _CayGiaPhaScreenState();
}

enum PosiClickSave { back, tabDanhSach, appBar }

class _CayGiaPhaScreenState extends State<CayGiaPhaScreen>
    with SingleTickerProviderStateMixin {
  ValueNotifier stateEdit = ValueNotifier<bool>(false);
  ValueNotifier indexTab = ValueNotifier<int>(0);
  GlobalKey keyTopleft = GlobalKey(debugLabel: 'keyTopLeft');
  late TabController _tabController;
  GlobalKey<OverRepaintBoundaryState> globalKey = GlobalKey();
  GlobalKey<OverRepaintBoundaryState> globalKeyTabDanhSach = GlobalKey();
  ValueNotifier showUpdateMember = ValueNotifier(false);
  ValueNotifier showDownload = ValueNotifier(false);
  int indexStepTabCayPhaHe = 0;
  final refreshCayPhaHe = EventBusHandler();

  late XuLyNhieuActionBloc _xuLyNhieuActionBloc;
  late CayGiaPhaBloc cayGiaPhaBloc;
  @override
  void initState() {
    super.initState();
    cayGiaPhaBloc = BlocProvider.of<CayGiaPhaBloc>(context);
    _xuLyNhieuActionBloc = BlocProvider.of<XuLyNhieuActionBloc>(context);
    cayGiaPhaBloc.add(const ClearCacheEvent());
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _onTapDownload(GlobalKey captureKey) async {
    EasyLoading.instance.userInteractions = false;
    EasyLoading.show();

    final RenderRepaintBoundary renderRepaintBoundary =
        captureKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await renderRepaintBoundary.toImage(pixelRatio: 6);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List data = byteData!.buffer.asUint8List();
    final directory = (await getTemporaryDirectory()).path;
    File imgFile = File('$directory/screenshot.png');
    await imgFile.writeAsBytes(data, flush: true);
    GallerySaver.saveImage(imgFile.path).then(
      (value) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: InkWell(
                onTap: () {
                  //_onImageButtonPressed(ImageSource.gallery);
                },
                child: const Text("Tải xuống thành công"))));
      },
      // ignore: argument_type_not_assignable_to_error_handler
      onError: (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Tải xuống không thành công")));
      },
    );
    EasyLoading.instance.userInteractions = true;
    EasyLoading.dismiss();
  }

  Future<void> _onPressSave(PosiClickSave viTri) async {
    List<List<Member>> cayPhaHe =
        await cayGiaPhaBloc.getListMemberLocal(indexStepTabCayPhaHe);

    List<UserInfo> listCreate = [];
    List<String> listDelete = [];
    List<UserInfo> listUpdate = [];

    for (int i = 0; i < cayPhaHe.length; i++) {
      for (int j = 0; j < cayPhaHe[i].length; j++) {
        if (cayPhaHe[0][0].info != null) {
          if (cayPhaHe[i][j].info!.trangThaiNode == TrangThaiNode.create) {
            if (i == 0 && j == 0) {
              if (cayPhaHe[0][0].info!.root != null) {
                listCreate.add(cayPhaHe[0][0].info!.copyWith(root: 1));
              } else {
                listCreate.add(cayPhaHe[i][j].info!);
              }
            } else {
              listCreate.add(cayPhaHe[i][j].info!);
            }
          } else if (cayPhaHe[i][j].info!.trangThaiNode ==
              TrangThaiNode.delete) {
            if (cayPhaHe[i][j].info != null) {
              listDelete.add(cayPhaHe[i][j].info!.memberId ?? '');
            }
          } else if (cayPhaHe[i][j].info!.trangThaiNode ==
              TrangThaiNode.update) {
            listUpdate.add(cayPhaHe[i][j].info!);
          }
        }
        for (var element in cayPhaHe[i][j].pids!) {
          element.pid = cayPhaHe[i][j].info?.memberId;
          if (element.trangThaiNode == TrangThaiNode.create) {
            listCreate.add(element);
          } else if (element.trangThaiNode == TrangThaiNode.delete) {
            listDelete.add(element.memberId ?? '');
          } else if (element.trangThaiNode == TrangThaiNode.update) {
            listUpdate.add(element);
          }
        }
      }
    }

    _xuLyNhieuActionBloc.add(LuuNhieuAction(
        viTri: viTri,
        listCreated: listCreate,
        listIdDelete: listDelete,
        listUpdated: listUpdate,
        giaPhaId: widget.giaPha.id));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.giaPha.tenGiaPha),
          leading: BlocListener<XuLyNhieuActionBloc, XuLyActionState>(
            bloc: _xuLyNhieuActionBloc,
            listener: (context, state) {
              if (state is XuLyNhieuActionSuccess) {
                if (state.viTriClick == PosiClickSave.back) {
                  int soDoi = cayGiaPhaBloc.cayGiaPhaModel.rawData.length;
                  int soThanhVien =
                      cayGiaPhaBloc.cayGiaPhaModel.getMemberCount();
                  Navigator.pop(context, [soDoi, soThanhVien]);
                }
              } else if (state is XuLyNhieuActionError) {
                if (state.viTriClick == PosiClickSave.back) {
                  AnimatedSnackBar.material(state.msg,
                      type: AnimatedSnackBarType.error,
                      duration: const Duration(milliseconds: 2000));
                }
              }
            },
            child: AcAppBarButton.custom(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    try {
                      int soDoi = cayGiaPhaBloc.cayGiaPhaModel.rawData.length;
                      int soThanhVien =
                          cayGiaPhaBloc.cayGiaPhaModel.getMemberCount();
                      if (indexStepTabCayPhaHe != 0 &&
                          _tabController.index == 0) {
                        DialogShared.showDialogSelect(
                          context,
                          "Thông tin thành viên trong cây gia phả của bạn chưa được lưu. Bạn có muốn lưu không?",
                          textAlign: TextAlign.center,
                          leftButton: "Hủy bỏ",
                          onTapLeftButton: () {
                            Navigator.pop(context, [soDoi, soThanhVien]);
                          },
                          rightButton: "Lưu",
                          onTapRightButton: () async {
                            // call api
                            _onPressSave(PosiClickSave.back);
                          },
                          rootNavigate: true,
                        );
                      } else {
                        Navigator.pop(context, [soDoi, soThanhVien]);
                      }
                    } catch (e) {
                      Navigator.pop(context, [-1, -1]);
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
          ),
          actions: [
            ValueListenableBuilder(
                valueListenable: indexTab,
                builder: (context, _, __) {
                  if (indexTab.value == 0) {
                    return ValueListenableBuilder(
                        valueListenable: showUpdateMember,
                        builder: (context, _, __) {
                          if (showUpdateMember.value) {
                            return ValueListenableBuilder(
                                valueListenable: stateEdit,
                                builder: (context, _, __) {
                                  if (stateEdit.value) {
                                    return AcAppBarButton.text(
                                      "Lưu",
                                      onPressed: () {
                                        //stateEdit.value = !stateEdit.value;
                                        _onPressSave(PosiClickSave.appBar);
                                      },
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    );
                                  }
                                  return AcAppBarButton.custom(
                                      onPressed: () {
                                        stateEdit.value = !stateEdit.value;
                                      },
                                      child: SvgPicture.asset(
                                        IconConstants.icSuaChucVu,
                                        color: Colors.white,
                                        // package: "giapha",
                                      ));
                                });
                          }
                          return const SizedBox.shrink();
                        });
                  }

                  return const SizedBox.shrink();
                }),
            ValueListenableBuilder(
                valueListenable: showDownload,
                builder: (context, _, __) {
                  if (showDownload.value) {
                    return AcAppBarButton.custom(
                        onPressed: () {
                          _onTapDownload(_tabController.index == 0
                              ? globalKey
                              : globalKeyTabDanhSach);
                        },
                        child: SvgPicture.asset(
                          IconConstants.icDownload,
                          color: Colors.white,
                          package: PackageName.namePackageAddImage,
                        ));
                  }
                  return const SizedBox.shrink();
                }),
            AcAppBarButton.custom(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return timKiemScreen(idGiaPha: widget.giaPha.id);
                  }));
                },
                child: SvgPicture.asset(
                  IconConstants.icSearch,
                  color: Colors.white,
                  // package: PackageName.namePackageAddImage,
                )),
          ],
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
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
                    child: Text("Cây phả hệ"),
                  ),
                  Tab(
                    child: Text("Danh sách"),
                  ),
                  // Tab(
                  //   child: Text("Duyệt yêu cầu"),
                  // ),
                ],
                onTap: (index) async {
                  if (index == 0) {
                    indexStepTabCayPhaHe = 0;
                  }
                  _tabController.index = index;
                  indexTab.value = index;
                  if (indexStepTabCayPhaHe != 0 && _tabController.index != 0) {
                    await DialogShared.showDialogSelect(
                      context,
                      "Thông tin thành viên trong cây gia phả của bạn chưa được lưu. Bạn có muốn lưu không?",
                      textAlign: TextAlign.center,
                      leftButton: "Hủy bỏ",
                      onTapLeftButton: () {},
                      rightButton: "Lưu",
                      onTapRightButton: () {
                        // call api
                        _onPressSave(PosiClickSave.tabDanhSach);
                      },
                      rootNavigate: true,
                    );
                  } else {}
                },
              ),
            ),
            BlocListener(
              bloc: _xuLyNhieuActionBloc,
              listener: (context, state) {
                if (state is XuLyNhieuActionSuccess) {
                  if (state.viTriClick == PosiClickSave.appBar) {
                    indexStepTabCayPhaHe = 0;
                    stateEdit.value = false;
                    refreshCayPhaHe.fire('refresh');
                  } else if (state.viTriClick == PosiClickSave.tabDanhSach) {
                    indexStepTabCayPhaHe = 0;
                    stateEdit.value = false;
                    refreshCayPhaHe.fire('refresh_tab_danh_sach');
                  }
                } else if (state is XuLyNhieuActionError) {
                  if (state.viTriClick == PosiClickSave.appBar) {
                    AnimatedSnackBar.material(state.msg,
                        type: AnimatedSnackBarType.error,
                        duration: const Duration(milliseconds: 2000));
                  } else if (state.viTriClick == PosiClickSave.tabDanhSach) {
                    AnimatedSnackBar.material(state.msg,
                        type: AnimatedSnackBarType.error,
                        duration: const Duration(milliseconds: 2000));
                  }
                }
              },
              child: Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    // BlocListener<XuLyNhieuActionBloc, XuLyActionState>(
                    //   bloc: _xuLyNhieuActionBloc,
                    //   listener: (context, state) {
                    //     if (state is XuLyNhieuActionSuccess) {
                    //       if (state.viTriClick == PosiClickSave.appBar) {
                    //         indexStepTabCayPhaHe = 0;
                    //         stateEdit.value = false;
                    //         refreshCayPhaHe.fire('refresh');
                    //       }
                    //     } else if (state is XuLyNhieuActionError) {
                    //       if (state.viTriClick == PosiClickSave.appBar) {
                    //         AppToast.share
                    //             .showToast(state.msg, type: ToastType.error);
                    //       }
                    //     }
                    //   },
                    //   child:
                    TabCayPhaHe(
                      idGiaPha: widget.giaPha.id,
                      stateEdit: stateEdit,
                      callBackOut: (value) {
                        showUpdateMember.value = value;
                        showDownload.value = value;
                      },
                      callBackUpdateStep: (step) {
                        indexStepTabCayPhaHe = step;
                        if (step == 1) {
                          stateEdit.value = true;
                        }
                      },
                      refreshCayGiaPha: refreshCayPhaHe,
                      keyCapture: globalKey,
                      nameGiaPha: widget.giaPha.tenGiaPha,
                    ),
                    //),
                    // BlocListener<XuLyNhieuActionBloc, XuLyActionState>(
                    //   bloc: _xuLyNhieuActionBloc,
                    //   listener: (context, state) {
                    //     if (state is XuLyNhieuActionSuccess) {
                    //       if (state.viTriClick == PosiClickSave.tabDanhSach) {
                    //         indexStepTabCayPhaHe = 0;
                    //         stateEdit.value = false;
                    //         refreshCayPhaHe.fire('refresh_tab_danh_sach');
                    //       }
                    //     } else if (state is XuLyNhieuActionError) {
                    //       if (state.viTriClick == PosiClickSave.tabDanhSach) {
                    //         AppToast.share
                    //             .showToast(state.msg, type: ToastType.error);
                    //       }
                    //     }
                    //   },
                    //   child:
                    TabDanhSach(
                      idGiaPha: widget.giaPha.id,
                      nameGiaPha: widget.giaPha.tenGiaPha,
                      keyCapture: globalKeyTabDanhSach,
                      callBackOut: (value) {
                        showDownload.value = value;
                      },
                      refreshCayGiaPha: refreshCayPhaHe,
                    ),
                    //),

                    //TabDuyetYeuCau(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
