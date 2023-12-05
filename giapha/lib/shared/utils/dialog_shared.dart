import 'package:flutter/material.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/shared/widget/detail_date_popup_widget.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/custom_ads_insteed_interstitial.dart';

class DialogShared {
  static Future<void> showDialogSelect(
    BuildContext context,
    String content, {
    String? title,
    Widget? widgetRichText,
    String? leftButton,
    String? rightButton,
    Function()? onTapLeftButton,
    Function()? onTapRightButton,
    TextAlign? textAlign,
    String icon = IconConstants.icWarningV2,
    String? centerButton,
    Function(BuildContext)? onTapCenterButton,
    bool? showButton = true,
    bool? rootNavigate,
  }) async {
    showDialog(
        context: context,
        useRootNavigator: rootNavigate ?? true,
        builder: (context) => DialogPopupWidget(
              title: title ?? 'THÔNG BÁO',
              content: content,
              widgetRichText: widgetRichText,
              icon: icon,
              textAlign: textAlign,
              buttonWidget: showButton == true
                  ? centerButton != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ButtonWidget(
                                width: 168.w,
                                height: 36.h,
                                title: centerButton,
                                onTap: () {
                                  onTapCenterButton!(context);
                                },
                                background: const Color(0xff3F85FB),
                                titleColor: Colors.white),
                          ],
                        )
                      : Row(
                          children: [
                            SizedBox(
                              width: 20.w,
                            ),
                            Expanded(
                              child: ButtonWidget(
                                  width: double.infinity,
                                  height: 36.h,
                                  title: leftButton!,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    onTapLeftButton!();
                                  },
                                  background: const Color(0xff3F85FB),
                                  titleColor: Colors.white),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: ButtonWidget(
                                  width: double.infinity,
                                  height: 36.h,
                                  title: rightButton!,
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    onTapRightButton!();
                                  },
                                  background: const Color(0xff3F85FB),
                                  titleColor: Colors.white),
                            ),
                            SizedBox(
                              width: 20.w,
                            )
                          ],
                        )
                  : const SizedBox(),
            ));
  }
}
