import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_event.dart';
import 'package:giapha/features/ghep_gia_pha/presentation/bloc/ghep_gia_pha_bloc.dart';
import 'package:giapha/shared/widget/dropdownlist_shared.dart';

class RoleSelectionInput extends StatefulWidget {
  final String giaPhaId;
  const RoleSelectionInput(this.giaPhaId, {super.key});

  @override
  State<RoleSelectionInput> createState() => _RoleSelectionInputState();
}

class _RoleSelectionInputState extends State<RoleSelectionInput> {
  PersonRole _role = PersonRole.viewer;
  late List<Member> branches;
  late String branchChoose;
  late ChoosedBloc choosedBloc;
  late GhepGiaPhaBloc ghepGiaPhaBloc;
  @override
  void initState() {
    choosedBloc = BlocProvider.of<ChoosedBloc>(context);
    ghepGiaPhaBloc = BlocProvider.of<GhepGiaPhaBloc>(context);
    ghepGiaPhaBloc.add(LayDanhSachNhanhSrcEvent(widget.giaPhaId));
    // branchChoose = branches[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      listener: (context, state) {
        if (state is LayDanhSachNhanhSrcSuccess) {
          branches = state.danhsach;
        }
      },
      bloc: ghepGiaPhaBloc,
      builder: (context, state) => Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h).copyWith(right: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(right: 14.w),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          _role = PersonRole.viewer;
                        });
                        choosedBloc.add(
                            ChangeRolePickedListEvent(_role, branchChoose));
                      },
                      icon: SvgPicture.asset(
                        _role == PersonRole.viewer
                            ? IconConstants.icRadioTick
                            : IconConstants.icRadioUnTick,
                        package: PackageName.namePackageAddImage,
                      ),
                    ),
                    const Text('Người xem')
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.only(right: 14.w),
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        setState(() {
                          _role = PersonRole.editer;
                        });
                        choosedBloc.add(
                            ChangeRolePickedListEvent(_role, branchChoose));
                      },
                      icon: SvgPicture.asset(
                        _role == PersonRole.editer
                            ? IconConstants.icRadioTick
                            : IconConstants.icRadioUnTick,
                        package: PackageName.namePackageAddImage,
                      ),
                    ),
                    const Text('Người chỉnh sửa'),
                  ],
                ),
              ],
            ),
          ),
          if (_role == PersonRole.editer)
            // DropdownButtonFormField(
            //   decoration: InputDecoration(
            //     // hintText: '',
            //     border: OutlineInputBorder(
            //         borderRadius: BorderRadius.all(Radius.circular(6.r)),
            //         borderSide: const BorderSide(
            //             color: Color.fromRGBO(216, 216, 216, 1))),
            //   ),
            //   isDense: true,
            //   // buttonPadding: EdgeInsets.zero,
            //   // buttonHeight: 16.h,
            //   // buttonPadding: EdgeInsets.only(top: 5.h, bottom: 7.h, left: 14.w),
            //   hint: Text(
            //     'Chọn nhánh cho phép chỉnh sửa',
            //     style: TextStyle(
            //         color: const Color.fromRGBO(157, 157, 157, 1),
            //         fontSize: 14.sp),
            //   ),

            //   icon: SvgPicture.asset(IconConstants.icButtonMore),
            //   value: branchChoose,
            //   onChanged: (value) {
            //     setState(() {
            //       branchChoose = value!;
            //     });
            //     choosedBloc.add(ChangeRolePickedListEvent(_role, branchChoose));
            //   },
            //   isExpanded: true,
            //   items: branches.map<DropdownMenuItem<String>>((Member member) {
            //     return DropdownMenuItem(
            //       value: member,
            //       child: Text(value),
            //     );
            //   }).toList(),
            // ),
            DropDownListShared(
              items: branches.map((Member nhanh) {
                return DropdownMenuItem(
                  value: nhanh,
                  child: Text(nhanh.info?.ten ?? ""),
                );
              }).toList(),
              title: "",
              hintText: "Chọn nhánh cho phép chỉnh sửa",
              pathIcon: "",
              enabled: true,
              onChanged: (nhanh) {},
            )
        ],
      ),
    );
  }
}
