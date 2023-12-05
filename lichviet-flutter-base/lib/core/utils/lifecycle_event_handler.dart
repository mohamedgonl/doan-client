import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class LifecycleEventHandler extends WidgetsBindingObserver {
  final AsyncCallback? onResume;
  final AsyncCallback? onInactive;
  final AsyncCallback? onPaused;
  final AsyncCallback? onDetached;

  LifecycleEventHandler({
    this.onResume,
    this.onInactive,
    this.onPaused,
    this.onDetached,
  });

  @override
  Future didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await onResume?.call();
        break;
      case AppLifecycleState.inactive:
        await onInactive?.call();
        break;
      case AppLifecycleState.paused:
        await onPaused?.call();
        break;
      case AppLifecycleState.detached:
        await onDetached?.call();
        break;
    }
  }
}
