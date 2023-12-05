import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_state.dart';
import 'package:giapha/features/chia_se/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:giapha/features/chia_se/presentation/widgets/chon_nguoi_de_chia_se/people_picked_list.dart';
import 'package:giapha/features/chia_se/presentation/widgets/chon_nguoi_de_chia_se/people_search_input.dart';
import 'package:giapha/features/chia_se/presentation/widgets/chon_nguoi_de_chia_se/role_selection.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';
import 'package:giapha/shared/utils/toast_utils.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

// Widget chonNguoiDeChiaSeBuilder(BuildContext context, String id) =>
//     MultiBlocProvider(
//         providers: [
//           BlocProvider<SearchBloc>(create: (context) => GetIt.I<SearchBloc>()),
//           BlocProvider<ChoosedBloc>(
//               create: (context) => GetIt.I<ChoosedBloc>()),
//           BlocProvider<GhepGiaPhaBloc>(
//             create: (context) => GetIt.I<GhepGiaPhaBloc>(),
//           )
//         ],
//         child: ChonNguoiDeChiaSeWidget(
//           idGiaPha: id,
//         ));

class ChonNguoiDeChiaSeWidget extends StatefulWidget {
  final String idGiaPha;
  const ChonNguoiDeChiaSeWidget({super.key, required this.idGiaPha});

  @override
  State<ChonNguoiDeChiaSeWidget> createState() =>
      _ChonNguoiDeChiaSeWidgetState();
}

class _ChonNguoiDeChiaSeWidgetState extends State<ChonNguoiDeChiaSeWidget> {
  List<Person> peoplePicked = [];
  late ChoosedBloc choosedBloc;
  @override
  void initState() {
    choosedBloc = BlocProvider.of<ChoosedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context0) {
    return BlocBuilder<ChoosedBloc, ChoosedState>(
      builder: (context, state) {
        if (state is ChoosedPeopleChangeState) {
          peoplePicked = state.choosedPeople;
        }

        if (state is Error) {
          AppToast.share.showToast(state.message, type: ToastType.error);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w).copyWith(bottom: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chọn người dùng để chia sẻ',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleSmall
                          ?.copyWith(
                              color: const Color.fromRGBO(0, 92, 172, 1))),
                  SizedBox(height: 16.h),
                  PeopleSearchInput(
                      choosedBloc: choosedBloc, idGiaPha: widget.idGiaPha),
                  PeoplePickedList(peoplePicked: peoplePicked),
                ],
              ),
            ),
            if (peoplePicked.isNotEmpty)
              Divider(
                height: 0,
                thickness: 1.h,
                color: const Color(0xffE5E5E5),
              ),
            if (peoplePicked.isNotEmpty)
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.5.h)
                        .copyWith(bottom: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Quyền hạn',
                        style: Theme.of(context)
                            .primaryTextTheme
                            .titleSmall
                            ?.copyWith(
                                color: const Color.fromRGBO(0, 92, 172, 1))),
                    RoleSelectionInput(widget.idGiaPha),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}
