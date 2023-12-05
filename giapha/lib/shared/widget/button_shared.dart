import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonShared extends StatefulWidget {
  final double? widthButton;
  final double? heightButton;
  final String title;
  final void Function() onClickButton;
  final double? paddingHorizon;
  const ButtonShared(
      {super.key,
      required this.title,
      required this.onClickButton,
      this.widthButton,
      this.heightButton,
      this.paddingHorizon});

  @override
  State<ButtonShared> createState() => _ButtonSharedState();
}

class _ButtonSharedState extends State<ButtonShared> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: widget.paddingHorizon ?? 0),
      child: InkWell(
        onTap: widget.onClickButton,
        child: Container(
          width: widget.widthButton,
          height: widget.heightButton ?? 42.w,
          decoration: BoxDecoration(
              color: const Color(0xff3F85FB),
              borderRadius: BorderRadius.circular(8)),
          child: Center(
            child: Text(
              widget.title,
              style: Theme.of(context)
                  .primaryTextTheme
                  .titleSmall!
                  .copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
