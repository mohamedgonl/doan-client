import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/cubit/lunar_calendar_native/lunar_calendar_native_cubit.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/lunar_native_model.dart';
import 'package:lichviet_flutter_base/domain/usecases/lunar_calendar_native_usecase.dart';
import 'date_picker_dialog_controller.dart';
import 'view_column_item.dart';

class PickerDateCustom extends StatefulWidget {
  final DateTime dateTimeInit;
  final bool isLunar;
  final DateTime minTime;
  final DateTime maxTime;
  final bool? isShowViewDay;
  final bool? isShowViewMonth;
  final bool? isShowViewYears;
  final bool? isShowViewLunar;
  final bool? isShowViewTitleMonth;
  final bool? isShowViewTitleDay;
  final Function(DateTime dateCurrent, bool isLunar) onChange;

  final DatePickerDialogController datePickerController;
  const PickerDateCustom(
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
      required this.onChange});

  @override
  State<PickerDateCustom> createState() => PickerDateCustomState();
}

class PickerDateCustomState extends State<PickerDateCustom> {
  late FixedExtentScrollController scrollMonth;
  late FixedExtentScrollController scrollDay;
  late FixedExtentScrollController scrollYear;
  late FixedExtentScrollController scrollMode;

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

  int leapMonth = 0;

  Timer? timerBonceScroll;

  void initSetUpDate() {
    dateTimeInit = widget.dateTimeInit;
    monthCurrent = dateTimeInit.month;
    dayCurrent = dateTimeInit.day;
    yearCurrent = dateTimeInit.year;
    isLunar = false;
    currentTypeIndex = widget.isLunar ? 2 : 1;
    getRangeRenderMonth();
    getRangeRenderYears();
    getRangeRenderDay();
  }

  int _getMaxTimeDay() {
    if (monthCurrent == DateTime.february) {
      final bool isLeapYear =
          (yearCurrent % 4 == 0) && (yearCurrent % 100 != 0) ||
              (yearCurrent % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[monthCurrent - 1];
  }

  void getRangeRenderMonth() {
    try {
      monthsDataList = [];
      if (isLunar) {
        if (_lunarDateTime.state.monthDatas != null) {
          for (int i = 0; i <= _lunarDateTime.state.monthDatas!.length; i++) {
            if (_lunarDateTime.state.monthDatas![i].leap == 1) {
              monthsDataList.add(
                  (_lunarDateTime.state.monthDatas?[i].month?.toString() ??
                          '') +
                      "+");
            } else {
              monthsDataList.add(
                  _lunarDateTime.state.monthDatas?[i].month?.toString() ?? '');
            }

            if (widget.isShowViewTitleMonth == false) {
              monthsDataTitle.add('');
            } else {
              monthsDataTitle.add('Tháng');
            }
          }
        }
      } else {
        for (int i = 1; i <= 12; i++) {
          monthsDataTitle.add('Tháng');
          monthsDataList.add(i.toString());
        }
      }
    } catch (_e) {}
  }

  void getRangeRenderDay() {
    try {
      dayDataList = [];
      dayDataTitle = [];
      if (isLunar) {
        if (_lunarDateTime.state.dayDatas != null) {
          for (int i = 0; i <= _lunarDateTime.state.dayDatas!.length; i++) {
            dayDataList.add(_lunarDateTime.state.dayDatas![i].day.toString());
            if (widget.isShowViewTitleDay == false) {
              dayDataTitle.add('');
            } else {
              dayDataTitle.add(DataUtils.converDateToStringVietNam3(
                  _lunarDateTime.state.dayDatas![i].dayOfWeek ?? 1));
            }
          }
        }
      } else {
        for (int i = 1; i <= _getMaxTimeDay(); i++) {
          dayDataList.add(i.toString());
          if (widget.isShowViewTitleDay == false) {
            dayDataTitle.add('');
          } else {
            dayDataTitle.add(DataUtils.converDateToStringVietNam2(
                DateTime(yearCurrent, monthCurrent, i)));
          }
        }
      }
    } catch (_e) {}
  }

  void getRangeRenderYears() {
    yearDataList = [];
    for (int i = widget.minTime.year; i <= widget.maxTime.year; i++) {
      yearDataList.add(i.toString());
    }
  }

  int getMinYear() {
    return widget.minTime.year;
  }

  Future<void> getLunarMonthData() async {
    List<MonthLunarNativeModel> monthList =
        await _lunarCalendarNativeUseCase.getMonthLunarFromNative(yearCurrent);

    _lunarDateTime.getMonthLunarCalendarNative(year: yearCurrent);

    _lunarDateTime.getDayLunarCalendarNative(
        month: monthList[monthCurrent - 1].month ?? 1,
        leap: monthList[monthCurrent - 1].leap ?? 0,
        year: yearCurrent);
  }

  bool disableCallBack = false;
  void scrollToNewIndex() {
    // scrollMonth =
    //     FixedExtentScrollController(initialItem: monthCurrent - 1);
    // scrollDay = FixedExtentScrollController(initialItem: dayCurrent - 1);
    // scrollYear = FixedExtentScrollController(
    //     initialItem: dateTimeInit.year - widget.minTime.year);

    scrollMonth.jumpToItem(monthCurrent - 1);

    scrollDay.jumpToItem(dayCurrent - 1);
    scrollYear.jumpToItem(yearCurrent - widget.minTime.year);

    // scrollDay.;
  }

  void scrollToNewDate(DateTime date) async {
    disableCallBack = true;
    Timer(Duration(milliseconds: 500), () {
      disableCallBack = false;
    });

    if (isLunar) {
      List<int> lunar = DateTimeCommon.solarToLunar(
          date.year, date.month, date.day, Timezone.Vietnamese);
      yearCurrent = lunar[2];
      List<MonthLunarNativeModel> monthList = await _lunarCalendarNativeUseCase
          .getMonthLunarFromNative(yearCurrent);
      monthCurrent = lunar[1];
      for (int i = 0; i < monthList.length; i++) {
        if (monthList[i].month == monthCurrent &&
            monthList[i].leap == lunar[3]) {
          monthCurrent = i + 1;
          break;
        }
      }

      dayCurrent = lunar[0];
      getLunarMonthData();
    } else {
      yearCurrent = date.year;
      monthCurrent = date.month;
      dayCurrent = date.day;

      scrollToNewIndex();
    }
    // scrollDay.;
  }

  void onChange(DateTime dateTime, bool isLunar) {
    widget.onChange(dateTime, isLunar);
  }

  @override
  void initState() {
    initSetUpDate();

    scrollMonth =
        FixedExtentScrollController(initialItem: dateTimeInit.month - 1);
    scrollDay = FixedExtentScrollController(initialItem: dateTimeInit.day - 1);
    scrollYear = FixedExtentScrollController(
        initialItem: dateTimeInit.year - widget.minTime.year);
    scrollMode = FixedExtentScrollController(initialItem: 0);
    widget.datePickerController.jumpToTopCallBack = scrollToNewDate;

    if (widget.isLunar) {
      Timer(Duration(milliseconds: 100), () async {
        isLunar = widget.isLunar;
        scrollMode.animateToItem(1,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        if (widget.isShowViewLunar == false) {
          await changeSolarToLunarIndex();
          getLunarMonthData();
        }
      });
    }
    // scrollMode.addListener(() {
    //     dateDidChange();
    // });

    super.initState();
  }

  void changeIndex(
      {required int yearIndex,
      required int monthIndex,
      required int dayIndex,
      required typeIndex}) {
    if (yearIndex != yearCurrent) {
      if (currentTypeIndex == 0) {
        //xu ly thay doi ngay
        getRangeRenderDay();
      } else {}
    }
  }

  Future<void> changeSolarToLunarIndex() async {
    List<int> lunar = DateTimeCommon.solarToLunar(
        yearCurrent, monthCurrent, dayCurrent, Timezone.Vietnamese);

    yearCurrent = lunar[2];

    monthCurrent = lunar[1];

    dayCurrent = lunar[0];
    List<MonthLunarNativeModel> monthList =
        await _lunarCalendarNativeUseCase.getMonthLunarFromNative(yearCurrent);
    for (int i = 0; i < monthList.length; i++) {
      if (monthList[i].month == monthCurrent && monthList[i].leap == lunar[3]) {
        monthCurrent = i + 1;
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocListener<LunarCalendarNativeCubit, LunarCalendarNativeState>(
          bloc: _lunarDateTime,
          listener: (context, state) {
            if (state.status == LoadingStatus.success) {
              setState(() {
                getRangeRenderMonth();
                getRangeRenderDay();

                Timer(const Duration(milliseconds: 100), () {
                  scrollToNewIndex();
                });
              });
            }
          },
          child: Container(
            // color: Colors.black,
            child: Container(
              height: 150.h,
              child: Row(
                children: [
                  Visibility(
                    visible: widget.isShowViewLunar == false ? false : true,
                    child: Expanded(
                      child: CupertinoPageScaffold(
                        backgroundColor: Colors.white,
                        child: DefaultTextStyle(
                          style: TextStyle(
                            color: CupertinoColors.label.resolveFrom(context),
                            fontSize: 16.sp,
                          ),
                          child: CupertinoPicker(
                            magnification: 1,
                            squeeze: 1.3,
                            useMagnifier: true,

                            itemExtent: 40,
                            scrollController: scrollMode,
                            // This is called when selected item is changed.
                            onSelectedItemChanged: (int selectedItem) async {
                              if (selectedItem == 0) {
                                isLunar = false;
                              } else {
                                isLunar = true;
                              }
                              if (selectedItem == 0) {
                                List<int> solar =
                                    DateTimeCommon.convertLunar2Solar(
                                        dayCurrent,
                                        _lunarDateTime
                                                .state
                                                .monthDatas?[monthCurrent - 1]
                                                .month ??
                                            1,
                                        yearCurrent,
                                        _lunarDateTime
                                                .state
                                                .monthDatas?[monthCurrent - 1]
                                                .leap ??
                                            0,
                                        Timezone.Vietnamese);

                                setState(() {
                                  getRangeRenderMonth();
                                  getRangeRenderYears();
                                  getRangeRenderDay();
                                });

                                Timer(const Duration(milliseconds: 100), () {
                                  monthCurrent = solar[1];
                                  yearCurrent = solar[2];
                                  dayCurrent = solar[0];
                                  scrollToNewIndex();
                                });
                              } else {
                                await changeSolarToLunarIndex();
                                getLunarMonthData();

                                // Timer(Duration(milliseconds: 100), () {
                                //   if (_lunarDateTime.state.leapMonth != null) {
                                //     if (_lunarDateTime.state.leapMonth! <
                                //             monthCurrent &&
                                //         _lunarDateTime.state.leapMonth != -1) {
                                //       monthCurrent += 1;
                                //     }
                                //   }
                                // });
                              }
                            },
                            children: List<Widget>.generate(2, (int index) {
                              String title = "Dương";
                              if (index == 1) {
                                title = "Âm";
                              }

                              return Center(
                                child: Text(
                                  style: TextStyle(
                                    color: CupertinoColors.label
                                        .resolveFrom(context),
                                    fontSize: 16.sp,
                                  ),
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
                    visible: widget.isShowViewDay == false ? false : true,
                    child: Expanded(
                      child: ViewColumnItem(
                        fixedExtentScrollController: scrollDay,
                        title: dayDataTitle,
                        datas: dayDataList,
                        onChange: (index) {
                          dayCurrent = index + 1;
                          dateDidChange();
                        },
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.isShowViewMonth == false ? false : true,
                    child: Expanded(
                      child: ViewColumnItem(
                          fixedExtentScrollController: scrollMonth,
                          title: monthsDataTitle,
                          onChange: (index) {
                            debonceLoadMonth?.cancel();
                            debonceLoadYears?.cancel();
                            debonceLoadMonth =
                                Timer(Duration(milliseconds: 300), () async {
                              monthCurrent = index + 1;
                              if (isLunar) {
                                List<MonthLunarNativeModel> monthList =
                                    await _lunarCalendarNativeUseCase
                                        .getMonthLunarFromNative(yearCurrent);

                                _lunarDateTime
                                    .getMonthLunarCalendarNative(
                                        year: yearCurrent)
                                    .then((value) {});

                                _lunarDateTime.getDayLunarCalendarNative(
                                    month:
                                        monthList[monthCurrent - 1].month ?? 1,
                                    leap: monthList[monthCurrent - 1].leap ?? 0,
                                    year: yearCurrent);
                              } else {
                                setState(() {
                                  getRangeRenderDay();
                                });
                              }
                              dateDidChange();
                            });
                          },
                          datas: monthsDataList),
                    ),
                  ),
                  Visibility(
                    visible: widget.isShowViewYears == false ? false : true,
                    child: Expanded(
                      child: ViewColumnItem(
                          fixedExtentScrollController: scrollYear,
                          onChange: (index) {
                            yearCurrent = getMinYear() + index;
                            debonceLoadMonth?.cancel();
                            debonceLoadYears?.cancel();
                            debonceLoadYears =
                                Timer(Duration(milliseconds: 300), () {
                              if (isLunar) {
                                getLunarMonthData();
                              } else {
                                setState(() {
                                  getRangeRenderMonth();
                                  getRangeRenderDay();
                                });
                              }
                              dateDidChange();
                            });
                          },
                          datas: yearDataList),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        // InkWell(
        //   child: SvgPicture.asset(IconConstants.icDong),
        //   onTap: () {
        //     Navigator.of(context).pop();
        //   },
        // )
      ],
    );
  }

  void dateDidChange() {
    if (disableCallBack == false) {
      timerBonceScroll?.cancel();
      timerBonceScroll = Timer(Duration(milliseconds: 500), () {
        if (isLunar) {
          List<int> solar = DateTimeCommon.convertLunar2Solar(
              dayCurrent,
              _lunarDateTime.state.monthDatas?[monthCurrent - 1].month ?? 1,
              yearCurrent,
              _lunarDateTime.state.monthDatas?[monthCurrent - 1].leap ?? 0,
              Timezone.Vietnamese);
          onChange(DateTime(solar[2], solar[1], solar[0]), isLunar);
        } else {
          final date = DateTime(yearCurrent, monthCurrent, dayCurrent);
          onChange(date, isLunar);
        }
      });
    }
  }
}
