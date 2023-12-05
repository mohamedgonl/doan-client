// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_bloc.dart';
import 'package:giapha/features/chia_se/presentation/bloc/shared_bloc/shared_event.dart';
import 'package:giapha/features/chia_se/presentation/widgets/da_chia_se/peole_shared_list.dart';
import 'package:giapha/shared/themes/theme_layouts.dart';
import 'package:giapha/shared/utils/dialog_shared.dart';

class RoleTrailing extends StatefulWidget {
  const RoleTrailing(
      {super.key,
      required this.role,
      required this.hasFooter,
      required this.handleRoleChange});
  final PersonRole role;
  final bool hasFooter;
  final Function handleRoleChange;
  @override
  State<RoleTrailing> createState() => _RoleTrailingState();
}

class _RoleTrailingState extends State<RoleTrailing> {
  late PersonRole role;
  @override
  void initState() {
    role = widget.role;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 114.w,
      height: 22.h,
      padding: EdgeInsets.only(left: 14.w, top: 4.h, bottom: 2.h),
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromRGBO(178, 188, 200, 1), width: 1.w),
          borderRadius: BorderRadius.circular(10.5.r)),
      child: PopupMenuButton(
        offset: const Offset(0, 20),
        shape: CustomShape(),
        itemBuilder: (context) => [
          PopupMenuItem(
            enabled: false,
            child: StatefulBuilder(
              builder: (context, setState) {
                PersonRole role = widget.role;
                return PopUpMenu(
                  role: role,
                  hasFooter: widget.hasFooter,
                  handleChange: widget.handleRoleChange,
                );
              },
            ),
          )
        ],
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              toStringRole(widget.role),
              style: Theme.of(context).tabBarTheme.labelStyle?.copyWith(
                  color: const Color.fromRGBO(118, 118, 118, 1),
                  fontSize: 13.sp),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(IconConstants.icButtonMore,
                // color: Colors.amber,
                // height: 6.86.h,
                width: 12.w,
                package: PackageName.namePackageAddImage)
          ],
        ),
      ),
    );
  }
}

class PopUpMenu extends StatefulWidget {
  const PopUpMenu({
    Key? key,
    required this.role,
    required this.hasFooter,
    required this.handleChange,
  }) : super(key: key);
  final PersonRole role;
  final bool hasFooter;
  final Function handleChange;
  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

class _PopUpMenuState extends State<PopUpMenu> {
  late PersonRole _role;

  @override
  void initState() {
    _role = widget.role;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.0.h),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _role = PersonRole.editer;
                  });
                  widget.handleChange("EDIT");
                },
                icon: SvgPicture.asset(
                    _role == PersonRole.editer
                        ? IconConstants.icRadioTick
                        : IconConstants.icRadioUnTick,
                    package: PackageName.namePackageAddImage),
              ),
              Text(
                'Người chỉnh sửa',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _role = PersonRole.viewer;
                  });
                  widget.handleChange("VIEW");
                },
                icon: SvgPicture.asset(
                    _role == PersonRole.viewer
                        ? IconConstants.icRadioTick
                        : IconConstants.icRadioUnTick,
                    package: PackageName.namePackageAddImage),
              ),
              Text(
                'Người xem',
                style: Theme.of(context)
                    .primaryTextTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              )
            ],
          ),
          if (widget.hasFooter)
            Column(
              children: [
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 1,
                  height: 0,
                ),
                SizedBox(height: 16.h),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                      fixedSize: Size(172.w, 42.h),
                      onPrimary: const Color.fromRGBO(63, 133, 251, 1),
                      side: BorderSide(
                          color: const Color.fromRGBO(229, 229, 229, 1),
                          width: 0.5.w)),
                  onPressed: () {
                    DialogShared.showDialogSelect(
                      context,
                      'Bạn có chắc chắn muốn xoá quyền của người này?',
                      textAlign: TextAlign.center,
                      leftButton: "Có",
                      onTapLeftButton: () {
                        // Remove the box
                        widget.handleChange("DELETE");
                      },
                      rightButton: "Không",
                      onTapRightButton: () {},
                      rootNavigate: true,
                    );
                  },
                  icon: SvgPicture.asset(IconConstants.icTrash,
                      package: PackageName.namePackageAddImage),
                  label: Text(
                    'Xoá quyền',
                    style: Theme.of(context)
                        .primaryTextTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class CustomShape extends ShapeBorder {
  CustomShape();

  final BorderSide _side =
      const BorderSide(color: Color.fromRGBO(229, 229, 229, 1));
  final BorderRadiusGeometry _borderRadius = BorderRadius.circular(0.5.r);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.all(_side.width);

  @override
  Path getInnerPath(
    Rect rect, {
    TextDirection? textDirection,
  }) {
    final Path path = Path();

    path.addRRect(
      _borderRadius.resolve(textDirection).toRRect(rect).deflate(_side.width),
    );

    return path;
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    final Path path = Path();
    final RRect rrect = _borderRadius.resolve(textDirection).toRRect(rect);

    path.moveTo(0, 10);
    path.quadraticBezierTo(0, 0, 10, 0);
    path.lineTo(rrect.width - 30, 0);
    path.lineTo(rrect.width - 20, -10);
    path.lineTo(rrect.width - 10, 0);
    path.quadraticBezierTo(rrect.width, 0, rrect.width, 10);
    path.lineTo(rrect.width, rrect.height - 10);
    path.quadraticBezierTo(
        rrect.width, rrect.height, rrect.width - 10, rrect.height);
    path.lineTo(10, rrect.height);
    path.quadraticBezierTo(0, rrect.height, 0, rrect.height - 10);

    return path;
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => RoundedRectangleBorder(
        side: _side.scale(t),
        borderRadius: _borderRadius * t,
      );
}
