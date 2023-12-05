import 'dart:async';

import 'network_event.dart';

/// List that contains network events and notifies dependents on updates.
class NetworkLoggerStore {
  static final NetworkLoggerStore _instance = NetworkLoggerStore._internal();

  factory NetworkLoggerStore() {
    return _instance;
  }

  NetworkLoggerStore._internal();

  final events = <NetworkEvent>[];
  final _controller = StreamController<UpdateEvent>.broadcast();
  int _maxRequests = 50;

  set setMaxRequests(int maxRequest) => _maxRequests = maxRequest;

  /// A source of asynchronous network events.
  Stream<UpdateEvent> get stream => _controller.stream;

  /// Notify dependents that [event] is updated.
  void updated(NetworkEvent event) {
    _controller.add(UpdateEvent(event));
  }

  /// Add [event] to [events] list and notify dependents.
  void add(NetworkEvent event) {
    if (events.length == _maxRequests) {
      events.removeLast();
    }
    events.insert(0, event);
    _controller.add(UpdateEvent(event));
  }

  /// Clear [events] and notify dependents.
  void clear() {
    events.clear();
    _controller.add(const UpdateEvent.clear());
  }

  /// Dispose resources.
  void dispose() {
    _controller.close();
  }
}

/// Event notified by [NetworkLoggerStore.stream].
class UpdateEvent {
  const UpdateEvent(this.event);
  const UpdateEvent.clear() : event = null;

  final NetworkEvent? event;
}
