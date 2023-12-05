class ResponseModel {
  final bool status;
  final dynamic data;

  ResponseModel({required this.status, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      status: json['status'],
      data: json['data'],
    );
  }
}
