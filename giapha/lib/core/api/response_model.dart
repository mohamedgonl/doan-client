
// ignore_for_file: public_member_api_docs, sort_constructors_first
class ResponseModel {
  final bool status;
  final List<dynamic> data;

  ResponseModel({required this.status, required this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(status: json['status'], data: json['data']);
  }
}