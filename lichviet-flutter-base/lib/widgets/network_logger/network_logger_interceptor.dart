import 'package:dio/dio.dart' as dio;

import 'network_event.dart';
import 'network_logger_store.dart';

const String _extraRequestId = 'request-id';

class NetworkLoggerInterceptor extends dio.Interceptor {
  static final NetworkLoggerInterceptor _instance =
      NetworkLoggerInterceptor._internal();
  factory NetworkLoggerInterceptor() {
    return _instance;
  }

  NetworkLoggerInterceptor._internal() : store = NetworkLoggerStore();

  final NetworkLoggerStore store;
  final _requests = <String, NetworkEvent>{};
  bool _isEnabled = false;
 
  set setIsEnabled(bool value) => _isEnabled = value;

  @override
  Future<dynamic> onRequest(
      dio.RequestOptions options, dio.RequestInterceptorHandler handler) async {
    if (_isEnabled) {
      final _event = NetworkEvent.now(
        request: options.toRequest(),
        error: null,
        response: null,
      );
      options.extra = {
        _extraRequestId: _event.id,
      };
      super.onRequest(options, handler);
      store.add(_requests[_event.id] = _event);
    } else {
      super.onRequest(options, handler);
    }
    return Future.value(options);
  }

  @override
  void onError(dio.DioError err, dio.ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    if (_isEnabled) {
      final reqId = err.requestOptions.extra[_extraRequestId];
      final event = _requests[reqId];
      if (event != null) {
        _requests.remove(reqId);
        store.updated(
          event
            ..error = err.toNetworkError()
            ..response = err.response?.toResponse()
            ..endTime = DateTime.now(),
        );
      } else {
        store.add(NetworkEvent.now(
          request: err.requestOptions.toRequest(),
          response: err.response?.toResponse(),
          error: err.toNetworkError(),
        ));
      }
    }
  }

  @override
  void onResponse(
      dio.Response response, dio.ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (_isEnabled) {
      final reqId = response.requestOptions.extra[_extraRequestId];
      final event = _requests[reqId];
      if (event != null) {
        _requests.remove(reqId);
        store.updated(
          event
            ..response = response.toResponse()
            ..endTime = DateTime.now(),
        );
      } else {
        store.add(NetworkEvent.now(
          request: response.requestOptions.toRequest(),
          response: response.toResponse(),
        ));
      }
    }
  }
}

extension _RequestOptionsX on dio.RequestOptions {
  Request toRequest() => Request(
        uri: uri.toString(),
        data: data,
        method: method,
        headers: Headers(headers.entries.map(
          (kv) => MapEntry(kv.key, '${kv.value}'),
        )),
      );
}

extension _ResponseX on dio.Response {
  Response toResponse() => Response(
        data: data,
        statusCode: statusCode ?? -1,
        statusMessage: statusMessage ?? 'unkown',
        headers: Headers(
          headers.map.entries.fold<List<MapEntry<String, String>>>(
            [],
            (p, e) => p..addAll(e.value.map((v) => MapEntry(e.key, v))),
          ),
        ),
      );
}

extension _DioErrorX on dio.DioError {
  NetworkError toNetworkError() => NetworkError(message: '[$type] $message');
}
