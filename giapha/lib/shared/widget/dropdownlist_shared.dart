import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giapha/core/constants/package_name.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class DropDownListShared extends StatefulWidget {
  final Function(dynamic)? onChanged;
  final dynamic value;
  final String? hintText;
  final List<DropdownMenuItem> items;
  final String pathIcon;
  final String title;
  final String? Function(String?)? validate;
  final TextInputType? textInputType;
  final bool? readOnly;
  final bool? enabled;
  final double? paddingBottom;
  final bool noPrefixIcon;
  final double? borderRadius;
  const DropDownListShared({
    super.key,
    this.onChanged,
    this.hintText,
    this.value,
    required this.items,
    required this.title,
    this.validate,
    this.textInputType,
    this.readOnly,
    this.enabled,
    this.paddingBottom,
    this.borderRadius,
    this.noPrefixIcon = false,
    required this.pathIcon,
  });

  @override
  State<DropDownListShared> createState() => _DropDownListSharedState();
}

class _DropDownListSharedState extends State<DropDownListShared> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: widget.paddingBottom ?? 24.h),
      child: DropdownButtonFormField(
        value: widget.value,
        items: widget.items,
        isExpanded: false,
        onChanged: widget.onChanged,
        hint: Text(widget.hintText ?? ""),
        // onTap: widget.onChanged,
        decoration: InputDecoration(
            label: Text(widget.title),
            hintText: widget.hintText,
            hintMaxLines: 1,
            helperMaxLines: 5,
            hintStyle: Theme.of(context).primaryTextTheme.bodySmall?.copyWith(
                fontFamily: 'SFUIDisplay',
                color: const Color(0xff9D9D9D),
                height: 2),
            prefixIcon: !widget.noPrefixIcon
                ? Padding(
                    padding: EdgeInsets.only(left: 12.w, right: 16.w),
                    child: SvgPicture.asset(
                      widget.pathIcon,
                      package: PackageName.namePackageAddImage,
                    ),
                  )
                : SizedBox(
                    width: 16.w,
                  ),
            prefixIconConstraints: BoxConstraints(maxHeight: 24.h),
            contentPadding: EdgeInsets.symmetric(vertical: 0.h),
            border: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD8D8D8)),
                borderRadius:
                    BorderRadius.circular(widget.borderRadius ?? 4.r)),
            disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xffD8D8D8)),
                borderRadius: BorderRadius.circular(4)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xff3F85FB)),
                borderRadius: BorderRadius.circular(4))),
      ),
    );
  }
}
