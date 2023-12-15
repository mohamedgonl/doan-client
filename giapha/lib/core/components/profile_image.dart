import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giapha/core/constants/icon_constrants.dart';
import 'package:giapha/core/constants/image_constrants.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/shared/helpers/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage(
      {super.key, required this.initals, required this.memberInfo});
  final String initals;
  final MemberInfo? memberInfo;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  File? avatarFile;
  final imageHelper = ImageHelper();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final file = await imageHelper.pickImage();
        if (file != null) {
          final croppedFile = await imageHelper.crop(file: file);
          if (croppedFile != null) {
            setState(() {
              avatarFile = File(croppedFile.path);
            });
          }
        }
      },
      child: Stack(
        children: [
          SizedBox(
            width: 100.w,
            height: 100.w,
            child: Center(
              child: Container(
                width: 98.w,
                height: 98.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  width: 98.w,
                  height: 98.w,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(49.w),
                      child: avatarFile != null
                          ? Image.file(
                              File(avatarFile!.path),
                              fit: BoxFit.cover,
                            )
                          : (widget.memberInfo != null &&
                                  widget.memberInfo!.avatar != null
                              ? CachedNetworkImage(
                                  imageUrl:
                                      "https://image.tienphong.vn/w890/Uploaded/2023/Osgmky/4/db8/4db8691d741869646ed3c8ad0d123839.jpg")
                              : SvgPicture.asset(
                                  ImageConstants.imgDefaultAvatar,
                                  width: 98.w,
                                  height: 98.w,
                                ))),
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 2.w,
              right: 2.w,
              child: Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: const Color(0xffE4E6EB),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 4),
                        blurRadius: 4,
                        color: Colors.black.withOpacity(0.5))
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    IconConstants.icCamera,
                    fit: BoxFit.cover,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
