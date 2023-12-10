
class UserInfo {
  final String name;
  final String email;
  final String password;
  final String phone;
  // final String gender;
  // final Address address;

  UserInfo(this.name, this.email, this.password, this.phone,);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    return data;
  }

  
}
