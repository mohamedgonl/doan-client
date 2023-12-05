import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class ViewColumnItem extends StatelessWidget {
  final List<String> datas;
  final FixedExtentScrollController fixedExtentScrollController;
  final Function(int index) onChange;
  final List<String>? title;
  final int? indexLeapMonth;

  const ViewColumnItem(
      {super.key,
      required this.datas,
      required this.fixedExtentScrollController,
      required this.onChange,
      this.indexLeapMonth,
      this.title});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white,
      child: DefaultTextStyle(
        style: TextStyle(
          color: CupertinoColors.label.resolveFrom(context),
          fontSize: 16.sp,
        ),
        child: CupertinoPicker(
          magnification: 1.22,
          squeeze: 1.2,
          useMagnifier: true,
          itemExtent: 50.h,
          scrollController: fixedExtentScrollController,
          selectionOverlay: Column(
            children: [
              Container(
                height: 0.25,
                width: double.infinity,
                color: const Color(0xffcdced3),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: const Color(0xFFD3CDCD).withAlpha(50),
                ),
              ),
              Container(
                height: 0.25,
                width: double.infinity,
                color: const Color(0xffcdced3),
              ),
            ],
          ),
          // This is called when selected item is changed.
          onSelectedItemChanged: (int selectedItem) {
            onChange(selectedItem);
          },
          children: List<Widget>.generate(datas.length, (int index) {
            return Center(
              child: Text(
                style: TextStyle(
                    color: CupertinoColors.label.resolveFrom(context),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500),
                '${(title ?? []).isEmpty ? '' : title?[index] ?? ''} ${datas[index]}',
              ),
            );
          }),
        ),
      ),
    );
  }
}
