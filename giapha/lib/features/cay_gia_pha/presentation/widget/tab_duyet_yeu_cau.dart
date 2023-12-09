import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/cay_gia_pha/datasource/models/yeu_cau_model.dart';

import '../../../../core/constants/icon_constrants.dart';
import '../../../../shared/widget/image.dart';

class TabDuyetYeuCau extends StatefulWidget {
  const TabDuyetYeuCau({super.key});

  @override
  State<TabDuyetYeuCau> createState() => _TabDuyetYeuCauState();
}

class _TabDuyetYeuCauState extends State<TabDuyetYeuCau> {
  late CayGiaPhaBloc _cayGiaPhaBloc;
  List<YeuCau> listRequired = [];
  @override
  void initState() {
    _cayGiaPhaBloc = BlocProvider.of<CayGiaPhaBloc>(context);
    _cayGiaPhaBloc.add(LayCacYeuCauGhepGiaPhaEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        listener: (context, state) {
          if (state is LayCacYeuCauGhepGiaPhaSuccess) {
            var yeucau = state.listRequired;
            List<YeuCau> pending = yeucau
                .where((element) =>
                    element.trangThai == YeuCauGhepGiaPhaConst.dangCho)
                .toList();
            pending.sort(
              (a, b) => a.thoiGianTao.compareTo(b.thoiGianTao),
            );

            List<YeuCau> accept = yeucau
                .where((element) =>
                    element.trangThai == YeuCauGhepGiaPhaConst.chapNhan)
                .toList();
            accept.sort(
              (a, b) => a.thoiGianTao.compareTo(b.thoiGianTao),
            );

            List<YeuCau> deny = yeucau
                .where((element) =>
                    element.trangThai == YeuCauGhepGiaPhaConst.tuChoi)
                .toList();
            deny.sort(
              (a, b) => a.thoiGianTao.compareTo(b.thoiGianTao),
            );

            listRequired.addAll(pending);
            listRequired.addAll(accept);
            listRequired.addAll(deny);
          }
        },
        bloc: _cayGiaPhaBloc,
        builder: (context, state) {


          return ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            itemCount: listRequired.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              itemInfor(
                                pathIcon: IconConstants.icPersonCreate,
                                title:
                                    "${listRequired[index].idNguoiYeuCau.substring(1, 4)}",
                                isBold: true,
                              ),
                              itemInfor(
                                  pathIcon: IconConstants.icClock,
                                  title: "Thời gian tạo"),
                              itemInfor(
                                  pathIcon: IconConstants.icYeuCau,
                                  title: listRequired[index].noiDung),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 93.w,
                            height: 22.w,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFECD0),
                                borderRadius: BorderRadius.circular(10.5)),
                            child: Center(
                              child: Text(
                                "Chờ duyệt",
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displaySmall!
                                    .copyWith(color: const Color(0xffFF9C36)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    indent: 16.w,
                    height: 1,
                  )
                ],
              );
            }),
          );
        });
  }

  Widget itemInfor(
      {required String pathIcon, required String title, bool isBold = false}) {
    return Container(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        children: [
          imageFromLocale(url: pathIcon),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Text(
              title,
              style: isBold
                  ? Theme.of(context)
                      .primaryTextTheme
                      .displayMedium!
                      .copyWith(color: const Color(0xff000000))
                  : Theme.of(context)
                      .primaryTextTheme
                      .bodySmall!
                      .copyWith(color: const Color(0xff333333)),
            ),
          )
        ],
      ),
    );
  }
}
