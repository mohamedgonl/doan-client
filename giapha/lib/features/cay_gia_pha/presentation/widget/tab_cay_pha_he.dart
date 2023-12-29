import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/clone/graph/GraphView.dart';
import 'package:giapha/core/components/event_bus_handler.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';

import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/cay_gia_pha/presentation/widget/tab_danh_sach.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/widget/error_common_widget.dart';
import 'package:giapha/shared/widget/image.dart';
import 'dart:ui' as ui;
import 'package:giapha/shared/widget/no_data_widget.dart';

import 'package:giapha/core/theme/theme_styles.dart';
// import 'package:lichviet_flutter_base/core/core.dart';

class TabCayPhaHe extends StatefulWidget {
  final String idGiaPha;
  final ValueNotifier stateEdit;
  final Function(bool) callBackOut;
  final Function(int) callBackUpdateStep;
  final EventBusHandler refreshCayGiaPha;
  final GlobalKey keyCapture;
  final String nameGiaPha;
  const TabCayPhaHe({
    super.key,
    required this.idGiaPha,
    required this.stateEdit,
    required this.callBackOut,
    required this.callBackUpdateStep,
    required this.refreshCayGiaPha,
    required this.keyCapture,
    required this.nameGiaPha,
  });

  @override
  State<TabCayPhaHe> createState() => _TabCayPhaHeState();
}

class _TabCayPhaHeState extends State<TabCayPhaHe> {
  late CayGiaPhaBloc _cayGiaPhaBloc;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  late Graph graph;
  List<Node> listNode = [];
  List<String> listAssetIcon = [
    IconConstants.icAddMember,
    IconConstants.icDeleteMember,
    IconConstants.icGhepNhanh
  ];
  final TransformationController _transformationController =
      TransformationController();
  final TransformationController _transformationCapture =
      TransformationController();
  double maxWidthGiaPha = 0;
  double maxHeightGiaPha = 0;
  double translateWidth = 0;
  int indexStep = 0;
  int maxStep = 0;
  int memberIdTamThoi = 0;
  late StreamSubscription refreshSubscription;

  ValueNotifier selectedLife = ValueNotifier<int>(0);
  late int lengthLife;
  ValueKey keySlidable = const ValueKey(0);

  @override
  void initState() {
    graph = Graph();
    refreshSubscription = widget.refreshCayGiaPha.stream.listen((event) {
      if (event == 'refresh') {
        indexStep = 0;
        maxStep = 0;
        _cayGiaPhaBloc.add(const ClearCacheEvent());
        _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
      }
    });
    _cayGiaPhaBloc = BlocProvider.of<CayGiaPhaBloc>(context);
    _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));

    // set up transformation
    final zoomed = Matrix4.identity()
      ..translate(translateWidth)
      ..scale(
        0.7,
      );

    _transformationController.value = zoomed;
    lengthLife = 0;
    super.initState();
  }

  static Future<List<ui.Image>> _getSvgImageFromAssets(
      BuildContext context, List<String> svgAssertLink) async {
    final images = <ui.Image>[];
    for (var element in svgAssertLink) {
      final stringImage =
          await DefaultAssetBundle.of(context).loadString(element);
      DrawableRoot drawableRoot = await svg.fromSvgString(stringImage, 'key');
      ui.Picture picture = drawableRoot.toPicture(size: const Size(30, 30));
      ui.Image image = await picture.toImage(30.round(), 30.round());
      images.add(image);
    }
    return images;
  }

  Random r = Random();

  Widget nodeEdit(
      {required void Function() onClick, required String pathIcon}) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: 30.w,
        height: 30.w,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 0.5,
              color: const Color(0xffE5E5E5),
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 1),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.11))
            ]),
        child: Center(
          child: SvgPicture.asset(pathIcon,
              width: 18.w,
              height: 18.w,
              package: PackageName.namePackageAddImage),
        ),
      ),
    );
  }

  Widget widgetNode2(
    Node node, {
    bool nodeEndBranch = false,
    String? idNodeVoChongTrucHe,
    bool isNodeTrucHe = true,
  }) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              height: 38.w,
            ),
            SizedBox(
              height: 38.w,
            )
          ],
        ),
        Row(
          children: [
            if (isNodeTrucHe)
              SizedBox(
                width: 38.w,
              ),
            InkWell(
                onTap: () async {
                  UserInfo member = Node.castMemberInfoFromNode(node);
                  final reload = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => quanLyThanhVienBuilder(
                              context,
                              false,
                              widget.idGiaPha,
                              null,
                              null,
                              null,
                              member)));
                  if (reload ?? false) {
                    _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
                  }
                },
                child: Container(
                    width: 215.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          width: 2, color: Color.fromARGB(255, 126, 24, 24)),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.11))
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 12.w, left: 9.w, right: 9.w),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 68.w,
                                height: 68.w,
                                child: node.avatar != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(33.w),
                                        child: (node.avatar != null
                                            ? CachedNetworkImage(
                                                imageUrl: ImageNetworkUtils
                                                    .getNetworkUrl(
                                                        url: node.avatar!),
                                                fit: BoxFit.cover,
                                                errorWidget: (context, _, __) =>
                                                    Image.asset(ImageConstants
                                                        .imgDefaultAvatar),
                                                placeholder: (context, _) =>
                                                    imageFromLocale(
                                                        url: ImageConstants
                                                            .imgDefaultAvatar),
                                              )
                                            : imageFromLocale(
                                                url: ImageConstants
                                                    .imgDefaultAvatar)))
                                    : imageFromLocale(
                                        url: ImageConstants.imgDefaultAvatar),
                              ),
                              SizedBox(
                                height: 18.w,
                              ),
                              Text(
                                node.ten.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall
                                    ?.copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              (node.ngaySinh.isNotNullOrEmpty ||
                                      node.ngayMat.isNotNullOrEmpty)
                                  ? Text(
                                      "${node.ngayMat.isNotNullOrEmpty ? '' : "Ngày sinh: "}${node.ngaySinh.isNotNullOrEmpty ? "${DateTimeShared.dateTimeToStringDefault1(DateTimeShared.formatStringReverseToDate8(node.ngaySinh!))}(DL)" : ""} ${node.trangThaiMat == TrangThaiMatConst.daMat ? (node.ngayMat.isNotNullOrEmpty ? "${node.ngaySinh.isNullOrEmpty ? "Ngày mất:" : " -"} ${"${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(node.ngayMat!))}(ÂL)"}" : "") : ''}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff333333),
                                          height: 1.5),
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff333333),
                                          height: 1.5),
                                    ),
                              SizedBox(
                                height: 13.w,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox.shrink()
                      ],
                    ))),
            SizedBox(
              width: 38.w,
            ),
          ],
        ),
        SizedBox(
          height: 38.w,
        )
      ],
    );
  }

  Widget widgetNode(
    Node node, {
    bool nodeEndBranch = false,
    bool isNodeTrucHe = true,
    String? idNodeVoChongTrucHe,
    required Function() onTapDeleteNode,
    required Function() onClickUpdate,
    required Function(UserInfo) onClickAddVoChong,
    required Function(UserInfo) onClickAddCon,
    required Function(UserInfo) onClickAddBoMe,
  }) {
    return Container(
      //color: Colors.red.withOpacity(0.3),
      child: Column(
        children: [
          // icon phia tren
          Row(
            children: [
              (widget.stateEdit.value &&
                      node.memberId == graph.nodes[0].memberId)
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 8.w),
                      child: nodeEdit(
                          onClick: () async {
                            // thêm bố mẹ cho gốc
                            final info = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: ((context) {
                                  return quanLyThanhVienBuilder(
                                    context,
                                    true,
                                    widget.idGiaPha,
                                    null,
                                    null,
                                    null,
                                    null,
                                    saveCallApi: false,
                                    addBoMe: true,
                                  );
                                }),
                              ),
                            );
                            if (info != null && info is UserInfo) {
                              onClickAddBoMe(info);
                            }
                          },
                          pathIcon: IconConstants.icAddMember),
                    )
                  : SizedBox(
                      height: 38.w,
                    ),
              // (widget.stateEdit.value && (node.fid != null || node.mid != null))
              //     ? Padding(
              //         padding: EdgeInsets.only(bottom: 8.w),
              //         child: nodeEdit(
              //             onClick: () {
              //               Navigator.push(context,
              //                   MaterialPageRoute(builder: (context) {
              //                 return ghepGiaPhaBuilder(context, widget.idGiaPha,
              //                     idNhanhGhep: node.memberId);
              //               }));
              //             },
              //             pathIcon: IconConstants.icGhepNhanh),
              //       )
              //     :
              SizedBox(
                height: 38.w,
              )
            ],
          ),
          // icon ngang va node
          Row(
            children: [
              if (isNodeTrucHe)
                SizedBox(
                  width: 38.w,
                ),
              InkWell(
                onTap: onClickUpdate,
                child: Container(
                    width: 215.w,
                    height: 200.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                          width: 0.5, color: const Color(0xffE5E5E5)),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 6,
                            color: Colors.black.withOpacity(0.11))
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.only(top: 12.w, left: 9.w, right: 9.w),
                          child: Column(
                            children: [
                              SizedBox(
                                width: 68.w,
                                height: 68.w,
                                child: node.avatar != null
                                    ? ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(33.w),
                                        child: (node.avatar != null
                                            ? CachedNetworkImage(
                                                imageUrl: ImageNetworkUtils
                                                    .getNetworkUrl(
                                                        url: node.avatar!),
                                                fit: BoxFit.cover,
                                                errorWidget: (context, _, __) =>
                                                    Image.asset(ImageConstants
                                                        .imgDefaultAvatar),
                                                placeholder: (context, _) =>
                                                    imageFromLocale(
                                                        url: ImageConstants
                                                            .imgDefaultAvatar),
                                              )
                                            : imageFromLocale(
                                                url: ImageConstants
                                                    .imgDefaultAvatar)))
                                    : imageFromLocale(
                                        url: ImageConstants.imgDefaultAvatar),
                              ),
                              SizedBox(
                                height: 18.w,
                              ),
                              Text(
                                node.ten.toString(),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall
                                    ?.copyWith(color: Colors.black),
                              ),
                              SizedBox(
                                height: 10.w,
                              ),
                              (node.ngaySinh.isNotNullOrEmpty ||
                                      node.ngayMat.isNotNullOrEmpty)
                                  ? Text(
                                      "${node.ngayMat.isNotNullOrEmpty ? '' : "Ngày sinh: "}${node.ngaySinh.isNotNullOrEmpty ? "${DateTimeShared.dateTimeToStringDefault1(DateTimeShared.formatStringReverseToDate8(node.ngaySinh!))}(DL)" : ""} ${node.trangThaiMat == TrangThaiMatConst.daMat ? (node.ngayMat.isNotNullOrEmpty ? "${node.ngaySinh.isNullOrEmpty ? "Ngày mất:" : " -"} ${"${DateTimeShared.convertSolarToLunar(DateTimeShared.formatStringReverseToDate8(node.ngayMat!))}(ÂL)"}" : "") : ''}",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff333333),
                                          height: 1.5),
                                    )
                                  : Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff333333),
                                          height: 1.5),
                                    ),
                              SizedBox(
                                height: 15.w,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox.shrink()
                      ],
                    )),
              ),
              (widget.stateEdit.value && nodeEndBranch)
                  ? Padding(
                      padding: EdgeInsets.only(left: 8.w, bottom: 30.h),
                      child: nodeEdit(
                          onClick: () async {
                            // thêm vợ chồng
                            final info = await Navigator.of(context)
                                .push(MaterialPageRoute(builder: ((context) {
                              return quanLyThanhVienBuilder(
                                context,
                                false,
                                widget.idGiaPha,
                                null,
                                null,
                                idNodeVoChongTrucHe,
                                null,
                                onlyVoChong: true,
                                saveCallApi: false,
                              );
                            })));
                            if (info != null && info is UserInfo) {
                              onClickAddVoChong(info);
                            }
                          },
                          pathIcon: IconConstants.icAddMember),
                    )
                  : SizedBox(
                      width: 38.w,
                    ),
            ],
          ),
          // icon delete
          (widget.stateEdit.value)
              ? Column(
                  children: [
                    SizedBox(
                      height: 8.w,
                    ),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              right: (node.fid != null ||
                                      node.mid != null ||
                                      node.memberId == graph.nodes[0].memberId)
                                  ? 0
                                  : 38.w),
                          child: nodeEdit(
                              onClick: () {
                                DialogShared.showDialogSelect(
                                  context,
                                  "Bạn có chắc chắn muốn xoá thành viên này không?",
                                  textAlign: TextAlign.center,
                                  leftButton: "Có",
                                  onTapLeftButton: onTapDeleteNode,
                                  rightButton: "Không",
                                  onTapRightButton: () {},
                                  rootNavigate: true,
                                );
                              },
                              pathIcon: IconConstants.icDeleteMember),
                        ),
                        if (node.fid != null ||
                            node.mid != null ||
                            node.memberId == graph.nodes[0].memberId)
                          Row(
                            children: [
                              SizedBox(
                                width: 30.w,
                              ),
                              nodeEdit(
                                  onClick: () async {
                                    // them con
                                    final info = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) {
                                      return quanLyThanhVienBuilder(
                                        context,
                                        false,
                                        widget.idGiaPha,
                                        node.memberId,
                                        null,
                                        null,
                                        null,
                                        saveCallApi: false,
                                      );
                                    })));
                                    if (info != null && info is UserInfo) {
                                      onClickAddCon(info);
                                    }
                                  },
                                  pathIcon: IconConstants.icAddMember),
                            ],
                          ),
                      ],
                    ),
                  ],
                )
              : SizedBox(
                  height: 38.w,
                )
        ],
      ),
    );
  }

  List<List<Member>> cloneGiaPhaDeleteNode(
      List<List<Member>> listMember, String? idNode) {
    List<List<Member>> listMemberTemp = [];
    for (int i = 0; i < listMember.length; i++) {
      List<Member> listTemp = [];
      for (int j = 0; j < listMember[i].length; j++) {
        if (listMember[i][j].info?.memberId != idNode) {
          // TH xóa vợ
          if (listMember[i][j]
              .pids!
              .any((element) => element.memberId == idNode)) {
            List<UserInfo> pidsNew = [];
            for (var voChong in listMember[i][j].pids!) {
              if (voChong.memberId != idNode) {
                pidsNew.add(voChong.copyWith());
              } else {
                pidsNew
                    .add(voChong.copyWith(trangThaiNode: TrangThaiNode.delete));
              }
            }
            listTemp.add(listMember[i][j].copyWith(pids: pidsNew));
          } else {
            listTemp.add(listMember[i][j].copyWith());
          }
        } else {
          listTemp.add(
            listMember[i][j].copyWith(
              info: listMember[i][j].info?.copyWith(
                    trangThaiNode: TrangThaiNode.delete,
                  ),
            ),
          );
        }
      }
      if (listTemp.isNotEmpty) {
        listMemberTemp.add(listTemp);
      }
    }

    return listMemberTemp;
  }

  void setMaxStep(int step) {
    if (step > maxStep) {
      maxStep = step;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: BlocConsumer<CayGiaPhaBloc, CayGiaPhaState>(
              bloc: _cayGiaPhaBloc,
              listener: (context, state) {
                if (state is XoaThanhVienSuccess) {
                  _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
                } else if (state is GetCayGiaPhaSuccess) {
                  if (state.listMember.isEmpty) {
                    widget.callBackOut(false);
                  } else {
                    widget.callBackOut(true);
                  }
                }
              },
              builder: ((context, state) {
                if (state is CayGiaPhaLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is GetCayGiaPhaSuccess) {
                  List<String> listIdEndBranch = [];
                  List<String> listIdHeadBranch = [];

                  if (indexStep == 0) {
                    _cayGiaPhaBloc.add(
                      SaveLocalCayGiaPha(state.listMember,
                          indexStep: indexStep),
                    );
                  }

                  if (state.listMember.isNotEmpty) {
                    Paint paintEdge = Paint()
                      ..color = const Color.fromARGB(255, 216, 216, 216)
                      ..strokeWidth = 4;

                    graph = Graph()..isTree = true;

                    for (int i = 0; i < state.listMember.length; i++) {
                      for (int j = 0; j < state.listMember[i].length; j++) {
                        final Node nodeFocus =
                            Member.castNode(state.listMember[i][j]);

                        listNode.add(nodeFocus);

                        bool noDrawVoChong = false;

                        if (nodeFocus.depth == 0) {
                          graph.addNode(nodeFocus);
                        } else {
                          if (nodeFocus.fid != null) {
                            final int indexFather = state.listMember[i - 1]
                                .indexWhere((element) =>
                                    element.info?.memberId == nodeFocus.fid);
                            if (indexFather != -1) {
                              if (graph.nodes.any((element) =>
                                      element.memberId ==
                                      state.listMember[i - 1][indexFather].info
                                          ?.memberId) &&
                                  nodeFocus.trangThaiNode !=
                                      TrangThaiNode.delete) {
                                graph.addNode(nodeFocus);

                                graph.addEdge(
                                    Member.castNode(
                                        state.listMember[i - 1][indexFather]),
                                    nodeFocus,
                                    paint: paintEdge);
                              } else {
                                noDrawVoChong = true;
                              }
                            }
                          } else {
                            graph.addNode(nodeFocus);
                          }
                        }
                        if (noDrawVoChong == false) {
                          if (nodeFocus.pids != null &&
                              nodeFocus.pids!.isNotEmpty) {
                            for (var element in state.listMember[i][j].pids!) {
                              final Node nodeVoChong =
                                  Member.castNodeFromMemberInfo(element);
                              if (nodeVoChong.trangThaiNode !=
                                  TrangThaiNode.delete) {
                                graph.addNode(nodeVoChong);
                              }
                            }
                            final pidAdd = nodeFocus.pids?.lastIndexWhere(
                                (element) => !element.contains("da_xoa"));
                            if (pidAdd != null && pidAdd != -1) {
                              listIdEndBranch.add(nodeFocus.pids![pidAdd]);
                            } else {
                              listIdEndBranch.add(nodeFocus.memberId ?? "");
                            }
                          } else {
                            listIdEndBranch.add(nodeFocus.memberId ?? "");
                          }
                        }
                        listIdHeadBranch.add(nodeFocus.memberId ?? "");
                      }
                    }

                    print(listIdHeadBranch);

                    Future.delayed(const Duration(microseconds: 0), () {
                      for (var element in graph.nodes) {
                        if (maxWidthGiaPha < (element.x + element.width)) {
                          maxWidthGiaPha = element.x + element.width;
                        }
                        if (maxHeightGiaPha < (element.y + element.height)) {
                          maxHeightGiaPha = element.y + element.height;
                        }
                      }

                      double scale = 0;
                      if (ScreenUtil().screenWidth / maxWidthGiaPha <
                          ((ScreenUtil().screenHeight -
                                  155.w -
                                  94.h -
                                  ScreenUtil().statusBarHeight) /
                              maxHeightGiaPha)) {
                        scale = ScreenUtil().screenWidth / maxWidthGiaPha;
                      } else {
                        scale = (ScreenUtil().screenHeight -
                                155.w -
                                94.h -
                                ScreenUtil().statusBarHeight) /
                            maxHeightGiaPha;
                        translateWidth = (ScreenUtil().screenWidth -
                                (maxWidthGiaPha * scale)) /
                            2;
                      }
                      // set up transformation
                      final zoomed = Matrix4.identity()
                        ..translate(translateWidth)
                        ..scale(
                          scale,
                        );

                      _transformationCapture.value = zoomed;
                    });

                    builder
                      ..siblingSeparation = (0)
                      ..levelSeparation = (40)
                      ..subtreeSeparation = (75)
                      ..orientation =
                          (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);
                  }
                  return Stack(
                    children: [
                      OverRepaintBoundary(
                        key: widget.keyCapture,
                        child: RepaintBoundary(
                          child: Container(
                            color: const Color(0xffFFECD9),
                            child: Column(
                              children: [
                                Container(
                                  width: ScreenUtil().screenWidth,
                                  height: 155.w,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          ImageConstants.imgBangGiaPha),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      padding: EdgeInsets.only(
                                          top: 10.w, left: 50.w, right: 50.w),
                                      child: Text(
                                        (widget.nameGiaPha).toUpperCase(),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: ThemeStyles.extraBig600.copyWith(
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: InteractiveViewer(
                                    constrained: false,
                                    scaleEnabled: false,
                                    panEnabled: false,
                                    boundaryMargin:
                                        const EdgeInsets.all(double.infinity),
                                    minScale: 0.01,
                                    maxScale: 5.6,
                                    transformationController:
                                        _transformationCapture,
                                    child: Stack(
                                      children: [
                                        GraphView(
                                          listIconEdit: const [],
                                          graph: graph,
                                          algorithm: BuchheimWalkerAlgorithm(
                                              builder,
                                              TreeEdgeRenderer(builder)),
                                          paint: Paint()
                                            ..color = const Color.fromARGB(
                                                255, 192, 238, 26)
                                            ..strokeWidth = 1
                                            ..style = PaintingStyle.stroke,
                                          builder: (Node node) {
                                            final indexNhanh = listIdEndBranch
                                                .indexWhere((element) =>
                                                    element == node.memberId);
                                            return widgetNode2(
                                              node,
                                              nodeEndBranch: indexNhanh != -1
                                                  ? true
                                                  : false,
                                              idNodeVoChongTrucHe: indexNhanh !=
                                                      -1
                                                  ? listIdHeadBranch[indexNhanh]
                                                  : null,
                                              isNodeTrucHe: state.listMember
                                                  .any((list) => list.any(
                                                      (item) =>
                                                          item.info?.memberId ==
                                                          node.memberId)),
                                            );
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: double.infinity,
                        color: Colors.white,
                        child: Stack(children: [
                          state.listMember.isNotEmpty
                              ? state.listMember[0][0].info?.trangThaiNode ==
                                      TrangThaiNode.delete
                                  ? NoDataWidget(
                                      content:
                                          'Chưa có thành viên nào trong gia phả',
                                      titleButton:
                                          "Thêm thành viên".toUpperCase(),
                                      onClickButton: () async {
                                        final info = await Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: ((context) {
                                          return quanLyThanhVienBuilder(
                                            context,
                                            true,
                                            widget.idGiaPha,
                                            null,
                                            null,
                                            null,
                                            null,
                                            saveCallApi: false,
                                          );
                                        })));
                                        if (info != null && info is UserInfo) {
                                          // tao moi 1 nut voi id tạm
                                          indexStep++;
                                          setMaxStep(indexStep);
                                          widget.callBackUpdateStep(indexStep);
                                          _cayGiaPhaBloc.add(
                                            SaveLocalCayGiaPha([
                                              [
                                                Member(
                                                  info.copyWith(
                                                    idTamThoi: memberIdTamThoi
                                                        .toString(),
                                                    memberId: memberIdTamThoi
                                                        .toString(),
                                                    root: 0,
                                                    trangThaiNode:
                                                        TrangThaiNode.create,
                                                  ),
                                                  [],
                                                )
                                              ]
                                            ], indexStep: indexStep),
                                          );
                                          memberIdTamThoi++;
                                          _cayGiaPhaBloc.add(
                                              GetLocalCayGiaPha(indexStep));
                                        }
                                      },
                                    )
                                  : FutureBuilder(
                                      future: _getSvgImageFromAssets(
                                          context, listAssetIcon),
                                      builder: ((BuildContext context,
                                          AsyncSnapshot<List<ui.Image>>
                                              snapshot) {
                                        if (snapshot.hasData) {
                                          return InteractiveViewer(
                                            constrained: false,
                                            boundaryMargin:
                                                const EdgeInsets.all(
                                                    double.infinity),
                                            minScale: 0.01,
                                            maxScale: 5.6,
                                            transformationController:
                                                _transformationController,
                                            child: Stack(
                                              children: [
                                                ValueListenableBuilder(
                                                  valueListenable:
                                                      widget.stateEdit,
                                                  builder: (context, _, __) {
                                                    return GraphView(
                                                      stateEdit: widget
                                                          .stateEdit.value,
                                                      listIconEdit:
                                                          snapshot.data!,
                                                      graph: graph,
                                                      algorithm:
                                                          BuchheimWalkerAlgorithm(
                                                              builder,
                                                              TreeEdgeRenderer(
                                                                  builder)),
                                                      paint: Paint()
                                                        ..color = Colors.green
                                                        ..strokeWidth = 1
                                                        ..style = PaintingStyle
                                                            .stroke,
                                                      builder: (Node node) {
                                                        final indexNhanh =
                                                            listIdEndBranch
                                                                .indexWhere(
                                                                    (element) =>
                                                                        element ==
                                                                        node.memberId);
                                                        return widgetNode(node,
                                                            nodeEndBranch:
                                                                indexNhanh != -1
                                                                    ? true
                                                                    : false,
                                                            idNodeVoChongTrucHe:
                                                                indexNhanh != -1
                                                                    ? listIdHeadBranch[
                                                                        indexNhanh]
                                                                    : null,
                                                            isNodeTrucHe: state
                                                                .listMember
                                                                .any((list) =>
                                                                    list.any((item) => item.info?.memberId == node.memberId)),
                                                            onTapDeleteNode:
                                                                () {
                                                          List<List<Member>>
                                                              listMemberTemp =
                                                              cloneGiaPhaDeleteNode(
                                                                  state
                                                                      .listMember,
                                                                  node.memberId);
                                                          indexStep++;
                                                          setMaxStep(indexStep);
                                                          widget
                                                              .callBackUpdateStep(
                                                                  indexStep);
                                                          _cayGiaPhaBloc.add(
                                                            SaveLocalCayGiaPha(
                                                                listMemberTemp,
                                                                indexStep:
                                                                    indexStep),
                                                          );
                                                          _cayGiaPhaBloc.add(
                                                              GetLocalCayGiaPha(
                                                                  indexStep));

                                                          // _cayGiaPhaBloc.add(
                                                          //     XoaThanhVienEvent(node.memberId ?? ""));
                                                        }, onClickUpdate:
                                                                () async {
                                                          // sua thanh vien
                                                          UserInfo member = Node
                                                              .castMemberInfoFromNode(
                                                                  node);
                                                          final info =
                                                              await Navigator
                                                                  .push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  quanLyThanhVienBuilder(
                                                                context,
                                                                false,
                                                                widget.idGiaPha,
                                                                null,
                                                                null,
                                                                null,
                                                                member,
                                                                saveCallApi:
                                                                    false,
                                                                showTabBar:
                                                                    indexStep >
                                                                            0
                                                                        ? false
                                                                        : true,
                                                              ),
                                                            ),
                                                          );
                                                          if (info != null &&
                                                              info
                                                                  is UserInfo) {
                                                            // luu local
                                                            List<List<Member>>
                                                                listMemberTemp =
                                                                [];
                                                            for (int i = 0;
                                                                i <
                                                                    state
                                                                        .listMember
                                                                        .length;
                                                                i++) {
                                                              List<Member>
                                                                  listTemp = [];
                                                              for (int j = 0;
                                                                  j <
                                                                      state
                                                                          .listMember[
                                                                              i]
                                                                          .length;
                                                                  j++) {
                                                                if (state
                                                                        .listMember[
                                                                            i]
                                                                            [j]
                                                                        .info
                                                                        ?.memberId !=
                                                                    node.memberId) {
                                                                  if (state
                                                                      .listMember[
                                                                          i][j]
                                                                      .pids!
                                                                      .any((element) =>
                                                                          element
                                                                              .memberId ==
                                                                          node.memberId)) {
                                                                    List<UserInfo>
                                                                        pidsNew =
                                                                        [];
                                                                    for (var voChong in state
                                                                        .listMember[
                                                                            i]
                                                                            [j]
                                                                        .pids!) {
                                                                      if (voChong
                                                                              .memberId ==
                                                                          node.memberId) {
                                                                        pidsNew.add(
                                                                            info.copyWith(
                                                                          trangThaiNode: node.trangThaiNode == TrangThaiNode.create
                                                                              ? TrangThaiNode.create
                                                                              : TrangThaiNode.update,
                                                                          pid: indexNhanh != -1
                                                                              ? listIdHeadBranch[indexNhanh]
                                                                              : null,
                                                                          // them cac truong neu la create
                                                                          idTamThoi: node.trangThaiNode == TrangThaiNode.create
                                                                              ? node.idTamThoi
                                                                              : null,
                                                                          cid: node.trangThaiNode == TrangThaiNode.create
                                                                              ? node.cid
                                                                              : null,

                                                                          root: node.trangThaiNode == TrangThaiNode.create
                                                                              ? node.root
                                                                              : null,
                                                                        ));
                                                                      } else {
                                                                        pidsNew.add(
                                                                            voChong.copyWith());
                                                                      }
                                                                    }
                                                                    listTemp.add(state
                                                                        .listMember[
                                                                            i]
                                                                            [j]
                                                                        .copyWith(
                                                                      pids:
                                                                          pidsNew,
                                                                    ));
                                                                  } else {
                                                                    listTemp.add(state
                                                                        .listMember[
                                                                            i]
                                                                            [j]
                                                                        .copyWith());
                                                                  }
                                                                } else {
                                                                  listTemp.add(state
                                                                      .listMember[
                                                                          i][j]
                                                                      .copyWith(
                                                                    info: info
                                                                        .copyWith(
                                                                      trangThaiNode: node.trangThaiNode ==
                                                                              TrangThaiNode
                                                                                  .create
                                                                          ? TrangThaiNode
                                                                              .create
                                                                          : TrangThaiNode
                                                                              .update,
                                                                      idTamThoi: node.trangThaiNode ==
                                                                              TrangThaiNode.create
                                                                          ? node.idTamThoi
                                                                          : null,
                                                                      cid: node.trangThaiNode ==
                                                                              TrangThaiNode.create
                                                                          ? node.cid
                                                                          : null,
                                                                      root: node.trangThaiNode ==
                                                                              TrangThaiNode.create
                                                                          ? node.root
                                                                          : null,
                                                                    ),
                                                                  ));
                                                                }
                                                              }
                                                              if (listTemp
                                                                  .isNotEmpty) {
                                                                listMemberTemp
                                                                    .add(
                                                                        listTemp);
                                                              }
                                                            }
                                                            indexStep++;
                                                            setMaxStep(
                                                                indexStep);
                                                            widget
                                                                .callBackUpdateStep(
                                                                    indexStep);
                                                            _cayGiaPhaBloc.add(
                                                              SaveLocalCayGiaPha(
                                                                  listMemberTemp,
                                                                  indexStep:
                                                                      indexStep),
                                                            );
                                                            _cayGiaPhaBloc.add(
                                                                GetLocalCayGiaPha(
                                                                    indexStep));
                                                          }
                                                        }, onClickAddVoChong:
                                                                (voChongInfo) {
// luu local
                                                          List<List<Member>>
                                                              listMemberTemp =
                                                              [];
                                                          for (int i = 0;
                                                              i <
                                                                  state
                                                                      .listMember
                                                                      .length;
                                                              i++) {
                                                            List<Member>
                                                                listTemp = [];
                                                            for (int j = 0;
                                                                j <
                                                                    state
                                                                        .listMember[
                                                                            i]
                                                                        .length;
                                                                j++) {
                                                              if (state
                                                                      .listMember[
                                                                          i][j]
                                                                      .info
                                                                      ?.memberId !=
                                                                  (indexNhanh !=
                                                                          -1
                                                                      ? listIdHeadBranch[
                                                                          indexNhanh]
                                                                      : node
                                                                          .memberId)) {
                                                                listTemp.add(state
                                                                    .listMember[
                                                                        i][j]
                                                                    .copyWith());
                                                              } else {
                                                                // vo chong them moi
                                                                List<UserInfo>
                                                                    pidsNew =
                                                                    [];
                                                                for (var e in state
                                                                    .listMember[
                                                                        i][j]
                                                                    .pids!) {
                                                                  pidsNew.add(e
                                                                      .copyWith());
                                                                }
                                                                print("GO + ");
                                                                print(
                                                                    listIdHeadBranch);
                                                                print(
                                                                    indexNhanh);
                                                                print(indexNhanh !=
                                                                        -1
                                                                    ? listIdHeadBranch[
                                                                        indexNhanh]
                                                                    : null);
                                                                pidsNew.add(voChongInfo.copyWith(
                                                                    idTamThoi:
                                                                        memberIdTamThoi
                                                                            .toString(),
                                                                    memberId:
                                                                        memberIdTamThoi
                                                                            .toString(),
                                                                    pid: indexNhanh !=
                                                                            -1
                                                                        ? listIdHeadBranch[
                                                                            indexNhanh]
                                                                        : null,
                                                                    trangThaiNode:
                                                                        TrangThaiNode
                                                                            .create));
                                                                memberIdTamThoi++;
                                                                listTemp.add(state
                                                                    .listMember[
                                                                        i][j]
                                                                    .copyWith(
                                                                  pids: pidsNew,
                                                                ));
                                                              }
                                                            }
                                                            if (listTemp
                                                                .isNotEmpty) {
                                                              listMemberTemp
                                                                  .add(
                                                                      listTemp);
                                                            }
                                                          }
                                                          indexStep++;
                                                          setMaxStep(indexStep);
                                                          widget
                                                              .callBackUpdateStep(
                                                                  indexStep);
                                                          _cayGiaPhaBloc.add(
                                                            SaveLocalCayGiaPha(
                                                                listMemberTemp,
                                                                indexStep:
                                                                    indexStep),
                                                          );
                                                          _cayGiaPhaBloc.add(
                                                              GetLocalCayGiaPha(
                                                                  indexStep));
                                                        }, onClickAddCon:
                                                                (conInfo) {
                                                          List<List<Member>>
                                                              listMemberTemp =
                                                              [];
                                                          int indexFather = -1;
                                                          for (int i = 0;
                                                              i <
                                                                  state
                                                                      .listMember
                                                                      .length;
                                                              i++) {
                                                            List<Member>
                                                                listTemp = [];
                                                            for (int j = 0;
                                                                j <
                                                                    state
                                                                        .listMember[
                                                                            i]
                                                                        .length;
                                                                j++) {
                                                              listTemp.add(state
                                                                  .listMember[i]
                                                                      [j]
                                                                  .copyWith());
                                                              if (state
                                                                      .listMember[
                                                                          i][j]
                                                                      .info
                                                                      ?.memberId ==
                                                                  node.memberId) {
                                                                indexFather = i;
                                                              }
                                                            }
                                                            if (listTemp
                                                                .isNotEmpty) {
                                                              listMemberTemp
                                                                  .add(
                                                                      listTemp);
                                                            }
                                                          }

                                                          if (indexFather !=
                                                              -1) {
                                                            if (indexFather ==
                                                                state.listMember
                                                                        .length -
                                                                    1) {
                                                              listMemberTemp
                                                                  .add([
                                                                Member(
                                                                  conInfo.copyWith(
                                                                      idTamThoi:
                                                                          memberIdTamThoi
                                                                              .toString(),
                                                                      memberId:
                                                                          memberIdTamThoi
                                                                              .toString(),
                                                                      fid: node.gioiTinh ==
                                                                              GioiTinhConst
                                                                                  .nam
                                                                          ? node
                                                                              .memberId
                                                                          : null,
                                                                      mid: node
                                                                              .pids!
                                                                              .isNotEmpty
                                                                          ? node.pids![
                                                                              0]
                                                                          : null,
                                                                      trangThaiNode:
                                                                          TrangThaiNode
                                                                              .create),
                                                                  [],
                                                                )
                                                              ]);
                                                              memberIdTamThoi++;
                                                            } else {
                                                              listMemberTemp[
                                                                      indexFather +
                                                                          1]
                                                                  .add(Member(
                                                                conInfo.copyWith(
                                                                    idTamThoi:
                                                                        memberIdTamThoi
                                                                            .toString(),
                                                                    memberId:
                                                                        memberIdTamThoi
                                                                            .toString(),
                                                                    fid: node.gioiTinh ==
                                                                            GioiTinhConst
                                                                                .nam
                                                                        ? node
                                                                            .memberId
                                                                        : null,
                                                                    mid: node
                                                                            .pids!
                                                                            .isNotEmpty
                                                                        ? node.pids![
                                                                            0]
                                                                        : null,
                                                                    trangThaiNode:
                                                                        TrangThaiNode
                                                                            .create),
                                                                [],
                                                              ));
                                                              memberIdTamThoi++;
                                                            }
                                                          }
                                                          indexStep++;
                                                          setMaxStep(indexStep);
                                                          widget
                                                              .callBackUpdateStep(
                                                                  indexStep);
                                                          _cayGiaPhaBloc.add(
                                                            SaveLocalCayGiaPha(
                                                                listMemberTemp,
                                                                indexStep:
                                                                    indexStep),
                                                          );
                                                          _cayGiaPhaBloc.add(
                                                              GetLocalCayGiaPha(
                                                                  indexStep));
                                                        }, onClickAddBoMe: (infoBoMe) {
                                                          List<List<Member>>
                                                              listMemberTemp =
                                                              [];
                                                          listMemberTemp.add([
                                                            Member(
                                                              infoBoMe.copyWith(
                                                                idTamThoi:
                                                                    memberIdTamThoi
                                                                        .toString(),
                                                                memberId:
                                                                    memberIdTamThoi
                                                                        .toString(),
                                                                cid: node.root ==
                                                                        1
                                                                    ? node
                                                                        .memberId
                                                                    : null,
                                                                trangThaiNode:
                                                                    TrangThaiNode
                                                                        .create,
                                                                root: 0,
                                                              ),
                                                              [],
                                                            )
                                                          ]);
                                                          for (int i = 0;
                                                              i <
                                                                  state
                                                                      .listMember
                                                                      .length;
                                                              i++) {
                                                            List<Member>
                                                                listTemp = [];
                                                            for (int j = 0;
                                                                j <
                                                                    state
                                                                        .listMember[
                                                                            i]
                                                                        .length;
                                                                j++) {
                                                              if (i == 0 &&
                                                                  j == 0) {
                                                                listTemp.add(state
                                                                    .listMember[
                                                                        0][0]
                                                                    .copyWith(
                                                                        info: state
                                                                            .listMember[0][0]
                                                                            .info
                                                                            ?.copyWith(fid: memberIdTamThoi.toString())));
                                                              } else {
                                                                listTemp.add(state
                                                                    .listMember[
                                                                        i][j]
                                                                    .copyWith());
                                                              }
                                                            }

                                                            if (listTemp
                                                                .isNotEmpty) {
                                                              listMemberTemp
                                                                  .add(
                                                                      listTemp);
                                                            }
                                                          }
                                                          memberIdTamThoi++;
                                                          indexStep++;
                                                          setMaxStep(indexStep);
                                                          widget
                                                              .callBackUpdateStep(
                                                                  indexStep);
                                                          _cayGiaPhaBloc.add(
                                                            SaveLocalCayGiaPha(
                                                                listMemberTemp,
                                                                indexStep:
                                                                    indexStep),
                                                          );
                                                          _cayGiaPhaBloc.add(
                                                              GetLocalCayGiaPha(
                                                                  indexStep));
                                                        });
                                                      },
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const SizedBox.shrink();
                                        }
                                      }))
                              : NoDataWidget(
                                  content:
                                      'Chưa có thành viên nào trong gia phả',
                                  titleButton: "Thêm thành viên".toUpperCase(),
                                  onClickButton: () async {
                                    final info = await Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: ((context) {
                                      return quanLyThanhVienBuilder(
                                        context,
                                        true,
                                        widget.idGiaPha,
                                        null,
                                        null,
                                        null,
                                        null,
                                        saveCallApi: false,
                                      );
                                    })));
                                    if (info != null && info is UserInfo) {
                                      // tao moi 1 nut voi id tạm
                                      indexStep++;
                                      setMaxStep(indexStep);
                                      widget.callBackUpdateStep(indexStep);
                                      _cayGiaPhaBloc.add(
                                        SaveLocalCayGiaPha([
                                          [
                                            Member(
                                              info.copyWith(
                                                idTamThoi:
                                                    memberIdTamThoi.toString(),
                                                memberId:
                                                    memberIdTamThoi.toString(),
                                                root: 0,
                                                trangThaiNode:
                                                    TrangThaiNode.create,
                                              ),
                                              [],
                                            )
                                          ]
                                        ], indexStep: indexStep),
                                      );
                                      memberIdTamThoi++;
                                      _cayGiaPhaBloc
                                          .add(GetLocalCayGiaPha(indexStep));
                                    }
                                  },
                                ),
                          Positioned(
                            top: 9.w,
                            right: 14.w,
                            child: Row(
                              children: [
                                if (indexStep > 0)
                                  InkWell(
                                    onTap: () {
                                      if (indexStep > 0) {
                                        indexStep--;
                                        widget.callBackUpdateStep(indexStep);
                                        _cayGiaPhaBloc
                                            .add(GetLocalCayGiaPha(indexStep));
                                      }
                                    },
                                    child: imageFromLocale(
                                      url: IconConstants.icUndo,
                                    ),
                                  ),
                                if (indexStep < maxStep)
                                  InkWell(
                                    onTap: () {
                                      indexStep++;
                                      widget.callBackUpdateStep(indexStep);
                                      _cayGiaPhaBloc
                                          .add(GetLocalCayGiaPha(indexStep));
                                    },
                                    child: Transform(
                                      alignment: Alignment.center,
                                      transform: Matrix4.rotationY(pi),
                                      child: imageFromLocale(
                                        url: IconConstants.icUndo,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ],
                  );
                }

                if (state is GetCayGiaPhaError) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: ErrorCommonWidget(
                        content: state.message,
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              }),
            ),
          ),
        ],
      ),
    );
  }
}
