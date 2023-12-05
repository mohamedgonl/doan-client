import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/src/alert_controller.dart';
import 'package:lichviet_flutter_base/widgets/app_toast/src/model/data_alert.dart';
export 'package:lichviet_flutter_base/widgets/app_toast/src/model/data_alert.dart';

class AppToast {
  AppToast._();
  static final share = AppToast._();
  late BuildContext context;

  void showToast(
    String message, {
    ToastType type = ToastType.warning,
    String? title,
  }) {
    String titleStr = title ?? '';
    if (titleStr == '') {
      if (type == ToastType.error) {
        titleStr = 'Thất bại';
      } else if (type == ToastType.success) {
        titleStr = 'Thành công';
      } else if (type == ToastType.warning) {
        titleStr = 'Lưu ý';
      }
    }
    AlertController.show(titleStr, message, type);
  }
}
