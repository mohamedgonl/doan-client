library flutter_datetime_picker;

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/core/utils/data_utils.dart';
import 'package:lichviet_flutter_base/core/utils/format_datetime.dart';
import 'package:lichviet_flutter_base/cubit/lunar_calendar_native/lunar_calendar_native_cubit.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';
import 'package:lichviet_flutter_base/widgets/date_picker_lib/src/date_model.dart';
import 'package:lichviet_flutter_base/widgets/date_picker_lib/src/i18n_model.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';

import 'src/datetime_picker_theme.dart';

typedef DateChangedCallback(
    DateTime solarDate, bool isLunarType, bool leapMonth);
typedef DateCancelledCallback();
typedef String? StringAtIndexCallBack(int index);

class DatePicker {
  ///
  /// Display date picker bottom sheet.
  ///
  static Future<DateTime?> showDatePicker(BuildContext context,
      {bool showTitleActions: true,
      required DateTime minTime,
      required DateTime maxTime,
      DateChangedCallback? onChanged,
      DateChangedCallback? onConfirm,
      DateCancelledCallback? onCancel,
      locale: LocaleType.en,
      DateTime? currentTime,
      DatePickerTheme? theme,
      required bool viewDay,
      required bool viewMonth,
      required String titleSelect,
      required bool isLunarDay,
      bool popAfterSelect = true,
      required Function(bool changeLunar) onChangeLunar,
      required bool viewChangeLunar}) async {
    return await Navigator.push(
      context,
      DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        maxTime: maxTime,
        minTime: minTime,
        theme: theme,
        viewDay: viewDay,
        viewMonth: viewMonth,
        titleSelect: titleSelect,
        onChangeLunar: onChangeLunar,
        isLunarDay: isLunarDay,
        popAfterSelect: popAfterSelect,
        viewChangeLunar: viewChangeLunar,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          maxTime: maxTime,
          minTime: minTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet.
  ///
  static Future<DateTime?> showTimePicker(BuildContext context,
      {bool showTitleActions: true,
      bool showSecondsColumn: true,
      DateChangedCallback? onChanged,
      DateChangedCallback? onConfirm,
      DateCancelledCallback? onCancel,
      locale: LocaleType.en,
      bool popAfterSelect = true,
      DateTime? currentTime,
      DatePickerTheme? theme,
      required bool viewDay,
      required bool viewMonth,
      required String titleSelect,
      required bool isLunarDay,
      required Function(bool changeLunar) onChangeLunar,
      required bool viewChangeLunar}) async {
    return await Navigator.push(
      context,
      DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        popAfterSelect: popAfterSelect,
        viewMonth: viewMonth,
        viewDay: viewDay,
        titleSelect: titleSelect,
        onChangeLunar: onChangeLunar,
        isLunarDay: isLunarDay,
        viewChangeLunar: viewChangeLunar,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display time picker bottom sheet with AM/PM.
  ///
  static Future<DateTime?> showTime12hPicker(BuildContext context,
      {bool showTitleActions: true,
      DateChangedCallback? onChanged,
      DateChangedCallback? onConfirm,
      DateCancelledCallback? onCancel,
      locale: LocaleType.en,
      DateTime? currentTime,
      DatePickerTheme? theme,
      bool popAfterSelect = true,
      required bool viewDay,
      required bool viewMonth,
      required String titleSelect,
      required bool isLunarDay,
      required Function(bool changeLunar) onChangeLunar,
      required bool viewChangeLunar}) async {
    return await Navigator.push(
      context,
      DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        popAfterSelect: popAfterSelect,
        viewDay: viewDay,
        viewMonth: viewMonth,
        titleSelect: titleSelect,
        isLunarDay: isLunarDay,
        onChangeLunar: onChangeLunar,
        viewChangeLunar: viewChangeLunar,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date&time picker bottom sheet.
  ///
  static Future<DateTime?> showDateTimePicker(BuildContext context,
      {bool showTitleActions: true,
      DateTime? minTime,
      DateTime? maxTime,
      DateChangedCallback? onChanged,
      DateChangedCallback? onConfirm,
      DateCancelledCallback? onCancel,
      locale: LocaleType.en,
      DateTime? currentTime,
      DatePickerTheme? theme,
      bool popAfterSelect = true,
      required bool viewDay,
      required bool viewMonth,
      required String titleSelect,
      required bool isLunarDay,
      required Function(bool changeLunar) onChangeLunar,
      required bool viewChangeLunar}) async {
    return await Navigator.push(
      context,
      DatePickerRoute(
        showTitleActions: showTitleActions,
        viewDay: viewDay,
        viewMonth: viewMonth,
        titleSelect: titleSelect,
        isLunarDay: isLunarDay,
        onChanged: onChanged,
        onConfirm: onConfirm,
        popAfterSelect: popAfterSelect,
        onChangeLunar: onChangeLunar,
        viewChangeLunar: viewChangeLunar,
        onCancel: onCancel,
        locale: locale,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: DatePickerModel(
          currentTime: currentTime,
          minTime: minTime,
          maxTime: maxTime,
          locale: locale,
        ),
      ),
    );
  }

  ///
  /// Display date picker bottom sheet witch custom picker model.
  ///
  static Future<DateTime?> showPicker(
    BuildContext context, {
    bool showTitleActions: true,
    DateChangedCallback? onChanged,
    DateChangedCallback? onConfirm,
    DateCancelledCallback? onCancel,
    locale: LocaleType.en,
    DatePickerModel? pickerModel,
    DatePickerTheme? theme,
    bool popAfterSelect = true,
    required bool viewDay,
    required bool viewMonth,
    required String titleSelect,
    required bool isLunarDay,
    required Function(bool changeLunar) onChangeLunar,
    required bool viewChangeLunar,
    required String leapMonthInit,
  }) async {
    return await Navigator.push(
      context,
      DatePickerRoute(
        showTitleActions: showTitleActions,
        onChanged: onChanged,
        onConfirm: onConfirm,
        isLunarDay: isLunarDay,
        onCancel: onCancel,
        locale: locale,
        viewDay: viewDay,
        viewMonth: viewMonth,
        popAfterSelect: popAfterSelect,
        titleSelect: titleSelect,
        onChangeLunar: onChangeLunar,
        viewChangeLunar: viewChangeLunar,
        theme: theme,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pickerModel: pickerModel,
      ),
    );
  }
}

class DatePickerRoute<T> extends PopupRoute<T> {
  DatePickerRoute({
    this.showTitleActions,
    this.onChanged,
    this.onConfirm,
    this.onCancel,
    DatePickerTheme? theme,
    this.barrierLabel,
    this.locale,
    this.maxTime,
    this.minTime,
    required this.viewDay,
    required this.viewMonth,
    required this.titleSelect,
    required this.isLunarDay,
    required this.onChangeLunar,
    required this.viewChangeLunar,
    required this.popAfterSelect,
    RouteSettings? settings,
    DatePickerModel? pickerModel,
  })  : this.pickerModel = pickerModel ?? DatePickerModel(),
        this.theme = theme ?? DatePickerTheme(),
        super(
          settings: settings,
        );

  final bool? showTitleActions;
  final DateChangedCallback? onChanged;
  final DateChangedCallback? onConfirm;
  final DateCancelledCallback? onCancel;
  final LocaleType? locale;
  final DatePickerTheme theme;
  final DatePickerModel pickerModel;
  final bool viewDay;
  final bool viewMonth;
  final String titleSelect;
  Function(bool changeLunar) onChangeLunar;
  final bool viewChangeLunar;
  final bool popAfterSelect;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);

  @override
  bool get barrierDismissible => true;

  @override
  final String? barrierLabel;

  @override
  Color get barrierColor => Colors.black54;

  AnimationController? _animationController;

  DateTime? maxTime;
  DateTime? minTime;

  bool isLunarDay;

  @override
  AnimationController createAnimationController() {
    assert(_animationController == null);
    _animationController =
        BottomSheet.createAnimationController(navigator!.overlay!);
    return _animationController!;
  }

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: DatePickerComponent(
        onChanged: onChanged,
        locale: this.locale,
        isLunarDay: isLunarDay,
        route: this,
        popAfterSelect: popAfterSelect,
        pickerModel: pickerModel,
        maxTime: maxTime,
        minTime: minTime,
        viewDay: viewDay,
        viewMonth: viewMonth,
        titleSelect: titleSelect,
        onChangeLunar: onChangeLunar,
        viewChangeLunar: viewChangeLunar,
      ),
    );
    return InheritedTheme.captureAll(context, bottomSheet);
  }
}

class DatePickerComponent extends StatefulWidget {
  DatePickerComponent(
      {Key? key,
      required this.route,
      required this.pickerModel,
      this.onChanged,
      this.locale,
      required this.popAfterSelect,
      required this.maxTime,
      required this.minTime,
      required this.viewDay,
      required this.viewMonth,
      required this.titleSelect,
      required this.isLunarDay,
      required this.onChangeLunar,
      required this.viewChangeLunar})
      : super(key: key);

  final DateChangedCallback? onChanged;

  final DatePickerRoute route;

  final LocaleType? locale;

  DatePickerModel pickerModel;

  final bool viewDay;
  final bool viewMonth;
  final String titleSelect;
  final bool isLunarDay;
  final bool viewChangeLunar;
  final bool popAfterSelect;

  DateTime? maxTime;
  DateTime? minTime;

  Function(bool changeLunar) onChangeLunar;

  @override
  State<StatefulWidget> createState() {
    return _DatePickerState();
  }
}

class _DatePickerState extends State<DatePickerComponent> {
  late FixedExtentScrollController leftScrollCtrl,
      middleScrollCtrl,
      rightScrollCtrl,
      lunarSCrollCtrl;
  bool isLunarDate = false;

  final LunarCalendarNativeCubit _lunarCalendarCubit =
      GetIt.I<LunarCalendarNativeCubit>();
  bool leapMonth = false;
  @override
  void initState() {
    super.initState();

    if (widget.isLunarDay) {
      isLunarDate = true;

      List<int> lunar = DateTimeCommon.solarToLunar(
          widget.pickerModel.finalTime().year,
          widget.pickerModel.finalTime().month,
          widget.pickerModel.finalTime().day,
          Timezone.Vietnamese);
      int monthConver = lunar[1];

      int intLeapFilter = -1;
      int intYearFilter = -1;
      if (lunar[3] == 1) {
        monthConver += 1;
      } else {
        DateTime initDate = widget.pickerModel.finalTime();
        int year = DateTimeCommon.solarToLunar(initDate.year, initDate.month,
            initDate.day, Timezone.Vietnamese)[2];

        for (int i = 1; i <= 12; i++) {
          List<int> lunarCheck =
              DateTimeCommon.solarToLunar(year, i, 1, Timezone.Vietnamese);
          if (lunarCheck[3] == 1) {
            intLeapFilter = lunarCheck[1];
            intYearFilter = lunarCheck[2];
            checkLeapMonthNow = 1;
            break;
          }
        }

        if ((monthConver > intLeapFilter &&
            intLeapFilter != -1 &&
            intYearFilter != -1 &&
            intYearFilter == lunar[2])) {
          monthConver += 1;
        }
      }
      if (monthConver == 13) {
        widget.pickerModel = DatePickerModel(
          currentTime: DateTime(lunar[2], 12, lunar[0]),
          locale: widget.locale,
        );

        Timer(Duration(milliseconds: 200), () {
          // widget.pickerModel.setMiddleIndex(13);
          // setState(() {
          //   refreshScrollOffset();
          // });
          widget.pickerModel = DatePickerModel(
              currentTime: DateTime(lunar[2], 12, lunar[0]),
              locale: widget.locale,
              dayDatas: widget.pickerModel.day);

          setState(() {
            refreshScrollOffset();
          });
        });
      } else {
        widget.pickerModel = DatePickerModel(
          currentTime: DateTime(lunar[2], monthConver, lunar[0]),
          locale: widget.locale,
        );
      }

      getDataLunar();

      lunarSCrollCtrl = FixedExtentScrollController(initialItem: 1);
    } else {
      lunarSCrollCtrl = FixedExtentScrollController(initialItem: 0);
    }

    refreshScrollOffset();
  }

  Future<void> getDataLunar() async {
    await _lunarCalendarCubit.getMonthLunarCalendarNative(
        year: widget.pickerModel.currentLeftIndex() + 1970);
    int monthCover = widget.pickerModel.currentMiddleIndex();
    if (widget.pickerModel.leapMonth != -1 &&
        widget.pickerModel.leapMonth! < monthCover) {
    } else if (leapMonth) {
    } else {
      monthCover += 1;
    }
    await _lunarCalendarCubit.getDayLunarCalendarNative(
        month: monthCover,
        leap: leapMonth ? 1 : 0,
        year: widget.pickerModel.currentLeftIndex() + 1970);
  }

  void clearDataLunar() {
    widget.pickerModel.day = null;
    widget.pickerModel.month = null;
  }

  void refreshScrollOffset() {
//    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');
    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());

    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  void refreshScrollOffsetDateNow() {
//    print('refreshScrollOffset ${widget.pickerModel.currentRightIndex()}');

    leftScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentLeftIndex());
    middleScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentMiddleIndex());
    rightScrollCtrl = FixedExtentScrollController(
        initialItem: widget.pickerModel.currentRightIndex());
  }

  @override
  Widget build(BuildContext context) {
    DatePickerTheme theme = widget.route.theme;
    return GestureDetector(
      child: AnimatedBuilder(
        animation: widget.route.animation!,
        builder: (BuildContext context, Widget? child) {
          final double bottomPadding = MediaQuery.of(context).padding.bottom;
          return ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(
                widget.route.animation!.value,
                theme,
                showTitleActions: widget.route.showTitleActions!,
                bottomPadding: bottomPadding + 20,
              ),
              child: GestureDetector(
                child: Material(
                  color: theme.backgroundColor,
                  child: _renderPickerView(
                      theme, widget.maxTime!, widget.minTime!,
                      viewDay: widget.viewDay,
                      viewMonth: widget.viewMonth,
                      titleSelect: widget.titleSelect),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _notifyDateChanged() {
    if (widget.onChanged != null) {
      if (isLunarDate) {
        DateTime dateTimeChange = DateTime(
            widget.pickerModel.finalTime().year,
            widget.pickerModel.month![widget.pickerModel.finalTime().month - 1],
            widget.pickerModel.finalTime().day);
        List<int> solar = DateTimeCommon.convertLunar2Solar(
            dateTimeChange.day,
            dateTimeChange.month,
            dateTimeChange.year,
            leapMonth == true ? 1 : 0,
            Timezone.Vietnamese);
        widget.onChanged!(
            DateTime(solar[2], solar[1], solar[0]), isLunarDate, leapMonth);
        return;
      }

      widget.onChanged!(widget.pickerModel.finalTime(), isLunarDate, leapMonth);
    }
  }

  Widget _renderPickerView(
      DatePickerTheme theme, DateTime maxTime, DateTime minTime,
      {required bool viewDay, required bool viewMonth, required titleSelect}) {
    Widget itemView = _renderItemView(theme,
        viewDay: viewDay,
        viewMonth: viewMonth,
        titleSelect: titleSelect,
        maxTime: maxTime,
        minTime: minTime);
    if (widget.route.showTitleActions == true) {
      return Column(
        children: <Widget>[
          _renderTitleActionsView(theme, maxTime, minTime),
          itemView,
        ],
      );
    }
    return itemView;
  }

  Widget _renderColumnView(
      ValueKey key,
      DatePickerTheme theme,
      StringAtIndexCallBack stringAtIndexCB,
      ScrollController scrollController,
      int layoutProportion,
      ValueChanged<int> selectedChangedWhenScrolling,
      ValueChanged<int> selectedChangedWhenScrollEnd,
      {required bool isDay,
      int? yearSelect,
      int? monthSelect,
      bool? isLeap,
      bool? isLunar}) {
    return Expanded(
      flex: layoutProportion,
      child: Container(
        height: 145.h,
        decoration: BoxDecoration(color: theme.backgroundColor),
        child: NotificationListener(
          onNotification: (ScrollNotification notification) {
            if (notification.depth == 0 &&
                notification is ScrollEndNotification &&
                notification.metrics is FixedExtentMetrics) {
              final FixedExtentMetrics metrics =
                  notification.metrics as FixedExtentMetrics;
              final int currentItemIndex = metrics.itemIndex;
              selectedChangedWhenScrollEnd(currentItemIndex);
            }
            return false;
          },
          child: CupertinoPicker.builder(
            key: key,
            backgroundColor: theme.backgroundColor,
            diameterRatio: 1.3,
            scrollController: scrollController as FixedExtentScrollController,
            itemExtent: theme.itemHeight.h,
            selectionOverlay: Column(
              children: [
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xffcdced3),
                ),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: const Color(0xff3F85FB).withAlpha(20),
                  ),
                ),
                Container(
                  height: 1,
                  width: double.infinity,
                  color: const Color(0xffcdced3),
                ),
              ],
            ),
            onSelectedItemChanged: (int index) {
              selectedChangedWhenScrolling(index);
            },
            useMagnifier: true,
            itemBuilder: (BuildContext context, int index) {
              String? content = stringAtIndexCB(index);

              if (content == null) {
                return null;
              }

              if (index > 0 && content.length != 4) {
                if (stringAtIndexCB(index - 1) == content) {
                  content = content + " +";
                }
              }
              if (isDay) {
                if (isLunar != true) {
                  DateTime dateTime =
                      DateTime(yearSelect!, monthSelect!, int.parse(content));

                  content =
                      "${DataUtils.converDateToStringVietNam2(dateTime)}, $content";
                } else {
                  int monthConver = monthSelect!;

                  int intLeapFilter = -1;

                  for (int i = 1; i <= 12; i++) {
                    List<int> lunarCheck = DateTimeCommon.solarToLunar(
                        yearSelect!, i, 1, Timezone.Vietnamese);
                    if (lunarCheck[3] == 1) {
                      intLeapFilter = lunarCheck[1];
                      break;
                    }
                  }

                  List<int> solar = DateTimeCommon.convertLunar2Solar(
                      int.parse(content),
                      (monthConver > intLeapFilter && intLeapFilter != -1) ||
                              isLeap == true
                          ? monthConver - 1 == 0
                              ? 12
                              : monthConver - 1
                          : monthConver,
                      yearSelect!,
                      isLeap == true ? 1 : 0,
                      Timezone.Vietnamese);
                  DateTime dateTime = DateTime(solar[2], solar[1], solar[0]);

                  content =
                      "${DataUtils.converDateToStringVietNam2(dateTime)}, $content";
                }
              }

              return Container(
                height: theme.itemHeight,
                alignment: Alignment.center,
                child: Text(
                  content,
                  style: theme.itemStyle,
                  textAlign: TextAlign.start,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  int indexMonthLeap = -1;
  int checkLeapMonthNow = 0;
  Widget _renderItemView(DatePickerTheme theme,
      {required bool viewDay,
      required bool viewMonth,
      required titleSelect,
      required DateTime maxTime,
      required DateTime minTime}) {
    return BlocListener<LunarCalendarNativeCubit, LunarCalendarNativeState>(
      bloc: _lunarCalendarCubit,
      listenWhen: ((previous, current) =>
          current.status == LoadingStatus.success),
      listener: (context, state) {
        if (state.dayDatas != null) {
          widget.pickerModel.day = state.dayDatas!.map((e) => e.day!).toList();
        }

        if (state.monthDatas != null) {
          widget.pickerModel.month =
              state.monthDatas!.map((e) => e.month!).toList();
        }

        widget.pickerModel.leapMonth = state.leapMonth;
        indexMonthLeap = state.leapMonth ?? -1;

        widget.pickerModel.fillMiddleLists();
        widget.pickerModel.fillLeftLists();
        widget.pickerModel.fillRightLists();
        setState(() {
          refreshScrollOffset();
        });
      },
      child: Container(
        color: theme.backgroundColor,
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Visibility(
                    visible: widget.viewChangeLunar,
                    child: Expanded(
                      child: SizedBox(
                        height: 145.h,
                        child: CupertinoPicker.builder(
                          backgroundColor: theme.backgroundColor,
                          // selectionOverlay:
                          //     CupertinoPickerDefaultSelectionOverlay(
                          //   background: ThemeColor.overLayGreyCalendar,
                          // ),
                          // selectionOverlay:
                          //     CupertinoPickerDefaultSelectionOverlay(
                          //         background: CupertinoColors.tertiarySystemFill
                          //             .withOpacity(0.6)),
                          selectionOverlay: Column(
                            children: [
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: const Color(0xffcdced3),
                              ),
                              Expanded(
                                child: Container(
                                  height: double.infinity,
                                  width: double.infinity,
                                  color: const Color(0xff3F85FB).withAlpha(20),
                                ),
                              ),
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: const Color(0xffcdced3),
                              ),
                            ],
                          ),
                          diameterRatio: 1,
                          scrollController: lunarSCrollCtrl,
                          childCount: 2,
                          itemExtent: 35.h,
                          onSelectedItemChanged: (int index) async {
                            if (index == 0) {
                              clearDataLunar();
                              int intLeapFilter = -1;
                              int intYearFilter = -1;
                              int monthConver =
                                  widget.pickerModel.currentMiddleIndex();
                              for (int i = 1; i <= 12; i++) {
                                List<int> lunarCheck =
                                    DateTimeCommon.solarToLunar(
                                        widget.pickerModel.currentLeftIndex() +
                                            1970,
                                        i,
                                        1,
                                        Timezone.Vietnamese);
                                if (lunarCheck[3] == 1) {
                                  intLeapFilter = lunarCheck[1];
                                  intYearFilter = lunarCheck[2];

                                  break;
                                }
                              }

                              for (int i = 1; i <= 12; i++) {
                                List<int> lunarCheck =
                                    DateTimeCommon.solarToLunar(
                                        widget.pickerModel.currentLeftIndex() +
                                            1970,
                                        i,
                                        1,
                                        Timezone.Vietnamese);
                                if (lunarCheck[3] == 1 &&
                                    monthConver == lunarCheck[1]) {
                                  monthConver -= 1;

                                  break;
                                }
                              }
                              // monthConver += 1;

                              DateTime dateLunar = DateTime(
                                  widget.pickerModel.currentLeftIndex() + 1970,
                                  widget.pickerModel.currentTime.month,
                                  widget.pickerModel.currentRightIndex() + 1);

                              List<int> solar =
                                  DateTimeCommon.convertLunar2Solar(
                                      dateLunar.day,
                                      dateLunar.month,
                                      dateLunar.year,
                                      leapMonth == true ? 1 : 0,
                                      Timezone.Vietnamese);

                              widget.pickerModel = DatePickerModel(
                                currentTime:
                                    DateTime(solar[2], solar[1], solar[0]),
                                maxTime: maxTime,
                                minTime: minTime,
                                locale: widget.locale,
                              );
                              isLunarDate = false;
                              leapMonth == false;
                              setState(() {
                                refreshScrollOffset();
                              });
                            } else {
                              clearDataLunar();

                              List<int> lunar = DateTimeCommon.solarToLunar(
                                  widget.pickerModel.finalTime().year,
                                  widget.pickerModel.finalTime().month,
                                  widget.pickerModel.finalTime().day,
                                  Timezone.Vietnamese);
                              int monthConver = lunar[1];

                              int intLeapFilter = -1;
                              int intYearFilter = -1;

                              await getDataLunar();
                              widget.pickerModel = DatePickerModel(
                                currentTime:
                                    DateTime(lunar[2], lunar[1], lunar[0]),
                                maxTime: maxTime,
                                minTime: minTime,
                                locale: widget.locale,
                              );
                              isLunarDate = true;

                              if (lunar[3] == 1) {
                                // monthConver += 1;
                                widget.pickerModel.setMiddleIndex(monthConver);
                              } else {
                                for (int i = 1; i <= 12; i++) {
                                  List<int> lunarCheck =
                                      DateTimeCommon.solarToLunar(
                                          lunar[2], i, 1, Timezone.Vietnamese);
                                  if (lunarCheck[3] == 1) {
                                    intLeapFilter = lunarCheck[1];
                                    intYearFilter = lunarCheck[2];
                                    break;
                                  }
                                }

                                if ((monthConver > intLeapFilter &&
                                    intLeapFilter != -1 &&
                                    intYearFilter != -1 &&
                                    intYearFilter == lunar[2])) {
                                  widget.pickerModel
                                      .setMiddleIndex(monthConver);
                                }
                              }

                              leapMonth = lunar[3] == 1 ? true : false;
                              setState(() {
                                refreshScrollOffset();
                              });

                              // setState(() {
                              //   widget.pickerModel = DatePickerModel(
                              //     currentTime:
                              //         DateTime(lunar[2], lunar[1], lunar[0]),
                              //     maxTime: maxTime,
                              //     minTime: minTime,
                              //     locale: widget.locale,
                              //   );
                              // });
                              // widget.pickerModel.setMiddleIndex(lunar[1]);
                              // Timer(Duration(milliseconds: 400), () {
                              //   widget.pickerModel.setMiddleIndex(lunar[1]);
                              // });
                            }
                          },
                          useMagnifier: true,
                          itemBuilder: (BuildContext context, int index) {
                            String titleText = "DƯƠNG";
                            if (index == 1) {
                              titleText = "ÂM";
                            } else {}
                            return Container(
                              alignment: Alignment.center,
                              child: Text(
                                titleText,
                                style: theme.itemStyle,
                                textAlign: TextAlign.start,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: viewDay,
                    child: Container(
                      child: widget.pickerModel.layoutProportions()[2] > 0
                          ? _renderColumnView(
                              ValueKey(widget.pickerModel),
                              theme,
                              widget.pickerModel.rightStringAtIndex,
                              rightScrollCtrl,
                              widget.pickerModel.layoutProportions()[2],
                              (index) {
                              widget.pickerModel.setRightIndex(index);
                              refreshScrollOffset();
                            }, (index) {},
                              isDay: true,
                              isLeap: leapMonth,
                              isLunar: isLunarDate,
                              monthSelect:
                                  widget.pickerModel.currentMiddleIndex() + 1,
                              yearSelect:
                                  widget.pickerModel.currentLeftIndex() + 1970)
                          : null,
                    ),
                  ),
                  // Text(
                  //   widget.pickerModel.leftDivider(),
                  //   style: theme.itemStyle,
                  // ),
                  Visibility(
                    visible: viewMonth,
                    child: Container(
                      child: widget.pickerModel.layoutProportions()[1] > 0
                          ? _renderColumnView(
                              ValueKey(widget.pickerModel),
                              theme,
                              widget.pickerModel.middleStringAtIndex,
                              middleScrollCtrl,
                              widget.pickerModel.layoutProportions()[1],
                              (index) {
                              widget.pickerModel.setMiddleIndex(index + 1);
                            }, (index) async {
                              if (isLunarDate) {
                                if (index > 0 &&
                                    widget.pickerModel
                                            .middleStringAtIndex(index)
                                            .toString()
                                            .length !=
                                        4) {
                                  if (widget.pickerModel
                                          .middleStringAtIndex(index - 1) ==
                                      widget.pickerModel
                                          .middleStringAtIndex(index)) {
                                    leapMonth = true;
                                  } else {
                                    leapMonth = false;
                                  }
                                }

                                await getDataLunar();
                              }

                              // setState(() {
                              //   refreshScrollOffset();
                              // });
                            }, isDay: false)
                          : null,
                    ),
                  ),
                  // Text(
                  //   widget.pickerModel.rightDivider(),
                  //   style: theme.itemStyle,
                  // ),
                  Container(
                    child: widget.pickerModel.layoutProportions()[0] > 0
                        ? _renderColumnView(
                            ValueKey(widget.pickerModel),
                            theme,
                            widget.pickerModel.leftStringAtIndex,
                            leftScrollCtrl,
                            widget.pickerModel.layoutProportions()[0], (index) {
                            widget.pickerModel.setLeftIndex(index);
                          }, (index) async {
                            if (isLunarDate) {
                              await getDataLunar();
                            }

                            if (isLunarDate) {
                              widget.pickerModel = DatePickerModel(
                                currentTime: widget.pickerModel.finalTime(),
                                maxTime: maxTime,
                                minTime: minTime,
                                locale: widget.locale,
                              );
                              int checkLeapMonthOld = 0;
                              for (int i = 1; i <= 12; i++) {
                                List<int> lunarCheck =
                                    DateTimeCommon.solarToLunar(
                                        widget.pickerModel.finalTime().year,
                                        i,
                                        1,
                                        Timezone.Vietnamese);
                                if (lunarCheck[3] == 1) {
                                  checkLeapMonthOld = lunarCheck[3];

                                  break;
                                }
                              }

                              if (checkLeapMonthOld != checkLeapMonthNow) {
                                checkLeapMonthNow = checkLeapMonthOld;
                                if (leapMonth != true) {
                                  widget.pickerModel.setMiddleIndex(
                                      widget.pickerModel.finalTime().month);
                                }
                                leapMonth = true;
                              } else {
                                leapMonth = false;
                              }
                            }
                            setState(() {
                              refreshScrollOffset();
                            });
                          }, isDay: false)
                        : null,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (widget.popAfterSelect) {
                  Navigator.pop(context);
                }
                _notifyDateChanged();
              },
              child: Container(
                height: 30.h,
                width: 150.w,
                margin: const EdgeInsets.only(top: 25),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ThemeColor.green,
                    borderRadius: BorderRadius.circular(6)),
                child: Text(
                  titleSelect,
                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Title View
  Widget _renderTitleActionsView(
      DatePickerTheme theme, DateTime maxTime, DateTime minTime) {
    // final done = _localeDone();
    // final cancel = _localeCancel();

    return Container(
      margin: const EdgeInsets.only(top: 12, right: 8),
      height: 40,
      decoration: BoxDecoration(
        color: theme.headerColor ?? theme.backgroundColor,
      ),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: theme.titleHeight.h,
              child: CupertinoButton(
                pressedOpacity: 0.3,
                padding: EdgeInsetsDirectional.only(start: 16.w, top: 0),
                child: Text(
                  'Hôm nay',
                  style: theme.doneStyle,
                ),
                onPressed: () {
                  setState(() {
                    if (isLunarDate) {
                      List<int> lunarDate = DateTimeCommon.solarToLunar(
                          DateTime.now().year,
                          DateTime.now().month,
                          DateTime.now().day,
                          Timezone.Vietnamese);

                      widget.pickerModel = DatePickerModel(
                        currentTime:
                            DateTime(lunarDate[2], lunarDate[1], lunarDate[0]),
                        maxTime: maxTime,
                        minTime: minTime,
                        locale: widget.locale,
                      );
                    } else {
                      widget.pickerModel = DatePickerModel(
                        currentTime: DateTime.now(),
                        maxTime: maxTime,
                        minTime: minTime,
                        locale: widget.locale,
                      );
                    }
                  });

                  refreshScrollOffsetDateNow();
                },
              ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.close_sharp,
                  color: ThemeColor.darkBlack,
                  size: 25,
                )),
          ],
        ),
      ),
    );
  }

  String _localeDone() {
    return i18nObjInLocale(widget.locale)['done'] as String;
  }

  String _localeCancel() {
    return i18nObjInLocale(widget.locale)['cancel'] as String;
  }
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(
    this.progress,
    this.theme, {
    this.itemCount,
    this.showTitleActions,
    this.bottomPadding = 0,
  });

  final double progress;
  final int? itemCount;
  final bool? showTitleActions;
  final DatePickerTheme theme;
  final double bottomPadding;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = theme.containerHeight.h;
    if (showTitleActions == true) {
      maxHeight += theme.titleHeight;
    }

    return BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight + bottomPadding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final height = size.height - childSize.height * progress;
    return Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
