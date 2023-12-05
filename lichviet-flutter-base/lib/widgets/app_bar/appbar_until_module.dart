import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';
import 'package:lichviet_flutter_base/theme/theme_color.dart';
import 'package:lichviet_flutter_base/widgets/app_bar/ac_app_bar_button.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ModeSearch { search, title }

class AppBarCommon extends StatelessWidget implements PreferredSize {
  final String? titleText;
  final Function() onClickClose;
  final ModeSearch mode;
  final TextEditingController? controllerTextSearch;
  final FocusNode? focusTextSearch;
  final String? hintTitle;
  final Function(String value)? onChangeSearch;
  final ValueNotifier<String> searchText = ValueNotifier('');
  final Function()? onClickToSearhScreen;
  bool? showSearchIcon;
  Color? colorBackground;
  double? fontSizeTitle;

  AppBarCommon(
      {key,
      required this.mode,
      required this.onClickClose,
      this.controllerTextSearch,
      this.titleText,
      this.focusTextSearch,
      this.hintTitle,
      this.onChangeSearch,
      this.onClickToSearhScreen,
      this.showSearchIcon,
      this.colorBackground,
      this.fontSizeTitle});

  Widget appBarTitle() {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 45.h,
      // shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      backgroundColor: colorBackground ?? ThemeColor.primary,
      elevation: 0,
      titleSpacing: 0,

      leading: AcAppBarButton.custom(
          onPressed: () {
            onClickClose();
          },
          child: SvgPicture.asset(
            IconBaseConstants.icBack,
            width: 22.w,
            height: 22.w,
            color: Colors.white,
          )),
      // title
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              titleText ?? '',
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: fontSizeTitle ?? 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),

      leadingWidth: 40.w,
      actions: [
        // btnSearch
        showSearchIcon == false
            ? SizedBox(
                width: 40.w,
              )
            : IconButton(
                onPressed: () {
                  if (onClickToSearhScreen != null) {
                    onClickToSearhScreen!();
                  }
                },
                icon: Image.asset(
                  IconBaseConstants.iconSearch2,
                  fit: BoxFit.fitHeight,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  width: 20.w,
                  height: 20.w,
                ),
              ),
      ],
    );
  }

  Widget appBarSearch() {
    return AppBar(
      centerTitle: true,
      toolbarHeight: 45.h,
      shadowColor: Colors.transparent,
      automaticallyImplyLeading: false,
      backgroundColor: colorBackground ?? ThemeColor.primary,
      elevation: 0,
      titleSpacing: 0,
      leading: AcAppBarButton.custom(
          onPressed: () {
            onClickClose();
          },
          child: SvgPicture.asset(
            IconBaseConstants.icBack,
            width: 22.w,
            height: 22.w,
            color: Colors.white,
          )),

      // title
      title: Row(
        children: [
          Expanded(
              child: Container(
            height: 30.h,
            margin: EdgeInsets.only(right: 0.w),
            child: Stack(
              children: [
                TextField(
                  controller: controllerTextSearch,
                  scrollPadding: EdgeInsets.zero,
                  focusNode: focusTextSearch,
                  cursorHeight: 18.sp,
                  decoration: InputDecoration(
                    hintText: hintTitle,
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 186, 191, 197)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        gapPadding: 0,
                        borderSide: BorderSide.none),
                    contentPadding: EdgeInsets.only(top: 4),

                    prefixIcon: const Icon(Icons.search,
                        color: Color.fromARGB(255, 186, 191, 197)),
                    filled: true,
                    fillColor: Colors.white,
                    // contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
                  textInputAction: TextInputAction.search,
                  onChanged: (text) {
                    if (onChangeSearch != null) {
                      onChangeSearch!(text);
                    }
                  },
                ),
                // btnDelete text
                ValueListenableBuilder<String>(
                  valueListenable: searchText,
                  builder: (BuildContext context, String value, Widget? child) {
                    return Visibility(
                      visible: value.isNotEmpty,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 20.w,
                          height: 20.w,
                          margin: EdgeInsets.only(right: 16.w),
                          child: InkWell(
                            onTap: () {
                              controllerTextSearch?.text = '';
                            },
                            child: Image.asset(
                              IconBaseConstants.icDeleteTextFeild,
                              fit: BoxFit.cover,
                              width: 10.w,
                              height: 10.w,
                              color: const Color.fromARGB(255, 200, 200, 200),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          )),
          SizedBox(
            width: 16.w,
          )
        ],
      ),

      leadingWidth: 45.w,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (mode == ModeSearch.title) {
      return appBarTitle();
    } else {
      return appBarSearch();
    }
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size(double.infinity, 50.w);
}
