import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/chia_se_bloc.dart';
import 'package:giapha/features/chia_se/presentation/widgets/da_chia_se/role_trailing.dart';
import 'package:giapha/shared/utils/toast_utils.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/app_toast.dart';

// Widget quyenTruyCapChungBuilder(BuildContext context) => BlocProvider(
//     create: (context) => GetIt.I<ChiaSeBloc>(),
//     child: const QuyenTruyCapChungWidget());

class QuyenTruyCapChungWidget extends StatefulWidget {
  const QuyenTruyCapChungWidget({super.key});

  @override
  State<QuyenTruyCapChungWidget> createState() =>
      _QuyenTruyCapChungWidgetState();
}

class _QuyenTruyCapChungWidgetState extends State<QuyenTruyCapChungWidget> {
  late ChiaSeBloc chiaSeBloc;
  PersonRole role = PersonRole.viewer;

  void createLink(state, context, option) async {
    String link = "";
    chiaSeBloc.add(CreateLinkEvent(option));
    if (state is CreateLinkState) {
      link = state.link;
      Clipboard.setData(ClipboardData(text: link));
    } else if (state is Error) {
      AppToast.share.showToast(state.message, type: ToastType.error);
    }
  }

  @override
  void initState() {
    chiaSeBloc = BlocProvider.of<ChiaSeBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChiaSeBloc, ChiaSeState>(builder: (context, state) {
      if (state is GeneralAccessionState) {
        role = state.personRole;
      }
      return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    color: const Color.fromRGBO(229, 229, 229, 1),
                    width: 1.h))),
        padding: EdgeInsets.only(left: 16.w, top: 16.h, right: 16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Quyền truy cập chung',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .titleSmall
                      ?.copyWith(color: const Color.fromRGBO(0, 92, 172, 1)),
                ),
                RoleTrailing(
                  role: role,
                  hasFooter: false,
                  handleRoleChange: (option) {
                    chiaSeBloc.add(GeneralAccessionEvent(option == "EDIT"
                        ? PersonRole.editer
                        : PersonRole.viewer));
                  },
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 12.h, bottom: 16.h),
              child: Text(
                'Bất kỳ ai có kết nối Internet & có đường liên kết này đều có thể ${role == PersonRole.editer ? 'xem và chỉnh sửa' : 'xem'} gia phả.',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: const Color.fromRGBO(51, 51, 51, 1),
                    ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      fixedSize: Size(180.w, 42.h),
                      onPrimary: const Color.fromRGBO(63, 133, 251, 1),
                      side: BorderSide(
                          color: const Color.fromRGBO(229, 229, 229, 1),
                          width: 0.5.w)),
                  onPressed: () => createLink(state, context,
                      role == PersonRole.editer ? "edit" : "view"),
                  icon: SvgPicture.asset(
                    IconConstants.icCopyLink,
                    package: PackageName.namePackageAddImage,
                  ),
                  label: Text(
                    'Sao chép liên kết',
                    style: Theme.of(context)
                        .tabBarTheme
                        .labelStyle
                        ?.copyWith(color: const Color.fromRGBO(51, 51, 51, 1)),
                  ),
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: const Color.fromRGBO(63, 133, 251, 1),
                      fixedSize: Size(180.w, 42.h),
                      side: BorderSide(
                          color: const Color.fromRGBO(229, 229, 229, 1),
                          width: 0.5.w)),
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    IconConstants.icDoneButton,
                    package: PackageName.namePackageAddImage,
                  ),
                  label: Padding(
                    padding: EdgeInsets.only(left: 18.w),
                    child: Text(
                      'Hoàn tất',
                      style: Theme.of(context).tabBarTheme.labelStyle?.copyWith(
                          color: const Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
