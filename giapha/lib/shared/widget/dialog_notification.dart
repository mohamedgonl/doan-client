import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogNotification extends StatelessWidget {
  final String title;
  final String content;
  final String okTitle;
  final String cancelTitle;
  final Function() onTapOk;
  final Function() onTapCancel;
  const DialogNotification(
      {Key? key,
      required this.title,
      required this.content,
      required this.okTitle,
      required this.cancelTitle,
      required this.onTapOk,
      required this.onTapCancel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .primaryTextTheme
                .displayMedium
                ?.copyWith(color: const Color(0xFF005CAC)),
          ),
          SizedBox(
            height: 12.h,
          ),
          Text(
            content,
            style: Theme.of(context).primaryTextTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTapOk,
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                      color: const Color(0xFF005CAC),
                      borderRadius: BorderRadius.circular(120.w)),
                  child: Center(
                      child: Text(
                    okTitle,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  )),
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              InkWell(
                onTap: onTapCancel,
                child: Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                      color: const Color(0xff68B1A6),
                      borderRadius: BorderRadius.circular(120.w)),
                  child: Center(
                      child: Text(
                    cancelTitle,
                    style: Theme.of(context)
                        .primaryTextTheme
                        .bodyMedium
                        ?.copyWith(color: Colors.white),
                  )),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
