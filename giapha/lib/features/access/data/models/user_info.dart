class UserInfo {
  final String userId;
  final String name;
  final String email;
  final String password;
  final String phone;

  // final String gender;
  // final Address address;

  UserInfo(this.userId, this.name, this.email, this.password, this.phone);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    return data;
  }

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(json['_id'] ?? "", json['name'] ?? "", json['email'] ?? "",
        json['password'] ?? "", json['phone'] ?? "");
  }
}
