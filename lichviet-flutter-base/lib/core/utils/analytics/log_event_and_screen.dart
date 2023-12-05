import 'package:firebase_analytics/firebase_analytics.dart';

class LogEventAndScreen {
  FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  LogEventAndScreen._();
  static final share = LogEventAndScreen._();
  var lastLogScreen = 'chua_set';
  var lastBannerShowingInScreen = 'chua_show';
  Future<void> setCurrentScreen({
    required String? screenName,
    String screenClassOverride = 'Flutter',
    AnalyticsCallOptions? callOptions,
  }) async {
    if (lastLogScreen == screenName) {
      return;
    }
    lastLogScreen = screenName ?? 'chua_set';
    analytics.setCurrentScreen(
        screenName: screenName,
        screenClassOverride: screenClassOverride,
        callOptions: callOptions);
  }

  Future<void> logEvent({
    required String name,
    Map<String, Object?>? parameters,
    AnalyticsCallOptions? callOptions,
  }) async {
    FirebaseAnalytics.instance.logEvent(
      name: name,
      parameters: parameters,
      callOptions: callOptions,
    );
  }
}
