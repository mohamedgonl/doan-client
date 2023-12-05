import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';
import 'package:lichviet_flutter_base/theme/theme_styles.dart';

class TextInputWidget extends StatefulWidget {
  final GlobalKey<FormState>? formKey;
  final String icon;
  final String hintTitle;
  final String value;
  final TextEditingController textController;
  final bool readOnly;
  final bool enable;
  final bool showSuffixIcon;
  final double? height;
  final double? borderRadius;
  final double? paddingIcon;
  final InputBorder? inputBorder;
  final TextStyle? hintTextstyle;
  final Color? colorIcon;
  final String? Function(String?)? validate;
  final Function()? onTapSuffixIcon;
  final bool obscureText;
  final Function()? checkValidateOutForm;
  final TextInputType? textInputType;
  const TextInputWidget(
      {Key? key,
      required this.icon,
      required this.value,
      required this.hintTitle,
      required this.textController,
      this.enable = false,
      this.readOnly = true,
      this.borderRadius,
      this.height,
      this.paddingIcon,
      this.hintTextstyle,
      this.inputBorder,
      this.colorIcon,
      required this.showSuffixIcon,
      this.validate,
      this.formKey,
      this.onTapSuffixIcon,
      this.obscureText = false,
      this.checkValidateOutForm,
      this.textInputType = TextInputType.text})
      : super(key: key);

  @override
  State<TextInputWidget> createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focusNode.hasFocus.toString()}");
    if (!_focusNode.hasFocus) {
      if (widget.validate != null) {
        if (widget.formKey != null) {
          widget.formKey?.currentState!.validate();
        } else {
          widget.validate;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 21.h)),
          child: TextFormField(
            controller: widget.textController,
            readOnly: widget.readOnly,
            focusNode: _focusNode,
            textAlignVertical: TextAlignVertical.center,
            validator: widget.validate,
            showCursor: true,
            onChanged: (value) {
              if (widget.checkValidateOutForm != null) {
                widget.checkValidateOutForm!();
              }
            },
            obscureText: widget.obscureText,
            keyboardType: widget.textInputType,
            decoration: InputDecoration(
                border: widget.inputBorder ?? InputBorder.none,
                enabled: widget.enable,
                errorStyle: const TextStyle(height: 0),
                hintText: widget.hintTitle,
                hintStyle: widget.hintTextstyle ??
                    ThemeStyles.small400.copyWith(
                        color: const Color(0xff999999),
                        fontStyle: FontStyle.italic),
                isCollapsed: true,
                isDense: true,
                prefixIconConstraints:
                    BoxConstraints(minHeight: 26.w, minWidth: 26.w),
                suffixIconConstraints:
                    BoxConstraints(minHeight: 26.w, minWidth: 26.w),
                prefixIcon: Container(
                  width: 54.w,
                  height: 36.h,
                  padding: EdgeInsets.symmetric(
                      vertical: widget.paddingIcon ?? 10.h),
                  child: SvgPicture.asset(
                    widget.icon,
                    width: 22.w,
                    height: 22.w,
                    fit: BoxFit.contain,
                  ),
                ),
                suffixIcon: widget.showSuffixIcon
                    ? InkWell(
                        onTap: widget.onTapSuffixIcon,
                        child: Container(
                          width: 54.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(
                              vertical: widget.paddingIcon ?? 10.h),
                          child: SvgPicture.asset(
                            IconBaseConstants.icHiden,
                            width: 24.w,
                            height: 24.w,
                            fit: BoxFit.contain,
                            color: widget.colorIcon,
                          ),
                        ),
                      )
                    : const SizedBox()),
          ),
        )
      ],
    );
  }
}
