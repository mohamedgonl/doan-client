import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/day_lunar_native_model.dart';
import 'package:lichviet_flutter_base/data/model/lunar_native_model/month_lunar_native_model.dart';

class LunarCalendarDatasource {
  final MethodChannel platform;

  LunarCalendarDatasource(this.platform);

  Future<List<MonthLunarNativeModel>> getMonthLunarNative(int year) async {
    List<MonthLunarNativeModel> monthLunarDatas = [];
    try {
      var data = await platform
          .invokeMethod(ChannelEndpoint.getMonthLunar, {'year': year});
      debugPrint('month_lunar$data');

      if (data is String) {
        data = jsonDecode(data);
      }

      for (var dataJson in data) {
        monthLunarDatas.add(MonthLunarNativeModel.fromJson(
            Map<String, dynamic>.from(dataJson)));
      }

      return monthLunarDatas;
    } catch (e) {
      List data = [];
      // Random random = Random();
      // if (random.nextInt(2) == 1) {
      if (year != 2023) {
        data = mockDataMMonth;
      } else {
        data = mockDataMMonthLeap;
      }

      for (var element in data) {
        monthLunarDatas.add(MonthLunarNativeModel.fromJson(element));
      }
    }

    return monthLunarDatas;
  }

  Future<List<DayLunarNativeMode>> getDayLunarNative(
      int month, int leap, int year) async {
    List<DayLunarNativeMode> dayLunarDatas = [];
    try {
      var data = await platform.invokeMethod(ChannelEndpoint.getDayLunar,
          {'month': month, 'leap': leap, 'year': year});
      debugPrint('day_lunar$data');

      if (data is String) {
        data = jsonDecode(data);
      }

      for (var dataJson in data) {
        dayLunarDatas.add(
            DayLunarNativeMode.fromJson(Map<String, dynamic>.from(dataJson)));
      }
      return dayLunarDatas;
    } catch (e) {
      List data = [];

      data = mockDataDay;

      for (var element in data) {
        dayLunarDatas.add(DayLunarNativeMode.fromJson(element));
      }
    }

    return dayLunarDatas;
  }

  // List<int> solaToLunar(String time)async{
  //     var data = await platform.invokeMethod(ChannelEndpoint.getDayLunar,
  //         {'time': time});

  // }
  // List<int> lunarToSolar(String time)async{
  //     var data = await platform.invokeMethod(ChannelEndpoint.getDayLunar,
  //         {'time': time});

  // }

  final mockDataDay = [
    {"day": 1, "dayOfWeek": 1},
    {"day": 2, "dayOfWeek": 2},
    {"day": 3, "dayOfWeek": 3},
    {"day": 4, "dayOfWeek": 4},
    {"day": 5, "dayOfWeek": 5},
    {"day": 6, "dayOfWeek": 6},
    {"day": 7, "dayOfWeek": 7},
    {"day": 8, "dayOfWeek": 1},
    {"day": 9, "dayOfWeek": 2},
    {"day": 10, "dayOfWeek": 3},
    {"day": 11, "dayOfWeek": 4},
    {"day": 12, "dayOfWeek": 5},
    {"day": 13, "dayOfWeek": 5},
    {"day": 14, "dayOfWeek": 5},
    {"day": 15, "dayOfWeek": 5},
    {"day": 16, "dayOfWeek": 5},
    {"day": 17, "dayOfWeek": 5},
    {"day": 18, "dayOfWeek": 5},
    {"day": 19, "dayOfWeek": 5},
    {"day": 20, "dayOfWeek": 5},
    {"day": 21, "dayOfWeek": 5},
    {"day": 22, "dayOfWeek": 5},
    {"day": 23, "dayOfWeek": 5},
    {"day": 24, "dayOfWeek": 5},
    {"day": 25, "dayOfWeek": 5},
    {"day": 26, "dayOfWeek": 5},
    {"day": 27, "dayOfWeek": 5},
    {"day": 28, "dayOfWeek": 5},
    {"day": 29, "dayOfWeek": 5},
    {"day": 30, "dayOfWeek": 5},
    // {"day": 31, "dayOfWeek": 5},
  ];

  final mockDataDayRandom = [
    {"day": 1, "dayOfWeek": 1},
    {"day": 2, "dayOfWeek": 2},
    {"day": 3, "dayOfWeek": 3},
    {"day": 4, "dayOfWeek": 4},
    {"day": 5, "dayOfWeek": 5},
    {"day": 6, "dayOfWeek": 6},
    {"day": 7, "dayOfWeek": 7},
    {"day": 8, "dayOfWeek": 1},
    {"day": 9, "dayOfWeek": 2},
    {"day": 10, "dayOfWeek": 3},
    {"day": 11, "dayOfWeek": 4},
    {"day": 12, "dayOfWeek": 5},
    {"day": 13, "dayOfWeek": 5},
    {"day": 14, "dayOfWeek": 5},
    {"day": 15, "dayOfWeek": 5},
    {"day": 16, "dayOfWeek": 5},
    {"day": 17, "dayOfWeek": 5},
    {"day": 18, "dayOfWeek": 5},
    {"day": 19, "dayOfWeek": 5},
    {"day": 20, "dayOfWeek": 5},
    {"day": 21, "dayOfWeek": 5},
    {"day": 22, "dayOfWeek": 5},
    {"day": 23, "dayOfWeek": 5},
    {"day": 24, "dayOfWeek": 5},
    {"day": 25, "dayOfWeek": 5},
    {"day": 26, "dayOfWeek": 5},
    {"day": 27, "dayOfWeek": 5},
    {"day": 28, "dayOfWeek": 5},
    {"day": 29, "dayOfWeek": 5},
    {"day": 30, "dayOfWeek": 5},
    // {"day": 31, "dayOfWeek": 5},
  ];

  final mockDataMMonth = [
    {"month": 1, "leap": 0},
    {"month": 2, "leap": 0},
    {"month": 3, "leap": 0},
    {"month": 4, "leap": 0},
    {"month": 5, "leap": 0},
    {"month": 6, "leap": 0},
    {"month": 7, "leap": 0},
    {"month": 8, "leap": 0},
    {"month": 9, "leap": 0},
    {"month": 10, "leap": 0},
    {"month": 11, "leap": 0},
    {"month": 12, "leap": 0},
  ];

  final mockDataMMonthLeap = [
    {"month": 1, "leap": 0},
    {"month": 2, "leap": 0},
    {"month": 2, "leap": 1},
    {"month": 3, "leap": 0},
    {"month": 4, "leap": 0},
    {"month": 5, "leap": 0},
    {"month": 6, "leap": 0},
    {"month": 7, "leap": 0},
    {"month": 8, "leap": 0},
    {"month": 9, "leap": 0},
    {"month": 10, "leap": 0},
    {"month": 11, "leap": 0},
    {"month": 12, "leap": 0},
  ];
}
