import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/lvn_date.dart';
import 'package:lichviet_flutter_base/cubit/cubit.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/lunar_native_model.dart';
import 'package:lichviet_flutter_base/domain/usecases/lunar_calendar_native_usecase.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';
import 'date_picker_dialog_controller.dart';
import 'view_column_item.dart';

class DateTimePicker extends StatefulWidget {
  final DateTime dateTimeInit;
  final bool isLunar;
  final DateTime minTime;
  final DateTime maxTime;
  final bool? isShowViewHours;
  final bool? isShowViewMinutes;
  final bool? isShowViewDay;
  final bool? isShowViewMonth;
  final bool? isShowViewYears;
  final bool? isShowViewLunar;
  final bool? isShowViewTitleMonth;
  final bool? isShowViewTitleDay;
  final Function(DateTime dateCurrent, bool isLunar) onChange;

  final DatePickerDialogController datePickerController;
  const DateTimePicker(
      {super.key,
      required this.dateTimeInit,
      required this.isLunar,
      required this.minTime,
      required this.maxTime,
      required this.datePickerController,
      this.isShowViewTitleMonth,
      this.isShowViewTitleDay,
      this.isShowViewLunar,
      this.isShowViewDay,
      this.isShowViewMonth,
      this.isShowViewYears,
      required this.onChange,
      this.isShowViewHours,
      this.isShowViewMinutes});

  @override
  State<DateTimePicker> createState() => DateTimePickerState();
}

class DateTimePickerState extends State<DateTimePicker> {
  late FixedExtentScrollController scrollMonth;
  late FixedExtentScrollController scrollDay;
  late FixedExtentScrollController scrollYear;
  late FixedExtentScrollController scrollMode;
  late FixedExtentScrollController scrollHour;
  late FixedExtentScrollController scrollMinute;

  int indexDay = 0,
      indexMonth = 0,
      indexYear = 0,
      indexMode = 0,
      indexHour = 0,
      indexMinute = 0;
  int leapMonth = 0;
  String day = '', month = '', year = '', hour = '', minute = '';

  List<String> dataModes = [];
  List<String> dataYears = [];
  List<String> dataMonths = [];
  List<String> titleMonths = [];
  List<String> dataDays = [];
  List<String> titleDays = [];
  List<String> dataHours = [];
  List<String> dataMinutes = [];

  List<String> monthsDataList = [];
  List<String> dayDataList = [];
  List<String> yearDataList = [];

  List<String> monthsDataTitle = [];
  List<String> dayDataTitle = [];

  LunarCalendarNativeCubit _lunarDateTime = GetIt.I<LunarCalendarNativeCubit>();
  LunarCalendarNativeUseCase _lunarCalendarNativeUseCase =
      GetIt.I<LunarCalendarNativeUseCase>();

  Timer? debonceLoadMonth;

  Timer? debonceLoadYears;

  late int monthCurrent;
  late int dayCurrent;
  late int yearCurrent;

  late DateTime dateTimeInit;

  late bool isLunar;
  late int currentTypeIndex;

  Timer? timerBonceScroll;
  int indexChange = -1;

  void initSetUpDate() {
    dateTimeInit = widget.dateTimeInit;
    isLunar = widget.isLunar;

    if (isLunar) {
      LVNLunarDate lunarDate = LVNDateConverter().Solar2Lunar(LVNSolarDate(
          dateTimeInit.year,
          dateTimeInit.month,
          dateTimeInit.day,
          dateTimeInit.hour,
          dateTimeInit.minute));
      month = lunarDate.month.toString();
      leapMonth = lunarDate.leap;
      day = lunarDate.day.toString();
      year = lunarDate.year.toString();
    } else {
      month = dateTimeInit.month.toString();
      day = dateTimeInit.day.toString();
      year = dateTimeInit.year.toString();
    }
    hour = dateTimeInit.hour.toString();
    minute = dateTimeInit.minute.toString();
    loadData();
    scrollMonth = FixedExtentScrollController(initialItem: indexMonth);
    scrollDay = FixedExtentScrollController(initialItem: indexDay);
    scrollYear = FixedExtentScrollController(initialItem: indexYear);
    scrollHour = FixedExtentScrollController(initialItem: indexHour);
    scrollMinute = FixedExtentScrollController(initialItem: indexMinute);
    scrollMode = FixedExtentScrollController(initialItem: indexMode);
    widget.datePickerController.jumpToTopCallBack = scrollToNewDate;
  }

  void loadData() {
    dataModes.clear();
    dataModes.add('Dương');
    dataModes.add('Âm');
    if (isLunar) {
      indexMode = 1;
    } else {
      indexMode = 0;
    }

    dataHours.clear();
    for (int i = 0; i < 24; i++) {
      dataHours.add(i.toString());
    }
    indexHour = dataHours.indexOf(hour);

    dataMinutes.clear();
    for (int i = 0; i < 60; i++) {
      dataMinutes.add(i.toString());
    }
    indexMinute = dataMinutes.indexOf(minute);

    dataYears.clear();
    for (int i = widget.minTime.year; i <= widget.maxTime.year; i++) {
      dataYears.add(i.toString());
    }
    indexYear = dataYears.indexOf(year);

    dataMonths.clear();
    for (int i = 1; i <= 12; i++) {
      if (isLunar) {
        dataMonths.add('$i');
        titleMonths.add('Tháng');
        LVNSolarDate? solarDate = LVNDateConverter()
            .Lunar2Solar(LVNLunarDate(int.parse(year), i, 1, 1));
        if (solarDate == null) {
          continue;
        }
        LVNLunarDate lunarDate = LVNDateConverter().Solar2Lunar(solarDate);
        if (lunarDate.day == 1 &&
            lunarDate.month == i &&
            lunarDate.year == int.parse(year) &&
            lunarDate.leap == 1) {
          dataMonths.add('$i+');
          titleMonths.add('Tháng');
        }
      } else {
        dataMonths.add('$i');
        titleMonths.add('Tháng');
      }
    }
    indexMonth = dataMonths.indexOf(leapMonth == 0 ? month : '$month+');

    dataDays.clear();
    titleDays.clear();
    int maxDay = isLunar
        ? LVNLunarDate(int.parse(year), int.parse(month), 1, leapMonth)
            .totalDaysInMonth()
        : LVNSolarDate(int.parse(year), int.parse(month)).totalDaysInMonth();
    for (int i = 1; i <= maxDay; i++) {
      dataDays.add(i.toString());
      if (isLunar) {
        LVNSolarDate solarDate = LVNDateConverter().Lunar2Solar(
            LVNLunarDate(int.parse(year), int.parse(month), i, leapMonth))!;
        titleDays.add(
            '${DateTimeCommon.formatDateInWeekType2(DateTime(solarDate.year, solarDate.month, solarDate.day))},');
      } else {
        titleDays.add(
            '${DateTimeCommon.formatDateInWeekType2(DateTime(int.parse(year), int.parse(month), i))},');
      }
    }
    indexDay = dataDays.indexOf(day);

    //Timer(const Duration(milliseconds: 100), () {

    DateTime dateTimeTemp = DateTime.now();
    scrollToNewIndex();

    if (isLunar) {
      LVNSolarDate solarDate = LVNDateConverter().Lunar2Solar(LVNLunarDate(
          int.parse(year), int.parse(month), int.parse(day), leapMonth))!;
      onChange(
          DateTime(solarDate.year, solarDate.month, solarDate.day,
              dateTimeTemp.hour, dateTimeTemp.minute, dateTimeTemp.second),
          isLunar);
    } else {
      onChange(
          DateTime(int.parse(year), int.parse(month), int.parse(day),
              int.parse(hour), int.parse(minute), dateTimeTemp.second),
          isLunar);
    }

    //});
  }

  bool checkMaxTime(String day, String month, String year, int leapMonth,
      String hour, String minute) {
    if (isLunar) {
      LVNSolarDate solarDate = LVNDateConverter().Lunar2Solar(LVNLunarDate(
          int.parse(year), int.parse(month), int.parse(day), leapMonth))!;
      if (DateTime(solarDate.year, solarDate.month, solarDate.day,
              int.parse(hour), int.parse(minute), 0)
          .isAfter(widget.maxTime)) {
        return true;
      }
    } else {
      if (DateTime(int.parse(year), int.parse(month), int.parse(day),
              int.parse(hour), int.parse(minute), 0)
          .isAfter(widget.maxTime)) {
        return true;
      }
    }
    return false;
  }

  void scrollToNewDate(DateTime date) {
    if (isLunar) {
      LVNLunarDate lunarDate = LVNDateConverter()
          .Solar2Lunar(LVNSolarDate(date.year, date.month, date.day));
      month = lunarDate.month.toString();
      leapMonth = lunarDate.leap;
      day = lunarDate.day.toString();
      year = lunarDate.year.toString();
    } else {
      month = date.month.toString();
      day = date.day.toString();
      year = date.year.toString();
    }
    hour = date.hour.toString();
    minute = date.minute.toString();
    loadData();
  }

  int getMinYear() {
    return widget.minTime.year;
  }

  void onChange(DateTime dateTime, bool isLunar) {
    widget.onChange(dateTime, isLunar);
  }

  @override
  void initState() {
    initSetUpDate();
    super.initState();
  }

  void scrollToNewIndex() {
    try {
      if (indexChange == -1) {
        scrollDay.jumpToItem(indexDay);
        scrollMonth.jumpToItem(indexMonth);
        scrollYear.jumpToItem(indexYear);
        scrollMinute.jumpToItem(indexMinute);
        scrollHour.jumpToItem(indexHour);
        return;
      }
      if (indexChange != 4) {
        scrollMonth.jumpToItem(indexMonth);
      }
      if (indexChange != 3) {
        scrollDay.jumpToItem(indexDay);
      }
      if (indexChange != 5) {
        scrollYear.jumpToItem(indexYear);
      }
      if (indexChange != 6) {
        scrollHour.jumpToItem(indexHour);
      }
      if (indexChange != 7) {
        scrollMinute.jumpToItem(indexMinute);
      }
    } catch (_) {}
    indexChange = -1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 150.h,
      child: Row(
        children: [
          Visibility(
            visible: widget.isShowViewLunar ?? true,
            child: Expanded(
              child: CupertinoPageScaffold(
                backgroundColor: Colors.white,
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: CupertinoColors.label.resolveFrom(context),
                    fontSize: 16.sp,
                  ),
                  child: CupertinoPicker(
                    magnification: 1.22,
                    squeeze: 1.2,
                    useMagnifier: true,
                    itemExtent: 50.h,
                    scrollController: scrollMode,
                    selectionOverlay: Column(
                      children: [
                        Container(
                          height: 0.25,
                          width: double.infinity,
                          color: const Color(0xffcdced3),
                        ),
                        Expanded(
                          child: Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: const Color(0xFFD3CDCD).withAlpha(50),
                          ),
                        ),
                        Container(
                          height: 0.25,
                          width: double.infinity,
                          color: const Color(0xffcdced3),
                        ),
                      ],
                    ),
                    // This is called when selected item is changed.
                    onSelectedItemChanged: (int selectedItem) async {
                      if (indexChange == -1 || indexChange == 0) {
                        indexChange = 0;
                        isLunar = selectedItem == 0 ? false : true;
                        if (indexMode != selectedItem) {
                          if (selectedItem == 0) {
                            LVNSolarDate solarDate = LVNDateConverter()
                                .Lunar2Solar(LVNLunarDate(
                                    int.parse(year),
                                    int.parse(month),
                                    int.parse(day),
                                    leapMonth))!;
                            day = solarDate.day.toString();
                            month = solarDate.month.toString();
                            year = solarDate.year.toString();
                            leapMonth = 0;
                          } else {
                            LVNLunarDate lunarDate = LVNDateConverter()
                                .Solar2Lunar(LVNSolarDate(int.parse(year),
                                    int.parse(month), int.parse(day)));
                            day = lunarDate.day.toString();
                            month = lunarDate.month.toString();
                            year = lunarDate.year.toString();
                            leapMonth = lunarDate.leap;
                          }
                        }
                        loadData();
                        setState(() {});
                      }
                    },
                    children:
                        List<Widget>.generate(dataModes.length, (int index) {
                      String title = dataModes[index];
                      return Center(
                        child: Text(
                          style: TextStyle(
                              color: CupertinoColors.label.resolveFrom(context),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500),
                          title,
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: widget.isShowViewHours ?? false,
            child: Expanded(
              child: ViewColumnItem(
                fixedExtentScrollController: scrollHour,
                title: [],
                datas: dataHours,
                onChange: (index) {
                  if (indexChange == -1 || indexChange == 6) {
                    if (checkMaxTime(day, month, year, leapMonth,
                        dataHours[index], minute)) {
                      scrollToNewDate(widget.maxTime);
                      return;
                    }
                    indexChange = 6;
                    hour = dataHours[index];
                    loadData();
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.isShowViewHours ?? false,
            child: SizedBox(
              width: 4.w,
              height: 61.h,
              child: Column(
                children: [
                  Container(
                    height: 0.25,
                    width: double.infinity,
                    color: const Color(0xffcdced3),
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: const Color(0xFFD3CDCD).withAlpha(50),
                      child: Center(
                        child: Text(
                          ':',
                          style:
                              ThemeStyles.big400.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 0.25,
                    width: double.infinity,
                    color: const Color(0xffcdced3),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: widget.isShowViewMinutes ?? false,
            child: Expanded(
              child: ViewColumnItem(
                fixedExtentScrollController: scrollMinute,
                title: [],
                datas: dataMinutes,
                onChange: (index) {
                  if (indexChange == -1 || indexChange == 7) {
                    if (checkMaxTime(day, month, year, leapMonth, hour,
                        dataMinutes[index])) {
                      scrollToNewDate(widget.maxTime);
                      return;
                    }
                    indexChange = 7;
                    minute = dataMinutes[index];
                    loadData();
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.isShowViewDay ?? true,
            child: Expanded(
              child: ViewColumnItem(
                fixedExtentScrollController: scrollDay,
                title: (widget.isShowViewLunar ??
                        true && !(widget.isShowViewHours ?? false))
                    ? titleDays
                    : [],
                datas: dataDays,
                onChange: (index) {
                  if (indexChange == -1 || indexChange == 3) {
                    if (checkMaxTime(dataDays[index], month, year, leapMonth,
                        hour, minute)) {
                      scrollToNewDate(widget.maxTime);
                      return;
                    }
                    indexChange = 3;
                    day = dataDays[index];
                    loadData();
                    setState(() {});
                  }
                },
              ),
            ),
          ),
          Visibility(
            visible: widget.isShowViewMonth ?? true,
            child: Expanded(
              child: ViewColumnItem(
                  fixedExtentScrollController: scrollMonth,
                  title: (widget.isShowViewLunar ?? true) ? [] : titleMonths,
                  onChange: (index) {
                    if (indexChange == -1 || indexChange == 4) {
                      if (checkMaxTime(
                          day,
                          dataMonths[index].replaceAll('+', ''),
                          year,
                          dataMonths[index].contains('+') ? 1 : 0,
                          hour,
                          minute)) {
                        scrollToNewDate(widget.maxTime);
                        return;
                      }
                      indexChange = 4;
                      month = dataMonths[index];
                      if (month.contains("+")) {
                        month = month.replaceAll('+', '');
                        leapMonth = 1;
                      } else {
                        leapMonth = 0;
                      }

                      if (isLunar) {
                        if (int.parse(day) >
                            LVNLunarDate(int.parse(year), int.parse(month), 1,
                                    leapMonth)
                                .totalDaysInMonth()) {
                          day = LVNLunarDate(int.parse(year), int.parse(month),
                                  1, leapMonth)
                              .totalDaysInMonth()
                              .toString();
                        }
                      } else {
                        if (int.parse(day) >
                            LVNSolarDate(int.parse(year), int.parse(month))
                                .totalDaysInMonth()) {
                          day = LVNSolarDate(int.parse(year), int.parse(month))
                              .totalDaysInMonth()
                              .toString();
                        }
                      }
                      loadData();
                      setState(() {});
                    }
                  },
                  datas: dataMonths),
            ),
          ),
          Visibility(
            visible: widget.isShowViewYears ?? true,
            child: Expanded(
              child: ViewColumnItem(
                  fixedExtentScrollController: scrollYear,
                  onChange: (index) {
                    if (indexChange == -1 || indexChange == 5) {
                      if (checkMaxTime(day, month, dataYears[index].toString(),
                          leapMonth, hour, minute)) {
                        scrollToNewDate(widget.maxTime);
                        //scrollYear.jumpToItem(dataYears.indexOf(year));
                        return;
                      }
                      indexChange = 5;
                      year = dataYears[index];
                      if (isLunar) {
                        int leapMonthTemp = LVNDateConverter()
                            .Solar2Lunar(LVNSolarDate(
                                int.parse(year), int.parse(month), 5))
                            .leap;
                        if (leapMonthTemp == 1 && leapMonth == 1) {
                          leapMonth = 1;
                        } else {
                          leapMonth = 0;
                        }
                        if (int.parse(day) >
                            LVNLunarDate(int.parse(year), int.parse(month), 1,
                                    leapMonth)
                                .totalDaysInMonth()) {
                          day = LVNLunarDate(int.parse(year), int.parse(month),
                                  1, leapMonth)
                              .totalDaysInMonth()
                              .toString();
                        }
                      } else {
                        if (int.parse(day) >
                            LVNSolarDate(int.parse(year), int.parse(month))
                                .totalDaysInMonth()) {
                          day = LVNSolarDate(int.parse(year), int.parse(month))
                              .totalDaysInMonth()
                              .toString();
                        }
                      }
                      loadData();
                      setState(() {});
                    }
                  },
                  datas: dataYears),
            ),
          ),
        ],
      ),
    );
  }
}
