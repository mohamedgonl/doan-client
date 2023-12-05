import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_bloc.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';
import '../bloc/chia_se_bloc.dart';
import 'package:giapha/features/chia_se/presentation/widgets/chon_nguoi_de_chia_se/index.dart';
import 'package:giapha/features/chia_se/presentation/widgets/da_chia_se/index.dart';
import 'package:giapha/features/chia_se/presentation/widgets/quyen_truy_cap_chung/index.dart';

import '../../../../core/constants/icon_constrants.dart';
import '../../../../shared/app_bar/ac_app_bar_button.dart';

Widget chiaSeBuilder(BuildContext context, String giaPhaId) =>
    MultiBlocProvider(
        providers: [
          BlocProvider<SearchBloc>(create: (context) => GetIt.I<SearchBloc>()),
          BlocProvider<ChoosedBloc>(
              create: (context) => GetIt.I<ChoosedBloc>()),
          BlocProvider<GhepGiaPhaBloc>(
            create: (context) => GetIt.I<GhepGiaPhaBloc>(),
          ),
            BlocProvider<SharedBloc>(
            create: (context) => GetIt.I<SharedBloc>(),
          ),
            BlocProvider<ChiaSeBloc>(
            create: (context) => GetIt.I<ChiaSeBloc>(),
          )
        ],
        child: ChiaSeScreen(
          giaPhaId: giaPhaId,
        ));

class ChiaSeScreen extends StatefulWidget {
  final String giaPhaId;
  const ChiaSeScreen({super.key, required this.giaPhaId});

  @override
  State<ChiaSeScreen> createState() => _ChiaSeScreenState();
}

class _ChiaSeScreenState extends State<ChiaSeScreen> {
  late ChoosedBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<ChoosedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
          bloc.add(DestroySingleTonEvent());
           return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Chia sẻ"),
            leading: AcAppBarButton.custom(
                onPressed: () {
                  bloc.add(DestroySingleTonEvent());
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
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: ListView(
                padding: EdgeInsets.only(bottom: 33.h),
                children: [
                  ChonNguoiDeChiaSeWidget(idGiaPha: widget.giaPhaId),
                  Divider(
                    height: 0,
                    thickness: 1.h,
                    color: const Color(0xffE5E5E5),
                  ),
                  SizedBox(height: 10.h),
                  DaChiaSeWidget(giaPhaId: widget.giaPhaId),
                  SizedBox(height: 11.h),
                   QuyenTruyCapChungWidget(),
                ],
              ))),
    );
  }
}

// Widget chiaseBuilder(
//   BuildContext context,
// ) =>
//     BlocProvider(
//       create: (context) => GetIt.I<ChiaSeBloc>(),
//       child: ListView(
//         padding: EdgeInsets.only(bottom: 33.h),
//         children: [
//           chonNguoiDeChiaSeBuilder(context),
//           Divider(
//             height: 0,
//             thickness: 1.h,
//             color: const Color(0xffE5E5E5),
//           ),
//           SizedBox(height: 10.h),
//           daChiaSeBuilder(context),
//           SizedBox(height: 11.h),
//            QuyenTruyCapChungWidget(),
//         ],
//       ),
//     );
