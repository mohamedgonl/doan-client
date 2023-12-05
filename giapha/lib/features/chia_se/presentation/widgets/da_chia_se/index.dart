// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/chia_se_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_bloc.dart';
import 'package:giapha/features/chia_se/presentation/widgets/da_chia_se/peole_shared_list.dart';

// Widget daChiaSeBuilder(BuildContext context, String giaPhaId) =>
//     BlocProvider<SharedBloc>(
//       create: (context) => GetIt.I<SharedBloc>(),
//       child: DaChiaSeWidget(giaPhaId: giaPhaId),
//     );

class DaChiaSeWidget extends StatefulWidget {
  final String giaPhaId;
  const DaChiaSeWidget({
    Key? key, required this.giaPhaId,
  }) : super(key: key);
  @override
  State<DaChiaSeWidget> createState() => _DaChiaSeWidgetState();
}

class _DaChiaSeWidgetState extends State<DaChiaSeWidget> {
  late List<Person> sharedPeople = [];
  bool _showSharedPeople = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: const Color(0xffE5E5E5), width: 1.h),
              bottom: BorderSide(color: const Color(0xffE5E5E5), width: 1.h))),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 14.h, bottom: 12.5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đã chia sẻ với',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .titleSmall
                      ?.copyWith(color: const Color.fromRGBO(0, 92, 172, 1)),
                ),
                Transform.rotate(
                  angle: _showSharedPeople ? 0 : math.pi,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _showSharedPeople = !_showSharedPeople;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: SvgPicture.asset(
                      IconConstants.iicButtonMoreBlue,
                      fit: BoxFit.contain,
                      package: PackageName.namePackageAddImage
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 0,
            thickness: 1.h,
            color: const Color(0xffE5E5E5),
          ),
          Visibility(
            visible: _showSharedPeople,
            maintainState: true,
            child:  PeopleSharedWidget(widget.giaPhaId),
          )
        ],
      ),
    );
  }
}

// Widget peopleSharedBuilder(
//   BuildContext context,
// ) =>
//     BlocProvider(
//         create: (context) => GetIt.I<ChiaSeBloc>(),
//         child: const DanhSachGiaPhaScreen());
