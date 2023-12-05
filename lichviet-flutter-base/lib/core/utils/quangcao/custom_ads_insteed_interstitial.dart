import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/core/core.dart';
import 'package:lichviet_flutter_base/core/utils/quangcao/banner_inline_and_native_advance_mediation.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';

class CustomAdsInsteedInterstitial extends StatelessWidget {
  const CustomAdsInsteedInterstitial(
      {super.key, required this.callbackToClose});
  final Function(bool muaPro) callbackToClose;
  @override
  Widget build(BuildContext context) {
    final maxWidthAds = ScreenUtil().screenWidth - 32.w;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Có thể bạn quan tâm',
                    style: ThemeStyles.big600
                        .copyWith(color: const Color(0xff11223f)),
                  ),
                  InkWell(
                    child: const Icon(Icons.close, size: 24),
                    onTap: () => callbackToClose(false),
                  ),
                ],
              ),
              SizedBox(
                height: 30.w,
              ),
              SizedBox(
                width: double.infinity,
                child: BannerInlineAndNativeAdvanceMediation(
                    maxWidthAds: maxWidthAds.toInt(),
                    showPlaceholderWhenLoading: true),
              ),
              SizedBox(
                height: 30.w,
              ),
              const Text(
                'Quảng cáo là một phần quan trọng để giúp duy trì ứng dụng miễn phí và chúng tôi hiểu quảng cáo có thể gây khó chịu. Ủng hộ Lịch Việt bằng cách mua gói PRO để trải nghiệm các dịch vụ chuyên sâu cho bạn, gia đình và không còn quảng cáo.',
              ),
              SizedBox(
                height: 50.w,
              ),
              ButtonWidget(
                  width: 192.w,
                  height: 36.h,
                  title: 'NÂNG CẤP PRO',
                  onTap: () => callbackToClose(true),
                  background: const Color(0xff3F85FB),
                  titleColor: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final Color background;
  final Color titleColor;
  final Function() onTap;
  final TextAlign? textAlign;
  const ButtonWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.title,
      required this.onTap,
      required this.background,
      required this.titleColor,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(8.r)),
        child: Center(
          child: Text(
            title,
            textAlign: textAlign ?? TextAlign.center,
            style: ThemeStyles.small600.copyWith(color: titleColor),
          ),
        ),
      ),
    );
  }
}
