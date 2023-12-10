class APIResponse {
  final String message;
  final int status;
  final Map<String, dynamic> metadata;

  APIResponse(
      {required this.message, required this.status, required this.metadata});

  factory APIResponse.fromJson(Map<String, dynamic> json) {
    return APIResponse(
        message: json["message"],
        status: json["status"],
        metadata: json["metadata"]);
  }

  
}
