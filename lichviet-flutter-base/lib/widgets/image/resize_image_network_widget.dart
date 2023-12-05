import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lichviet_flutter_base/core/core.dart';

class ResizeImageNetworkWidget extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholderWidget;
  final double? widthCache;

  const ResizeImageNetworkWidget({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.placeholderWidget,
    this.widthCache,
  }) : super(key: key);

  @override
  State<ResizeImageNetworkWidget> createState() =>
      _ResizeImageNetworkWidgetState();
}

class _ResizeImageNetworkWidgetState extends State<ResizeImageNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).devicePixelRatio;
    if (widget.url.isEmpty) {
      return SizedBox(
        width: widget.width,
        height: widget.height,
        child: SvgPicture.asset(IconBaseConstants.icPlaceHolder),
      );
    }
    return CachedNetworkImage(
      imageUrl: ImageNetworkUtils.getNetworkResizeUrl(
          ImageNetworkUtils.getNetworkUrl(url: widget.url),
          widget.widthCache ?? widget.width,
          scale),
      width: widget.width,
      height: widget.height,
      placeholder: (context, _) => Center(
        child: widget.placeholderWidget ??
            SvgPicture.asset(IconBaseConstants.icPlaceHolder),
      ),
      errorWidget: (context, _, __) =>
          widget.errorWidget ??
          SvgPicture.asset(IconBaseConstants.icPlaceHolder),
      fit: widget.fit,
    );
  }
}
