class LichVietMemberModel {
  String? fullName;
  String? id;

  LichVietMemberModel({this.fullName, this.id});

  LichVietMemberModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['full_name'] = fullName;
    data['id'] = id;
    return data;
  }
}
