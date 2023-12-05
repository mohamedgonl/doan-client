import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImageNetworkUtils {
  static String getNetworkUrl({required String url}) {
    if (url.isEmpty) return '';
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    } else {
      if (url.startsWith('cdn.lichviet.org')) {
        return 'http://$url';
      } else {
        return 'http://cdn.lichviet.org$url';
      }
    }
  }

  static String getNetworkResizeUrl(String url, double width, double scale,
      {bool bestFit = false, double height = 0}) {
    if (url.isEmpty) return '';
    if (!bestFit) {
      var newUrl = url;
      // neu link hien tai la thumb
      var parts = url.split('/thumb/');
      if (parts.length == 2 &&
          (url.startsWith('http://cdn.lichviet.org') ||
              url.startsWith('http://cms.next.lichviet.org'))) {
        var endParts = parts[1].split('/');
        if (endParts.length > 1) {
          // loai bo kich thuoc sau thumb
          var endUrl = endParts.sublist(1, endParts.length - 1).join('/');
          newUrl = '${parts[0]}/$endUrl';
        }
      }
      if (url.startsWith('http://cdn.lichviet.org')) {
        return newUrl.replaceAll('http://cdn.lichviet.org',
            'http://cdn.lichviet.org/thumb/${(width * scale).toInt()}');
      } else {
        return newUrl.replaceAll('http://cms.next.lichviet.org',
            'http://cms.next.lichviet.org/thumb/${(width * scale).toInt()}');
      }
    } else {
      var newUrl = url;
      // neu link hien tai la best_fit
      var parts = url.split('/bestfit/');
      if (parts.length == 2 &&
          (url.startsWith('http://cdn.lichviet.org') ||
              url.startsWith('http://cms.next.lichviet.org'))) {
        var endParts = parts[1].split('/');
        if (endParts.length > 1) {
          // loai bo kich thuoc sau best_fit
          var endUrl = endParts.sublist(2, endParts.length - 1).join('/');
          newUrl = '${parts[0]}/$endUrl';
        }
      }
      if (url.startsWith('http://cdn.lichviet.org')) {
        return newUrl.replaceAll('http://cdn.lichviet.org',
            'http://cdn.lichviet.org/bestfit/${(width * scale).toInt()}/${(height * scale).toInt()}');
      } else {
        return newUrl.replaceAll('http://cms.next.lichviet.org',
            'http://cms.next.lichviet.org/bestfit/${(width * scale).toInt()}/${(height * scale).toInt()}');
      }
    }
  }

  static Image imageNetworkResizeUsingPrecache({
    required String url,
    required double width,
    required double height,
    required double scale,
    required AlignmentGeometry alignment,
    required BoxFit? fit,
    required Widget? errorWidget,
    required Widget? placeholderWidget,
    bool bestFit = false,
  }) {
    return Image(
      image: CachedNetworkImageProvider(getNetworkResizeUrl(
          getNetworkUrl(url: url), width, scale,
          height: height, bestFit: bestFit)),
      width: width,
      height: height,
      alignment: alignment,
      errorBuilder: (context, _, __) =>
          errorWidget ??
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
          child: placeholderWidget,
        );
      },
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        return child;
      },
      fit: fit,
    );
  }
}
