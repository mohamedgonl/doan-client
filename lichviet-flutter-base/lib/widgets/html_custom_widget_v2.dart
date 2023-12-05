import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/widgets/flutter_html/flutter_html.dart';

class HtmlCustomWidgetV2 extends StatefulWidget {
  final String content;
  final Function(String) onLinkTap;
  final Function(String, Map<String, String>) onImageTap;
  const HtmlCustomWidgetV2({
    Key? key,
    required this.content,
    required this.onLinkTap,
    required this.onImageTap,
  }) : super(key: key);

  @override
  State<HtmlCustomWidgetV2> createState() => _HtmlCustomWidgetV2State();
}

class _HtmlCustomWidgetV2State extends State<HtmlCustomWidgetV2> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.content,
      tagsList: Html.tags,
      onLinkTap: (url, context, attributes, element) {
        widget.onLinkTap(url ?? '');
      },
      onImageTap: (url, context, attributes, element) {
        widget.onImageTap(url ?? '', attributes);
      },
    );
  }
}
