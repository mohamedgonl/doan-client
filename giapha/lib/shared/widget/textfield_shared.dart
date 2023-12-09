import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giapha/core/theme/theme_styles.dart';





class TextFieldShared extends StatefulWidget {
  final TextEditingController textController;
  final String pathIcon;
  final String title;
  final bool fieldRequired;
  final Function(String)? onChange;
  final Function()? onClickField;
  final String? hintText;
  final String? Function(String?)? validate;
  final TextInputType? textInputType;
  final bool? readOnly;
  final bool? enabled;
  final double? paddingBottom;
  final bool noPrefixIcon;
  final Widget? suffixIcon;
  final String? errorText;

  const TextFieldShared({
    super.key,
    required this.textController,
    required this.pathIcon,
    required this.title,
    this.onClickField,
    this.onChange,
    this.validate,
    this.readOnly,
    this.hintText,
    this.enabled,
    this.textInputType,
    this.paddingBottom,
    this.errorText,
    this.suffixIcon,
    this.noPrefixIcon = false,
    this.fieldRequired = false,
  });

  @override
  State<TextFieldShared> createState() => _TextFieldSharedState();
}

class _TextFieldSharedState extends State<TextFieldShared> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.paddingBottom ?? 18.h),
      child: Column(
        children: [
          Row(
            children: [
              if (!widget.noPrefixIcon)
                Padding(
                  padding: EdgeInsets.only(right: 16.w),
                  child: SvgPicture.asset(
                    widget.pathIcon,
                    // package: PackageName.namePackageAddImage,
                  ),
                ),
              SizedBox(
                height: 16.w,
              ),
              Text(
                widget.title,
                style: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                    fontFamily: 'SFUIDisplay',
                    color: const Color(0xff666666),
                    overflow: TextOverflow.ellipsis),
              ),
              SizedBox(
                width: 4.w,
              ),
              if (widget.fieldRequired)
                Text(
                  "*",
                  style: Theme.of(context)
                      .primaryTextTheme
                      .displaySmall!
                      .copyWith(color: const Color(0xffF11A1A)),
                )
            ],
          ),
          SizedBox(
            height: 13.w,
          ),
          InkWell(
            onTap: widget.onClickField,
            child: SizedBox(
              // height: 40,
              child: TextFormField(
                style: Theme.of(context)
                    .primaryTextTheme
                    .displayMedium!
                    .copyWith(color: const Color(0xff222222)),
                controller: widget.textController,
                enableInteractiveSelection: true,
                keyboardType: widget.textInputType,
                validator: widget.validate,
                enabled: widget.enabled,
                onChanged: widget.onChange,
                readOnly: widget.readOnly ?? false,
                decoration: InputDecoration(
                  errorText: widget.errorText,
                  suffixIcon: widget.suffixIcon,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide:
                          const BorderSide(color: Color(0xffD8D8D8), width: 1)),
                  isDense: true,
                  hintText: widget.hintText,
                  hintStyle: ThemeStyles.small400
                      .copyWith(color: const Color(0xffbababa)),
                  isCollapsed: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  // prefixIconConstraints:
                  //     BoxConstraints(minHeight: 26.w, minWidth: 26.w),
                  // prefixIcon: Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 8.w),
                  // child: SvgPicture.asset(
                  //   widget.pathIcon,
                  //   width: 24.w,
                  //   height: 24.w,
                  //   fit: BoxFit.contain,
                  // ),
                  // ),
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 26.w, minWidth: 26.w),

                  // decoration: InputDecoration(
                  //     hintText: widget.hintText,
                  //     hintMaxLines: 1,
                  //     hintStyle: Theme.of(context)
                  //         .primaryTextTheme
                  //         .bodySmall
                  //         ?.copyWith(
                  //             fontFamily: 'SFUIDisplay',
                  //             color: const Color(0xff9D9D9D),
                  //             overflow: TextOverflow.ellipsis),
                  //     suffixIcon: widget.hasSuffixIcon
                  //         ? Padding(
                  //             padding: EdgeInsets.only(right: 12.w),
                  //             child: imageFromLocale(
                  //                 url: IconConstants.icButtonMore),
                  //           )
                  //         : null,
                  //     suffixIconConstraints: BoxConstraints(maxHeight: 24.h),
                  //     contentPadding: EdgeInsets.only(left: 16.w, right: 16.w),
                  //     border: OutlineInputBorder(
                  //         borderSide: const BorderSide(color: Color(0xffD8D8D8)),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     enabledBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(color: Color(0xffD8D8D8)),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     disabledBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(color: Color(0xffD8D8D8)),
                  //         borderRadius: BorderRadius.circular(4)),
                  //     focusedBorder: OutlineInputBorder(
                  //         borderSide: const BorderSide(color: Color(0xff3F85FB)),
                  //         borderRadius: BorderRadius.circular(4))),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
