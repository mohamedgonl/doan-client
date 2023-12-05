import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lichviet_flutter_base/widgets/flutter_html/flutter_html.dart';
import 'package:lichviet_flutter_base/widgets/image/resize_image_network_widget.dart';

class HtmlCustomWidget extends StatefulWidget {
  final String content;
  final Function(String) onLinkTap;
  final Function(String, Map<String, String>) onImageTap;
  const HtmlCustomWidget({
    Key? key,
    required this.content,
    required this.onLinkTap,
    required this.onImageTap,
  }) : super(key: key);

  @override
  State<HtmlCustomWidget> createState() => _HtmlCustomWidgetState();
}

class _HtmlCustomWidgetState extends State<HtmlCustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.content,
      shrinkWrap: true,
      style: {
        "div": Style(margin: EdgeInsets.zero),
        "body": Style(margin: EdgeInsets.zero, padding: EdgeInsets.zero),
      },
      customRender: {
        "imgfullwidth": (context, parsedChild) {
          var widthSv = double.tryParse(
                  context.tree.element!.attributes['width'] ?? "") ??
              ScreenUtil().screenWidth;
          var heightSv = double.tryParse(
                  context.tree.element!.attributes['height'] ?? "0") ??
              0;
          return ResizeImageNetworkWidget(
              url: context.tree.element!.attributes['src'] ?? "",
              width: ScreenUtil().screenWidth,
              height: heightSv * (ScreenUtil().screenWidth / widthSv));
        },
      },
      tagsList: Html.tags
        ..addAll([
          "imgfullwidth", // background (link ảnh), imgButton, backgroundheight (theo w), buttonheight (theo w), deeplink (optional)
        ]),
      onLinkTap: (url, context, attributes, element) {
        widget.onLinkTap(url ?? '');
      },
      onImageTap: (url, context, attributes, element) {
        widget.onImageTap(url ?? '', attributes);
      },
    );
  }
}
