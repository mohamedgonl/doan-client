import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:giapha/core/values/app_colors.dart';

class CustomDropDown extends StatefulWidget {
  const CustomDropDown({Key? key, this.list, this.onChanged, this.labelText})
      : super(key: key);

  final List<dynamic>? list;
  final void Function(dynamic)? onChanged;
  final String? labelText;

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedValue;
  static final textFormFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: const BorderSide(
      color: AppColors.grey,
      width: 1.6,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          value: selectedValue,
          hint: Row(
            children: [
              const SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  widget.labelText ?? "",
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(textFormFieldBorder.borderSide),
              borderRadius: textFormFieldBorder.borderRadius,
            ),
          ),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              border: Border.fromBorderSide(textFormFieldBorder.borderSide),
              borderRadius: textFormFieldBorder.borderRadius,
            ),
          ),
          onChanged: (value) {
            setState(() {
              selectedValue = value.toString();
            });
            widget.onChanged!(value);
          },
          isExpanded: true,
          items: widget.list?.map((e) {
            return DropdownMenuItem(
              value: e.value,
              child: Text(e.text),
            );
          }).toList(),
        ),
      ),
    );
  }
}
