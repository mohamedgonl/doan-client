class APIResponse {
  final String message;
  final bool status;
  final int statusCode;
  final dynamic metadata;

  APIResponse(
      {required this.message,
      required this.status,
      required this.metadata,
      required this.statusCode});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
        message: json["message"],
        status: json["status"],
        statusCode: json["statusCode"],
        metadata: json["metadata"]);
  }
}
