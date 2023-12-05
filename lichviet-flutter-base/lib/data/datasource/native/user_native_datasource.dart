import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lichviet_flutter_base/data/datasource/native/channel_endpoint.dart';
import 'package:lichviet_flutter_base/data/model/float_button_model.dart';
import 'package:lichviet_flutter_base/data/model/item_model.dart';
import 'package:lichviet_flutter_base/data/model/user_info_native_model.dart';

class UserNativeDatasource {
  final MethodChannel platform;

  UserNativeDatasource(this.platform);

  Future<UserInfoNativeModel> getUserFromNative() async {
    // var data = mockData;
    var data = await platform.invokeMethod(ChannelEndpoint.userInfo);
    debugPrint('userInfo $data');

    if (data is String) {
      data = jsonDecode(data);
    }
    return UserInfoNativeModel.fromJson(Map<String, dynamic>.from(data));
  }

  Future<FloatButtonModel> getFloatButtonFromNative() async {
    var data = await platform.invokeMethod(ChannelEndpoint.getFloatHome);
    debugPrint('floatHome $data');
    if (data is String) {
      data = jsonDecode(data);
    }
    return FloatButtonModel.fromJson(Map<String, dynamic>.from(data));
  }
}

final buttonMockData = {
  "show": "0",
  "icon_image":
      "http://cdn.lichviet.org/upload/lichviet/2021/09/08/photo/image_url/1631091957_mUcix.png",
  "link": "lichviet://?screen=home:minigames"
};

final mockData = {
  "about": "",
  "address": "",
  "premiums": [
    {
      "id": "122219",
      "user_id": "2118882",
      "premium_type_id": "30",
      "start_time": "2022-07-22 14:11:03",
      "end_time": "2122-10-31 22:06:07",
      "renewal_date": "2022-10-31 22:06:07",
      "transaction_id": null,
      "modify_by": "2924611",
      "push_remind": "1",
      "premium_groups": "1",
      "is_pro": 1,
      "place_show_ad": "1"
    },
    {
      "id": "286703",
      "user_id": "2118882",
      "premium_type_id": null,
      "start_time": "2022-09-09 16:59:52",
      "end_time": "2022-12-09 16:59:52",
      "renewal_date": "2022-09-09 16:59:52",
      "transaction_id": null,
      "modify_by": "2924611",
      "push_remind": null,
      "premium_groups": "2",
      "is_pro": 1,
      "place_show_ad": 1
    }
  ],
  "avatar": "/upload/lichviet/2022/06/28/user/avatar/1656412071_gnpNm.jpg",
  "birthday": "1991-11-10 01:00:00",
  // "birthday": "",
  "email": "piza9786@gmail.com",
  "first_name": "",
  "full_name": "Nguyen Littletiger",
  "gender": "",
  "hasFbId": false,
  "hasGgId": true,
  "id": 3816684,
  "ip": "123.31.17.10",
  "is_connect": 0,
  "premium": 1,
  "last_name": "",
  "password": false,
  "phone": "0389123456",
  "role_id": 0,
  "status": 0,
  "secretKey": "cUtuGHvcy4vqvRRm85pQ"
};
