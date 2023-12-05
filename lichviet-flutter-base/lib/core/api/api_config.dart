class ApiConfig {
  String baseUrl;
  String env;
  bool enableLogger;

  ApiConfig({
    required this.env,
    required this.baseUrl,
    this.enableLogger = false,
  });
}
