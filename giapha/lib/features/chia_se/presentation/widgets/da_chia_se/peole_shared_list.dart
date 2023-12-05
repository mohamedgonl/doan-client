// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_event.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_state.dart';
import 'package:giapha/features/chia_se/presentation/widgets/da_chia_se/role_trailing.dart';
import 'package:giapha/shared/widget/image.dart';

class PeopleSharedWidget extends StatefulWidget {
  String giaPhaId;
  PeopleSharedWidget(
    this.giaPhaId,
  );

  @override
  State<PeopleSharedWidget> createState() => _PeopleSharedWidgetState();
}

class _PeopleSharedWidgetState extends State<PeopleSharedWidget> {
  late List<Person> peopleShared;
  late SharedBloc sharedBloc;
  @override
  void initState() {
    super.initState();
    sharedBloc = BlocProvider.of<SharedBloc>(context);
    sharedBloc.add(GetPeopleSharedEvent(widget.giaPhaId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(builder: (context, state) {
      if (state is GetPeopleSharedState) {
        peopleShared = state.getPeople;
      } else if (state is UpdateRoleSharedPeopleState) {
        peopleShared = state.getPeople;
        peopleShared
            .removeWhere((element) => element.role == PersonRole.delete);
      } else {
        peopleShared = [];
      }
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (_, __) => Divider(
          height: 0,
          thickness: 1.h,
          color: const Color(0xffE5E5E5),
        ),
        itemCount: peopleShared.length,
        itemBuilder: (context, index) {
          return PersonSharedWidget(
            personShared: peopleShared[index],
            sharedBloc: sharedBloc,
          );
        },
      );
    });
  }
}

class PersonSharedWidget extends StatelessWidget {
  const PersonSharedWidget(
      {super.key, required this.personShared, required this.sharedBloc});
  final Person personShared;
  final SharedBloc sharedBloc;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        height: 36.h,
        width: 36.w,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: personShared.avatar.isEmpty
              ? imageFromLocale(url: IconConstants.icDefaultAvatar)
              : Image.network(personShared.avatar),
        ),
      ),
      title: Text(personShared.name),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(personShared.phone),
      ),
      trailing: RoleTrailing(
        role: personShared.role,
        hasFooter: true,
        handleRoleChange: (option) {
          sharedBloc.add(UpdateRoleSharedPeopleEvent(personShared, option));
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        },
      ),
      minVerticalPadding: 12.5.h,
    );
  }
}

String toStringRole(PersonRole role) {
  switch (role) {
    case PersonRole.editer:
      return 'Người sửa';
    case PersonRole.viewer:
      return 'Người xem';
    default:
      return 'Xoá quyền';
  }
}
