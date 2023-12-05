import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/choosed_bloc/choosed_event.dart';
import 'package:giapha/shared/widget/image.dart';

// show people choosed for sharing
class PeoplePickedList extends StatefulWidget {
  final List<Person> peoplePicked;
  const PeoplePickedList({super.key, required this.peoplePicked});

  @override
  State<PeoplePickedList> createState() => _PeoplePickedState();
}

class _PeoplePickedState extends State<PeoplePickedList> {
  late ChoosedBloc choosedBloc;
  @override
  void initState() {
    choosedBloc = BlocProvider.of<ChoosedBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (_, __) => Divider(
        height: 0,
        thickness: 1.h,
        color: const Color(0xffE5E5E5),
      ),
      itemCount: widget.peoplePicked.length,
      itemBuilder: (context, index) {
        return PersonPickedWidget(
          personPicked: widget.peoplePicked[index],
          choosedBloc: choosedBloc,
        );
      },
    );
  }
}

// Item in people picked list
class PersonPickedWidget extends StatelessWidget {
  final ChoosedBloc choosedBloc;
  const PersonPickedWidget(
      {super.key, required this.personPicked, required this.choosedBloc});
  final Person personPicked;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: 0,
      contentPadding: EdgeInsets.zero,
      leading: SizedBox(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18.r),
          child: personPicked.avatar.isEmpty
              ? imageFromLocale(url: IconConstants.icDefaultAvatar)
              : imageFromNetWork(
                  url: personPicked.avatar, height: 36.h, width: 36.w),
        ),
      ),
      title: Text(personPicked.name),
      subtitle: Padding(
        padding: EdgeInsets.only(top: 4.h),
        child: Text(personPicked.phone),
      ),
      trailing: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          choosedBloc.add(RemovePeopleOfPickedListEvent(personPicked));
        },
        constraints: BoxConstraints(
          minHeight: 20.h,
          minWidth: 20.w,
        ),
        icon: SvgPicture.asset(
          IconConstants.icDeleteChoice,
          height: 20.h,
          width: 20.w,
          fit: BoxFit.cover,
          package: PackageName.namePackageAddImage,
        ),
      ),
      minVerticalPadding: 12.5.h,
    );
  }
}
