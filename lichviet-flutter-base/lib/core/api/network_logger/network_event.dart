import 'dart:math';

/// Network event log entry.
class NetworkEvent {
  String id;
  Request? request;
  Response? response;
  NetworkError? error;
  DateTime? startTime;
  DateTime? endTime;

  NetworkEvent({
    this.request,
    this.response,
    this.error,
    this.startTime,
    this.endTime,
  }) : id = RequestId().getRandomString();

  NetworkEvent.now({
    this.request,
    this.response,
    this.error,
    this.endTime,
  })  : startTime = DateTime.now(),
        id = RequestId().getRandomString();
}

/// Used for storing [Request] and [Response] headers.
class Headers {
  Headers(Iterable<MapEntry<String, String>> entries)
      : entries = entries.toList();
  Headers.fromMap(Map<String, String> map)
      : entries = map.entries as List<MapEntry<String, String>>;

  final List<MapEntry<String, String>> entries;

  bool get isNotEmpty => entries.isNotEmpty;
  bool get isEmpty => entries.isEmpty;

  Iterable<T> map<T>(T Function(String key, String value) cb) =>
      entries.map((e) => cb(e.key, e.value));
}

/// Http request details.
class Request {
  Request({
    required this.uri,
    required this.method,
    required this.headers,
    this.data,
  });

  final String uri;
  final String method;
  final Headers headers;
  final dynamic data;
}

/// Http response details.
class Response {
  Response({
    required this.headers,
    required this.statusCode,
    required this.statusMessage,
    this.data,
  });

  final Headers headers;
  final int statusCode;
  final String statusMessage;
  final dynamic data;
}

/// Network error details.
class NetworkError {
  NetworkError({required this.message});

  final String message;

  @override
  String toString() => message;
}

class RequestId {
  final Random _rnd = Random();

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  String getRandomString({int? length = 24}) => String.fromCharCodes(
        Iterable.generate(
          length!,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
