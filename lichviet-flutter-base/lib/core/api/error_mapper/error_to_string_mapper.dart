import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lichviet_flutter_base/core/exceptions/exceptions.dart';
import 'package:lichviet_flutter_base/core/extensions/extensions.dart';
part 'error_mapper_item.dart';

class ErrorMapper {
  ErrorMapper._(this._items);

  // Singleton
  static final ErrorMapper instance = ErrorMapper._([
    NoNetworkMapperItem(),
    HttpErrorResponseMapperItem(),
    GeneralErrorMapperItem(),
  ]);

  final List<ErrorToStringMapperItem> _items;

  String _map(BuildContext context, dynamic error,
      [List<ErrorToStringMapperItem>? customItems]) {
    final item = _findItem(error, customItems);
    return item.getDisplay(context, error);
  }

  static String parse(BuildContext context, dynamic error,
      [List<ErrorToStringMapperItem>? customItems]) {
    return instance._map(context, error, customItems);
  }

  ErrorToStringMapperItem _findItem(
      dynamic exception, List<ErrorToStringMapperItem>? customItems) {
    if (customItems != null && customItems.isNotEmpty) {
      final index =
          customItems.indexWhere((element) => element.isMatch(exception));
      if (index >= 0) {
        return customItems[index];
      }
    }
    return _items.firstWhere((element) => element.isMatch(exception));
  }
}
