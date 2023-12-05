class DeepLinkUtilsBase {
  static Map<String, dynamic> handleDeeplinkStringToMap(String deepLink) {
    // example: lichviet://?screen=huongdansd&item_id=1&cate_id=1
    final mapResult = <String, dynamic>{};
    final result = deepLink.replaceAll('lichviet://?', '').split('&');
    for (var param in result) {
      final paramList = param.split('=');
      mapResult[paramList[0]] = paramList[1];
    }
    return mapResult;
  }
}
