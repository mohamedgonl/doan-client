import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giapha/core/constants/package_name.dart';
import '../../core/constants/icon_constrants.dart';

class OptionWidget extends StatefulWidget {
  final int indexSelected;
  final List<String> listOption;
  final void Function(int) onTap;
  final MainAxisAlignment? mainAxisAlignment;
  final bool verticalDirection;
  const OptionWidget({
    Key? key,
    required this.indexSelected,
    required this.onTap,
    required this.listOption,
    this.mainAxisAlignment,
    this.verticalDirection = false,
  }) : super(key: key);

  @override
  State<OptionWidget> createState() => _OptionWidgetState();
}

class _OptionWidgetState extends State<OptionWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.verticalDirection
        ? Scrollbar(
            thickness: 5.w,
            thumbVisibility: true,
            child: ListView.builder(
                // shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: widget.listOption.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 16.h),
                        child: InkWell(
                          onTap: () {
                            widget.onTap(index);
                          },
                          child: Row(
                            children: [
                              Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: widget.indexSelected == index
                                        ? const Color(0xff3F85FB)
                                        : const Color(0xffffffff),
                                    border: Border.all(
                                        color: widget.indexSelected == index
                                            ? const Color(0xff3F85FB)
                                            : const Color(0xffD2D2D2),
                                        width: 1),
                                  ),
                                  child: widget.indexSelected == index
                                      ? Center(
                                          child: SvgPicture.asset(
                                            IconConstants.icTick,
                                            package:
                                                PackageName.namePackageAddImage,
                                          ),
                                        )
                                      : const SizedBox.shrink()),
                              SizedBox(
                                width: 20.w,
                              ),
                              Text(
                                widget.listOption[index],
                                style: Theme.of(context)
                                    .primaryTextTheme
                                    .displayMedium
                                    ?.copyWith(color: const Color(0xff333333)),
                              )
                            ],
                          ),
                        ),
                      ),
                      //if (index != widget.listOption.length - 1)
                      Divider(
                        indent: 16.w,
                        endIndent: 16.w,
                        height: 1,
                        thickness: 1,
                      ),
                    ],
                  );
                })),
          )
        : Row(
            mainAxisAlignment:
                widget.mainAxisAlignment ?? MainAxisAlignment.start,
            children: List.generate(
                widget.listOption.length,
                (index) => Padding(
                      padding: EdgeInsets.only(top: 17.h, right: 50.w),
                      child: InkWell(
                        onTap: () {
                          widget.onTap(index);
                        },
                        child: Row(
                          children: [
                            Container(
                                width: 24.w,
                                height: 24.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: widget.indexSelected == index
                                      ? const Color(0xff3F85FB)
                                      : const Color(0xffffffff),
                                  border: Border.all(
                                      color: widget.indexSelected == index
                                          ? const Color(0xff3F85FB)
                                          : const Color(0xffD2D2D2),
                                      width: 1),
                                ),
                                child: widget.indexSelected == index
                                    ? Center(
                                        child: SvgPicture.asset(
                                          IconConstants.icTick,
                                          package:
                                              PackageName.namePackageAddImage,
                                        ),
                                      )
                                    : const SizedBox.shrink()),
                            SizedBox(
                              width: 16.w,
                            ),
                            Text(
                              widget.listOption[index],
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .displayMedium
                                  ?.copyWith(color: const Color(0xff333333)),
                            )
                          ],
                        ),
                      ),
                    )),
          );
  }
}
