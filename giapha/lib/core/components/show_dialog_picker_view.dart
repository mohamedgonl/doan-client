import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:giapha/core/components/date_picker_dialog_controller.dart';
import 'package:giapha/core/theme/theme_color.dart';
import 'package:giapha/core/theme/theme_styles.dart';


class ShowDialogPickerView {
  static void showDialogPickerV2(
      {required BuildContext context,
      required DateTime dateTime,
      required Function(DateTime dateTime, bool isLunar) onSelect,
      bool? isShowViewTitleMonth,
      bool? isShowViewTitleDay,
      bool? isShowViewLunar,
      bool? isShowViewDay,
      bool? isShowViewMonth,
      bool? isShowViewYears,
      bool? isShowViewHour,
      bool? isShowViewMinute,
      bool? isLunar,
      String? titleButton,
      bool? popAfterSelect,
      bool isOnlyYear = false,
      DateTime? maxDate,
      DateTime? minDate,
      DatePickerDialogController? datePickerDialogController}) {
    DatePickerDialogController datePickerDialogController0;
    if (datePickerDialogController != null) {
      datePickerDialogController0 = datePickerDialogController;
    } else {
      datePickerDialogController0 = DatePickerDialogController();
    }

    bool isLunarCallBack = isLunar ?? false;
    showDialog(
        context: context,
        useSafeArea: false,
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 42.h,
                color: Colors.white,
                child: SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 16.w,
                      ),
                      Expanded(
                        child: SizedBox(
                          // height: theme.titleHeight.h,
                          child: CupertinoButton(
                            pressedOpacity: 0.3,
                            padding: EdgeInsets.only(right: 17.w),
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                isOnlyYear ? 'Năm nay' : 'Hôm nay',
                                style: ThemeStyles.medium400
                                    .copyWith(color: ThemeColor.primary),
                              ),
                            ),
                            onPressed: () {
                              dateTime = DateTime.now();
                              isLunarCallBack = false;
                              datePickerDialogController0
                                  .scrollToNewDate(DateTime.now());
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.close_sharp,
                            color: ThemeColor.darkBlack,
                            size: 25,
                          )),
                    ],
                  ),
                ),
              ),
              // DateTimePicker(
              //   dateTimeInit: dateTime,
              //   isShowViewTitleMonth: isShowViewTitleMonth,
              //   isShowViewTitleDay: isShowViewTitleDay,
              //   isShowViewLunar: isShowViewLunar,
              //   isShowViewDay: isShowViewDay ?? true,
              //   isShowViewMonth: isShowViewMonth ?? true,
              //   isShowViewYears: isShowViewYears ?? true,
              //   isShowViewHours: isShowViewHour ?? false,
              //   isShowViewMinutes: isShowViewMinute ?? false,
              //   minTime: minDate ?? DateTime(1900, 1, 1),
              //   maxTime: maxDate ?? DateTime(2099, 1, 1),
              //   isLunar: isLunarCallBack,
              //   datePickerController: datePickerDialogController0,
              //   onChange: (DateTime dateCurrent, bool isLunar) {
              //     dateTime = dateCurrent;
              //     isLunarCallBack = isLunar;
              //   },
              // ),
              Container(
                color: Colors.white,
                width: double.infinity,
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    onSelect(dateTime, isLunarCallBack);
                    if (popAfterSelect == false) {
                      return;
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 30.h,
                    width: 150.w,
                    margin: EdgeInsets.only(top: 16.h, bottom: 8.h),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: ThemeColor.green,
                        borderRadius: BorderRadius.circular(6)),
                    child: Text(
                      titleButton ?? "CHỌN NGÀY",
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).padding.bottom > 0
                    ? MediaQuery.of(context).padding.bottom
                    : 24.h,
                color: Colors.white,
              )
            ],
          );
        });
  }
}
