import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:giapha/core/clone/graph/GraphView.dart';
import 'package:giapha/core/components/event_bus_handler.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/cay_gia_pha_model.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/pages/quanly_thanhvien_screen.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';
import 'package:giapha/shared/utils/string_extension.dart';
import 'package:giapha/shared/widget/error_common_widget.dart';
import 'package:giapha/shared/widget/image.dart';
import 'package:giapha/shared/widget/no_data_widget.dart';

import 'package:intl/intl.dart';
// import 'package:lichviet_flutter_base/core/core.dart';
import 'package:giapha/core/theme/theme_styles.dart';
// import 'package:lichviet_flutter_base/core/core.dart';
// import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

class TabDanhSach extends StatefulWidget {
  final String idGiaPha;
  final String nameGiaPha;
  final GlobalKey keyCapture;
  final Function(bool) callBackOut;
  final EventBusHandler refreshCayGiaPha;
  const TabDanhSach({
    Key? key,
    required this.idGiaPha,
    required this.nameGiaPha,
    required this.keyCapture,
    required this.callBackOut,
    required this.refreshCayGiaPha,
  }) : super(key: key);

  @override
  State<TabDanhSach> createState() => _TabDanhSachState();
}

class _TabDanhSachState extends State<TabDanhSach> {
  late int lengthLife;
  ValueNotifier selectedLife = ValueNotifier<int>(0);
  late CayGiaPhaBloc _cayGiaPhaBloc;
  BuchheimWalkerConfiguration builder = BuchheimWalkerConfiguration();
  late Graph graph;
  List<Node> listNode = [];
  final TransformationController _transformationController =
      TransformationController();
  double maxWidthGiaPha = 0;
  double maxHeightGiaPha = 0;
  double translateWidth = 0;
  ValueKey keySlidable = const ValueKey(0);
  late StreamSubscription refreshSubscription;

  @override
  void initState() {
    refreshSubscription = widget.refreshCayGiaPha.stream.listen((event) {
      if (event == 'refresh_tab_danh_sach') {
        _cayGiaPhaBloc.add(const ClearCacheEvent());
        _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
      }
    });
    _cayGiaPhaBloc = BlocProvider.of<CayGiaPhaBloc>(context);
    _cayGiaPhaBloc.emit(CayGiaPhaInitial());
    _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
    lengthLife = 0;

    super.initState();
  }

  Widget widgetNode(
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
                  MemberInfo member = Node.castMemberInfoFromNode(node);
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
                                        child: CachedNetworkImage(
                                          imageUrl: node.avatar!,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, _, __) =>
                                              Image.asset(ImageConstants
                                                  .imgDefaultAvatar),
                                          placeholder: (context, _) =>
                                              imageFromLocale(
                                                  url: ImageConstants
                                                      .imgDefaultAvatar),
                                        ))
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

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CayGiaPhaBloc, CayGiaPhaState>(
        listener: (context, state) {
          if (state is XoaThanhVienSuccess) {
            // if(selectedLife.value>0)  selectedLife.value--;
            AnimatedSnackBar.material("Xóa thành viên thành công",
                type: AnimatedSnackBarType.success,
                duration: const Duration(milliseconds: 2000));
            _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
          } else if (state is GetCayGiaPhaSuccess) {
            if (state.listMember.isEmpty) {
              widget.callBackOut(false);
            } else {
              widget.callBackOut(true);
            }
          }
        },
        bloc: _cayGiaPhaBloc,
        builder: (context, state) {
          if (state is CayGiaPhaLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GetCayGiaPhaSuccess) {
            lengthLife = state.listMember.length;

            if (selectedLife.value >= lengthLife - 1) {
              selectedLife.value = lengthLife - 1;
              if (selectedLife.value < 0) selectedLife.value = 0;
            }

            final CayGiaPhaModel cayGiaPhaModel =
                CayGiaPhaModel(state.listMember);
            if (state.listMember.isNotEmpty) {
              List<String> listIdEndBranch = [];
              List<String> listIdHeadBranch = [];

              Paint paintEdge = Paint()
                ..color = const Color(0xffD8D8D8)
                ..strokeWidth = 4;

              graph = Graph()..isTree = true;

              for (int i = 0; i < state.listMember.length; i++) {
                for (int j = 0; j < state.listMember[i].length; j++) {
                  final Node nodeFocus =
                      Member.castNode(state.listMember[i][j]);

                  listNode.add(nodeFocus);

                  if (nodeFocus.depth == 0) {
                    graph.addNode(nodeFocus);
                  } else {
                    if (nodeFocus.fid != null) {
                      final int indexFather = state.listMember[i - 1]
                          .indexWhere((element) =>
                              element.info?.memberId == nodeFocus.fid);
                      if (indexFather != -1) {
                        graph.addNode(nodeFocus);
                        graph.addEdge(
                            Member.castNode(
                                state.listMember[i - 1][indexFather]),
                            nodeFocus,
                            paint: paintEdge);
                      }
                    } else {
                      graph.addNode(nodeFocus);
                    }
                  }
                  if (nodeFocus.pids != null && nodeFocus.pids!.isNotEmpty) {
                    for (var element in state.listMember[i][j].pids!) {
                      final Node nodeVoChong =
                          Member.castNodeFromMemberInfo(element);
                      graph.addNode(nodeVoChong);
                    }
                    listIdEndBranch.add(nodeFocus.pids!.last);
                  } else {
                    listIdEndBranch.add(nodeFocus.memberId ?? "");
                  }
                  listIdHeadBranch.add(nodeFocus.memberId ?? "");
                }
              }

              builder
                ..siblingSeparation = (0)
                ..levelSeparation = (40)
                ..subtreeSeparation = (75)
                ..orientation =
                    (BuchheimWalkerConfiguration.ORIENTATION_TOP_BOTTOM);

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
                  translateWidth =
                      (ScreenUtil().screenWidth - (maxWidthGiaPha * scale)) / 2;
                }
                // set up transformation
                final zoomed = Matrix4.identity()
                  ..translate(translateWidth)
                  ..scale(
                    scale,
                  );

                _transformationController.value = zoomed;
              });

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
                                      ImageConstants.imgBangGiaPha,
                                      package: "giapha"),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 10.w, left: 50.w, right: 50.w),
                                  child: Text(
                                    ("Gia phả\n${widget.nameGiaPha}")
                                        .toUpperCase(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: ThemeStyles.extraBig600.copyWith(
                                      color: const Color(0xffFCF34C),
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
                                    _transformationController,
                                child: Stack(
                                  children: [
                                    GraphView(
                                      listIconEdit: const [],
                                      graph: graph,
                                      algorithm: BuchheimWalkerAlgorithm(
                                          builder, TreeEdgeRenderer(builder)),
                                      paint: Paint()
                                        ..color = Colors.green
                                        ..strokeWidth = 1
                                        ..style = PaintingStyle.stroke,
                                      builder: (Node node) {
                                        final indexNhanh = listIdEndBranch
                                            .indexWhere((element) =>
                                                element == node.memberId);
                                        return widgetNode(
                                          node,
                                          nodeEndBranch:
                                              indexNhanh != -1 ? true : false,
                                          idNodeVoChongTrucHe: indexNhanh != -1
                                              ? listIdHeadBranch[indexNhanh]
                                              : null,
                                          isNodeTrucHe: state.listMember.any(
                                              (list) => list.any((item) =>
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
                    padding: EdgeInsets.only(top: 10.h),
                    height: double.infinity,
                    color: Theme.of(context).scaffoldBackgroundColor,
                    child: ValueListenableBuilder(
                      valueListenable: selectedLife,
                      builder: (context, _, __) {
                        List<Member> sameGenMembers =
                            state.listMember[selectedLife.value];
                        sortListMember(sameGenMembers);

                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Mục lục đời
                            SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  lengthLife,
                                  (index) => InkWell(
                                    onTap: () {
                                      selectedLife.value = index;
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(bottom: 4.h),
                                      decoration: BoxDecoration(
                                        color: selectedLife.value == index
                                            ? const Color.fromRGBO(
                                                35, 123, 211, 1)
                                            : const Color.fromRGBO(
                                                224, 224, 224, 1),
                                        borderRadius: const BorderRadius.only(
                                          bottomRight: Radius.circular(8.0),
                                          topRight: Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Container(
                                        width: 63.w,
                                        height: 62.w,
                                        margin:
                                            const EdgeInsetsDirectional.only(
                                                bottom: 1, end: 1, top: 1),
                                        decoration: BoxDecoration(
                                          color: selectedLife.value == index
                                              ? const Color(0xffE1F9FF)
                                              : Colors.white,
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(8.0),
                                            topRight: Radius.circular(8.0),
                                          ),
                                        ),
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Đời thứ",
                                                style: TextStyle(
                                                  fontFamily: "SFUIText",
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  color: selectedLife.value ==
                                                          index
                                                      ? const Color(0xff237BD3)
                                                      : const Color(0xffC1C1C1),
                                                ),
                                              ),
                                              Text(
                                                "${index + 1}",
                                                style: TextStyle(
                                                  fontFamily: "SFUIText",
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: selectedLife.value ==
                                                          index
                                                      ? const Color(0xff237BD3)
                                                      : const Color(0xff949494),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 9.w,
                            ),

                            /// Danh sách các family trong đời
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount:
                                    state.listMember[selectedLife.value].length,
                                padding: EdgeInsets.zero,
                                itemBuilder: ((context, familyIndex) {
                                  int itemBuildCount = 1 +
                                      sameGenMembers[familyIndex].pids!.length +
                                      cayGiaPhaModel.getChildCount(
                                          sameGenMembers[familyIndex]
                                              .info
                                              ?.memberId,
                                          sameGenMembers[familyIndex]
                                              .info
                                              ?.depth);
                                  // Người trực hệ trong gia phả
                                  Member member = sameGenMembers[familyIndex];
                                  List<MemberInfo> danhsachthanhvienBuildItems =
                                      [member.info!];
                                  // thêm các vợ và con với các vợ
                                  List<MemberInfo> listPids = member.pids!;
                                  sortListMemberInfo(listPids);
                                  for (var i in listPids) {
                                    danhsachthanhvienBuildItems.add(i);
                                    List<MemberInfo> listTemp =
                                        cayGiaPhaModel.getChildren(
                                            member.info?.memberId,
                                            i.memberId,
                                            member.info?.depth);
                                    sortListMemberInfo(listTemp);
                                    danhsachthanhvienBuildItems
                                        .addAll(listTemp);
                                    // Nếu là vợ đầu thì thêm các con không phải của vợ nào vào danh sách build
                                    if (listPids[0].memberId == i.memberId) {
                                      // thêm các con không có vợ tương ứng

                                      List<MemberInfo> listTemp =
                                          cayGiaPhaModel.getChildren(
                                              member.info?.memberId,
                                              null,
                                              member.info?.depth);
                                      sortListMemberInfo(listTemp);
                                      danhsachthanhvienBuildItems
                                          .addAll(listTemp);
                                    }
                                  }
                                  // Nếu không có vợ nhưng có con riêng
                                  if (listPids.isEmpty) {
                                    List<MemberInfo> listTemp =
                                        cayGiaPhaModel.getChildren(
                                            member.info?.memberId,
                                            null,
                                            member.info?.depth);
                                    sortListMemberInfo(listTemp);
                                    danhsachthanhvienBuildItems
                                        .addAll(listTemp);
                                  }

                                  final gioiTinhChuNhanh =
                                      danhsachthanhvienBuildItems[0].gioiTinh;

                                  return Container(
                                    margin: EdgeInsets.only(bottom: 12.h),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffE0E0E0),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          offset: const Offset(0, 1),
                                          blurRadius: 4,
                                          color: Colors.black.withOpacity(0.11),
                                        )
                                      ],
                                    ),
                                    child: Container(
                                      margin: const EdgeInsetsDirectional.only(
                                          bottom: 0.5, start: 1, top: 0.5),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        padding: EdgeInsets.only(bottom: 7.h),
                                        itemCount: selectedLife.value != 0
                                            ? itemBuildCount + 1
                                            : itemBuildCount,
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            indent: 11.w,
                                            height: 0.25,
                                          );
                                        },
                                        itemBuilder: ((contextList, index) {
                                          if (selectedLife.value != 0 &&
                                              index == 0) {
                                            final indexBo = state.listMember[
                                                    selectedLife.value - 1]
                                                .indexWhere(
                                              (element) =>
                                                  element.info?.memberId ==
                                                  member.info?.fid,
                                            );

                                            int indexMe = -1;
                                            if (indexBo != -1) {
                                              indexMe = state
                                                  .listMember[
                                                      selectedLife.value - 1]
                                                      [indexBo]
                                                  .pids!
                                                  .indexWhere(
                                                (element) =>
                                                    element.memberId ==
                                                    member.info?.mid,
                                              );
                                            }
                                            String bo = '', me = '';
                                            if (indexBo != -1) {
                                              if (state
                                                      .listMember[
                                                          selectedLife.value -
                                                              1][indexBo]
                                                      .info
                                                      ?.gioiTinh ==
                                                  GioiTinhConst.nam) {
                                                bo = state
                                                        .listMember[
                                                            selectedLife.value -
                                                                1][indexBo]
                                                        .info
                                                        ?.ten ??
                                                    '';
                                              } else {
                                                me = state
                                                        .listMember[
                                                            selectedLife.value -
                                                                1][indexBo]
                                                        .info
                                                        ?.ten ??
                                                    '';
                                              }
                                            }
                                            if (indexMe != -1) {
                                              if (bo.isNotEmpty) {
                                                me = state
                                                        .listMember[
                                                            selectedLife.value -
                                                                1][indexBo]
                                                        .pids![indexMe]
                                                        .ten ??
                                                    '';
                                              } else {
                                                if (state
                                                        .listMember[
                                                            selectedLife.value -
                                                                1][indexBo]
                                                        .pids![indexMe]
                                                        .gioiTinh ==
                                                    GioiTinhConst.nam) {
                                                  bo = state
                                                          .listMember[
                                                              selectedLife
                                                                      .value -
                                                                  1][indexBo]
                                                          .pids![indexMe]
                                                          .ten ??
                                                      '';
                                                } else {
                                                  if (me.isEmpty) {
                                                    me = state
                                                            .listMember[
                                                                selectedLife
                                                                        .value -
                                                                    1][indexBo]
                                                            .pids![indexMe]
                                                            .ten ??
                                                        '';
                                                  } else {
                                                    bo = state
                                                            .listMember[
                                                                selectedLife
                                                                        .value -
                                                                    1][indexBo]
                                                            .pids![indexMe]
                                                            .ten ??
                                                        '';
                                                  }
                                                }
                                              }
                                            }

                                            // Header Cha: ...  - Mẹ: ....
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 13.w,
                                                  vertical: 11.h),
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffE1F9FF),
                                                  border: Border.all(
                                                    width: 0.5,
                                                    color:
                                                        const Color(0xffB8D0D6),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                  )),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  //if (bo.isNotEmpty)
                                                  Expanded(
                                                    child: Text(
                                                      'Bố: ${bo.isNotNullOrEmpty ? bo : ""}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: const Color(
                                                              0xff3F85FB)),
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  //if (me.isNotEmpty)
                                                  Expanded(
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Text(
                                                        "Mẹ: ${me.isNotNullOrEmpty ? me : ""}",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xff3F85FB)),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }

                                          final indexThanhVien =
                                              selectedLife.value != 0
                                                  ? index - 1
                                                  : index;

                                          int childCount =
                                              cayGiaPhaModel.getChildCount(
                                                  danhsachthanhvienBuildItems[
                                                          indexThanhVien]
                                                      .memberId,
                                                  danhsachthanhvienBuildItems[
                                                              indexThanhVien]
                                                          .depth ??
                                                      member.info
                                                          ?.depth); // Nếu không có depth => Partner => lấy depth theo trực hệ
                                          int partnerCount =
                                              cayGiaPhaModel.getPartnerCount(
                                                      (danhsachthanhvienBuildItems[
                                                              indexThanhVien]
                                                          .memberId)!) ??
                                                  0;
                                          int? itemDepth =
                                              danhsachthanhvienBuildItems[
                                                          indexThanhVien]
                                                      .depth ??
                                                  member.info?.depth;
                                          ValueNotifier<MemberInfo> nodeInfo =
                                              ValueNotifier(
                                                  danhsachthanhvienBuildItems[
                                                      indexThanhVien]);

                                          return GestureDetector(
                                            onTap: () async {
                                              // xem chi tiết và sửa thành viên
                                              final info = await Navigator.push(
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
                                                              danhsachthanhvienBuildItems[
                                                                  indexThanhVien])));

                                              if (info != null) {
                                                // nodeInfo.value = info;
                                                // danhsachthanhvienBuildItems[
                                                //     indexThanhVien] = info;
                                                _cayGiaPhaBloc.add(
                                                    GetTreeGenealogy(
                                                        widget.idGiaPha));
                                              }
                                            },
                                            child: ValueListenableBuilder(
                                                valueListenable: nodeInfo,
                                                builder:
                                                    (context, value, child) {
                                                  return Slidable(
                                                    key: keySlidable,
                                                    groupTag: '0',
                                                    endActionPane: ActionPane(
                                                        extentRatio:
                                                            74 / (414 - 74),
                                                        motion:
                                                            const ScrollMotion(),
                                                        children: [
                                                          CustomSlidableAction(
                                                            autoClose: true,
                                                            onPressed:
                                                                (context) {
                                                              DialogShared
                                                                  .showDialogSelect(
                                                                context,
                                                                "Bạn có chắc chắn muốn xoá thành viên này không?",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                leftButton:
                                                                    "Có",
                                                                onTapLeftButton:
                                                                    () {
                                                                  _cayGiaPhaBloc.add(
                                                                      XoaThanhVienEvent(
                                                                          danhsachthanhvienBuildItems[indexThanhVien]
                                                                              .memberId!));
                                                                },
                                                                rightButton:
                                                                    "Không",
                                                                onTapRightButton:
                                                                    () {},
                                                                rootNavigate:
                                                                    true,
                                                              );
                                                            },
                                                            backgroundColor:
                                                                const Color(
                                                                    0xffF33F3F),
                                                            child: SizedBox(
                                                              child: Center(
                                                                  child: imageFromLocale(
                                                                      url: IconConstants
                                                                          .icXoa,
                                                                      width:
                                                                          22.w,
                                                                      height:
                                                                          28.w,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                        ]),
                                                    child: Column(
                                                      children: [
                                                        // Divider(
                                                        //   indent: 11.w,
                                                        //   height: 0.25,
                                                        // ),
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  10.w),
                                                          margin: EdgeInsets.only(
                                                              left: itemDepth ==
                                                                      member
                                                                          .info!
                                                                          .depth
                                                                  ? 0
                                                                  : 22.w),
                                                          decoration: BoxDecoration(
                                                              color: indexThanhVien ==
                                                                      0
                                                                  ? const Color(
                                                                      0xff3F85FB)
                                                                  : Colors
                                                                      .white,
                                                              borderRadius: (selectedLife
                                                                              .value ==
                                                                          0 &&
                                                                      indexThanhVien ==
                                                                          0)
                                                                  ? BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(6
                                                                              .r))
                                                                  : BorderRadius
                                                                      .zero),
                                                          child: Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Column(
                                                                children: [
                                                                  Container(
                                                                    width: 48.w,
                                                                    height:
                                                                        48.w,
                                                                    color: const Color(
                                                                        0xffE8E8E8),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Container(
                                                                        width:
                                                                            36.w,
                                                                        height:
                                                                            36.w,
                                                                        decoration:
                                                                            const BoxDecoration(shape: BoxShape.circle),
                                                                        child: nodeInfo.value.avatar !=
                                                                                null
                                                                            ? ClipRRect(
                                                                                borderRadius: BorderRadius.circular(33.w),
                                                                                child: CachedNetworkImage(
                                                                                  imageUrl: ImageNetworkUtils.getNetworkUrl(url: danhsachthanhvienBuildItems[indexThanhVien].avatar!),
                                                                                  fit: BoxFit.cover,
                                                                                  errorWidget: (context, _, __) => Image.asset(ImageConstants.imgDefaultAvatar),
                                                                                  placeholder: (context, _) => imageFromLocale(url: ImageConstants.imgDefaultAvatar),
                                                                                ),
                                                                              )
                                                                            : imageFromLocale(
                                                                                url: ImageConstants.imgDefaultAvatar,
                                                                              ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    width: 48.w,
                                                                    height:
                                                                        21.w,
                                                                    color:
                                                                        // member.info?.soCon ==
                                                                        //             0 &&
                                                                        //         member.info?.soVoChong ==
                                                                        //             0
                                                                        //     ? Colors
                                                                        //         .transparent
                                                                        //     :
                                                                        itemDepth ==
                                                                                member.info!.depth
                                                                            ? const Color(0xff8DB5FC)
                                                                            : const Color(0xff8D97FC),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        member.info?.soCon == 0 &&
                                                                                member.info?.soVoChong == 0
                                                                            ? ""
                                                                            : itemDepth == member.info!.depth
                                                                                ? (selectedLife.value == 0 && index == 0) || (selectedLife.value != 0 && index == 1)
                                                                                    ? gioiTinhChuNhanh == GioiTinhConst.nam
                                                                                        ? "CHỒNG"
                                                                                        : "VỢ"
                                                                                    : gioiTinhChuNhanh == GioiTinhConst.nam
                                                                                        ? "VỢ"
                                                                                        : "CHỒNG"
                                                                                : "CON",
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              10.sp,
                                                                          fontWeight:
                                                                              FontWeight.w600,
                                                                          color:
                                                                              const Color(0xff003C70),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                width: 16.w,
                                                              ),
                                                              Expanded(
                                                                child: Stack(
                                                                  children: [
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          padding:
                                                                              EdgeInsets.only(right: (itemDepth == member.info!.depth) ? 40.w : 0),
                                                                          child:
                                                                              Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                                danhsachthanhvienBuildItems[indexThanhVien].ten ?? "",
                                                                                overflow: TextOverflow.ellipsis,
                                                                                style: Theme.of(context).primaryTextTheme.displayMedium!.copyWith(color: indexThanhVien == 0 ? const Color(0xffffffff) : const Color(0xff333333)),
                                                                              ),
                                                                              SizedBox(
                                                                                height: 4.h,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              4.h,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              danhsachthanhvienBuildItems[indexThanhVien].gioiTinh == GioiTinhConst.nam ? "Nam" : "Nữ",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: Theme.of(context).primaryTextTheme.bodySmall!.copyWith(color: indexThanhVien == 0 ? const Color(0xffffffff) : const Color(0xff333333)),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                if (partnerCount != 0)
                                                                                  Text(
                                                                                    "$partnerCount ${itemDepth == member.info!.depth ? selectedLife.value == 0 ? index == 0 ? gioiTinhChuNhanh == GioiTinhConst.nam ? "vợ" : "chồng" : gioiTinhChuNhanh == GioiTinhConst.nam ? "chồng" : "vợ" : index == 1 ? gioiTinhChuNhanh == GioiTinhConst.nam ? "vợ" : "chồng" : gioiTinhChuNhanh == GioiTinhConst.nam ? "chồng" : "vợ" : danhsachthanhvienBuildItems[indexThanhVien].gioiTinh == GioiTinhConst.nam ? "vợ" : "chồng"} ",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(color: indexThanhVien == 0 ? const Color(0xffffffff) : const Color(0xff333333)),
                                                                                  ),
                                                                                if (childCount != 0)
                                                                                  Row(
                                                                                    children: [
                                                                                      SizedBox(
                                                                                        width: 32.w,
                                                                                      ),
                                                                                      Text(
                                                                                        "$childCount con",
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        style: Theme.of(context).primaryTextTheme.displaySmall!.copyWith(color: indexThanhVien == 0 ? const Color(0xffffffff) : const Color(0xff333333)),
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    if (itemDepth ==
                                                                        member
                                                                            .info!
                                                                            .depth)
                                                                      Align(
                                                                        alignment:
                                                                            Alignment.topRight,
                                                                        child:
                                                                            InkWell(
                                                                          onTap:
                                                                              () async {
                                                                            final info =
                                                                                await Navigator.push(context, MaterialPageRoute(builder: ((context) {
                                                                              bool isSameBlood;
                                                                              // Nếu là người trực hệ thì màn sau có option thêm vợ còn không thì chỉ có thêm con
                                                                              if (danhsachthanhvienBuildItems[indexThanhVien].memberId == member.info?.memberId) {
                                                                                isSameBlood = true;
                                                                              } else {
                                                                                isSameBlood = false;
                                                                              }
                                                                              String? fid, mid, pid;
                                                                              // Nếu là người trực hệ
                                                                              if (isSameBlood) {
                                                                                // truyền fid là id của trực hệ

                                                                                fid = member.info?.memberId;

                                                                                mid = member.pids!.isNotEmpty ? member.pids![0].memberId : null;

                                                                                pid = member.info?.memberId;
                                                                              }
                                                                              // Nếu không phải trực hệ thì chỉ có quan hệ thêm con => chỉ có fid và mid
                                                                              else {
                                                                                fid = member.info?.memberId;
                                                                                mid = danhsachthanhvienBuildItems[indexThanhVien].memberId;
                                                                              }

                                                                              return quanLyThanhVienBuilder(context, isSameBlood, widget.idGiaPha, fid, mid, pid, null);
                                                                            })));

                                                                            // thêm thành viên
                                                                            if (info !=
                                                                                null) {
                                                                              _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                30.w,
                                                                            height:
                                                                                30.w,
                                                                            decoration: BoxDecoration(
                                                                                color: Colors.white,
                                                                                shape: BoxShape.circle,
                                                                                border: Border.all(
                                                                                  width: 0.5,
                                                                                  color: const Color(0xffE5E5E5),
                                                                                ),
                                                                                boxShadow: [
                                                                                  BoxShadow(offset: const Offset(0, 1), blurRadius: 4, color: Colors.black.withOpacity(0.11))
                                                                                ]),
                                                                            child:
                                                                                Center(
                                                                              child: imageFromLocale(url: IconConstants.icAddPerson),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      )
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        //if (index != 4)
                                                        // Divider(
                                                        //   indent: 11.w,
                                                        //   height: 0.25,
                                                        // )
                                                      ],
                                                    ),
                                                  );
                                                }),
                                          );
                                        }),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return NoDataWidget(
                content: 'Chưa có thành viên nào trong gia phả',
                titleButton: "Thêm thành viên".toUpperCase(),
                onClickButton: () async {
                  final info = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: ((context) {
                    return quanLyThanhVienBuilder(
                        context, true, widget.idGiaPha, null, null, null, null);
                  })));
                  if (info != null) {
                    _cayGiaPhaBloc.add(GetTreeGenealogy(widget.idGiaPha));
                  }
                },
              );
            }
          } else if (state is GetCayGiaPhaError) {
            return ErrorCommonWidget(
                content: state.message.isNotEmpty
                    ? state.message
                    : "Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
          }
          return const SizedBox.shrink();
        });
  }

  void sortListMemberInfo(List<MemberInfo> listTemp) {
    listTemp.sort((a, b) {
      DateTime dateTimeA =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parse(a.thoiGianTao!);
      DateTime dateTimeB =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parse(b.thoiGianTao!);
      return dateTimeA.compareTo(dateTimeB);
    });
  }

  void sortListMember(List<Member> listTemp) {
    listTemp.sort((a, b) {
      DateTime dateTimeA =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parse(a.info!.thoiGianTao!);
      DateTime dateTimeB =
          DateFormat('yyyy-MM-ddTHH:mm:ss').parse(b.info!.thoiGianTao!);
      return dateTimeA.compareTo(dateTimeB);
    });
  }
}

class OverRepaintBoundary extends StatefulWidget {
  final Widget child;

  const OverRepaintBoundary({Key? key, required this.child}) : super(key: key);

  @override
  OverRepaintBoundaryState createState() => OverRepaintBoundaryState();
}

class OverRepaintBoundaryState extends State<OverRepaintBoundary> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
