import 'dart:async';

const String sessionExpiredEvent = 'SESSION_EXIPRED';

class EventBusHandler {
  final StreamController<String> _sessionStreamCtrl =
      StreamController<String>.broadcast();

  Stream<String> get stream => _sessionStreamCtrl.stream;

  void fire(String event) {
    _sessionStreamCtrl.add(event);
  }

  void close() {
    _sessionStreamCtrl.close();
  }

  bool checkStreamClosed() {
    return _sessionStreamCtrl.isClosed;
  }
}
