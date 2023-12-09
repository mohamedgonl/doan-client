import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:giapha/shared/datetime/datetime_shared.dart';
import 'package:giapha/shared/datetime/date_picker_custom_widget.dart'
    as datepickercustom;

import '../../../../core/constants/icon_constrants.dart';
import '../../../../shared/widget/textfield_shared.dart';

class ItemSelectCalendar extends StatefulWidget {
  final ValueNotifier<String> birthDate;
  final TextEditingController birthDayController;
  const ItemSelectCalendar(
      {Key? key, required this.birthDate, required this.birthDayController})
      : super(key: key);

  @override
  State<ItemSelectCalendar> createState() => _ItemSelectCalendarState();
}

class _ItemSelectCalendarState extends State<ItemSelectCalendar> {
  late DateTime _dateTimeChange;
  @override
  void initState() {
    _dateTimeChange =
        DateTimeShared.formatStringToDate8(widget.birthDate.value);
    super.initState();
  }

  void showDialogSelectBirthDate() {
    showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (builder) {
          return Material(
            child: Container(
              height: MediaQuery.of(context).copyWith().size.height,
              color: Colors.black.withOpacity(0.65),
              child: Column(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: SafeArea(
                          child: Container(
                            margin: EdgeInsets.only(right: 11.w),
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: EdgeInsets.all(12.w),
                                child: SvgPicture.asset(
                                  IconConstants.icCancel,
                                  height: 20.w,
                                  width: 20.w,
                                  package: PackageName.namePackageAddImage,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).copyWith().size.height * 0.3,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          decoration: const BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(18),
                                  topLeft: Radius.circular(18))),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.check,
                                  color: Color(0xfff2f2f2),
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.birthDate.value =
                                        DateTimeShared.dateTimeToStringDefault1(
                                            _dateTimeChange);
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.check,
                                    color: Color(0xff237BD3),
                                  ),
                                ),
                              ]),
                        ),
                        Expanded(
                          child: datepickercustom.DatePickerCustomWidget(
                            backgroundColor: Colors.white,
                            mode: datepickercustom.CupertinoDatePickerMode.date,
                            minimumDate: DateTime(1950, 1, 1),
                            initialDateTime: DateTimeShared.formatStringToDate8(
                                widget.birthDate.value),
                            maximumDate: DateTime.now(),
                            onTapToSelect: () {},
                            onDateTimeChanged: (date) {
                              _dateTimeChange = date;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: widget.birthDate,
      builder: ((context, value, child) {
        return GestureDetector(
          //behavior: HitTestBehavior.opaque,
          onTap: () {
            showDialogSelectBirthDate();
          },
          child: TextFieldShared(
            textController: widget.birthDayController,
            pathIcon: IconConstants.icMoiQuanHe,
            title: 'Ngày sinh',
            textInputType: TextInputType.number,
            readOnly: true,
            enabled: false,
            onClickField: () {
              showDialogSelectBirthDate();
            },
          ),
        );
      }),
    );
  }
}
