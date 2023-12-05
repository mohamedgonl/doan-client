import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResizeImageLocalWidget extends StatefulWidget {
  final String url;
  final double width;
  final double height;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Widget? placeholderWidget;

  const ResizeImageLocalWidget(
      {Key? key,
      required this.url,
      required this.width,
      required this.height,
      this.fit,
      this.errorWidget,
      this.placeholderWidget})
      : super(key: key);

  @override
  State<ResizeImageLocalWidget> createState() => _ResizeImageLocalWidgetState();
}

class _ResizeImageLocalWidgetState extends State<ResizeImageLocalWidget> {
  @override
  Widget build(BuildContext context) {
    final scale = MediaQuery.of(context).devicePixelRatio;
    return Image(
      image: ResizeImage(
        AssetImage(widget.url),
        width: (widget.width * scale).toInt(),
        height: (widget.height * scale).toInt(),
      ),
      width: widget.width,
      height: widget.height,
      errorBuilder: (context, _, __) =>
          widget.errorWidget ??
          Center(
            child: SizedBox(
              width: 40.w,
              height: 40.w,
              child: const Icon(Icons.error),
            ),
          ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return Center(
          child: widget.placeholderWidget,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
      fit: widget.fit,
    );
  }
}
