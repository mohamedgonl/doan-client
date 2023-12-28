import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/clone/graph/GraphView.dart';
import 'package:giapha/core/components/image_network_utils.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';

import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/shared/app_bar/ac_app_bar_button.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';

import 'package:giapha/shared/utils/string_extension.dart';

import 'package:giapha/shared/widget/image.dart';
import 'dart:ui' as ui;
import 'package:giapha/shared/widget/no_data_widget.dart';

class CayPhaHePreview extends StatefulWidget {
  final String nameGiaPha;
  final List<List<Member>> listMember;
  const CayPhaHePreview({
    super.key,
    required this.nameGiaPha,
    required this.listMember,
  });

  @override
  State<CayPhaHePreview> createState() => _CayPhaHePreviewState();
}

class _CayPhaHePreviewState extends State<CayPhaHePreview> {
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

  late StreamSubscription refreshSubscription;

  ValueNotifier selectedLife = ValueNotifier<int>(0);
  late int lengthLife;
  ValueKey keySlidable = const ValueKey(0);

  @override
  void initState() {
    graph = Graph();

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

  Widget nodeEdit({required String pathIcon}) {
    return InkWell(
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

  Widget widgetNode(
    Node node, {
    bool nodeEndBranch = false,
    bool isNodeTrucHe = true,
    String? idNodeVoChongTrucHe,
  }) {
    return Container(
      //color: Colors.red.withOpacity(0.3),
      child: Column(
        children: [
          Row(
            children: [
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
              SizedBox(
                width: 38.w,
              ),
            ],
          ),
          SizedBox(
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xem thử"),
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
      ),
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: Builder(
              builder: (context) {
                List<String> listIdEndBranch = [];
                List<String> listIdHeadBranch = [];

                if (widget.listMember.isNotEmpty) {
                  Paint paintEdge = Paint()
                    ..color = const Color(0xffD8D8D8)
                    ..strokeWidth = 4;

                  graph = Graph()..isTree = true;

                  for (int i = 0; i < widget.listMember.length; i++) {
                    for (int j = 0; j < widget.listMember[i].length; j++) {
                      final Node nodeFocus =
                          Member.castNode(widget.listMember[i][j]);

                      listNode.add(nodeFocus);

                      bool noDrawVoChong = false;

                      if (nodeFocus.depth == 0) {
                        graph.addNode(nodeFocus);
                      } else {
                        if (nodeFocus.fid != null) {
                          final int indexFather = widget.listMember[i - 1]
                              .indexWhere((element) =>
                                  element.info?.memberId == nodeFocus.fid);
                          if (indexFather != -1) {
                            if (graph.nodes.any((element) =>
                                    element.memberId ==
                                    widget.listMember[i - 1][indexFather].info
                                        ?.memberId) &&
                                nodeFocus.trangThaiNode !=
                                    TrangThaiNode.delete) {
                              graph.addNode(nodeFocus);

                              graph.addEdge(
                                  Member.castNode(
                                      widget.listMember[i - 1][indexFather]),
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
                          for (var element in widget.listMember[i][j].pids!) {
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      color: Colors.white,
                      child: Stack(children: [
                        widget.listMember.isNotEmpty
                            ? widget.listMember[0][0].info?.trangThaiNode ==
                                    TrangThaiNode.delete
                                ? NoDataWidget(
                                    content:
                                        'Chưa có thành viên nào trong gia phả',
                                    titleButton:
                                        "Thêm thành viên".toUpperCase(),
                                    onClickButton: () async {},
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
                                          boundaryMargin: const EdgeInsets.all(
                                              double.infinity),
                                          minScale: 0.01,
                                          maxScale: 5.6,
                                          transformationController:
                                              _transformationController,
                                          child: Stack(
                                            children: [
                                              GraphView(
                                                listIconEdit: snapshot.data!,
                                                graph: graph,
                                                algorithm:
                                                    BuchheimWalkerAlgorithm(
                                                        builder,
                                                        TreeEdgeRenderer(
                                                            builder)),
                                                paint: Paint()
                                                  ..color = Colors.green
                                                  ..strokeWidth = 1
                                                  ..style =
                                                      PaintingStyle.stroke,
                                                builder: (Node node) {
                                                  final indexNhanh =
                                                      listIdEndBranch.indexWhere(
                                                          (element) =>
                                                              element ==
                                                              node.memberId);
                                                  return widgetNode(
                                                    node,
                                                    nodeEndBranch:
                                                        indexNhanh != -1
                                                            ? true
                                                            : false,
                                                    idNodeVoChongTrucHe:
                                                        indexNhanh != -1
                                                            ? listIdHeadBranch[
                                                                indexNhanh]
                                                            : null,
                                                    isNodeTrucHe: widget
                                                        .listMember
                                                        .any((list) => list.any(
                                                            (item) =>
                                                                item.info
                                                                    ?.memberId ==
                                                                node.memberId)),
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
                                content: 'Chưa có thành viên nào trong gia phả',
                                titleButton: "Thêm thành viên".toUpperCase(),
                                onClickButton: () async {},
                              ),
                      ]),
                    )
                  ],
                );
              },
            )),
          ],
        ),
      ),
    );
  }
}
