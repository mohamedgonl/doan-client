import 'package:giapha/features/access/data/models/Address.dart';
import 'package:giapha/core/values/api_endpoint.dart';

class UserInfo {
  final String name;
  final String email;
  final String password;
  final String phone;
  final String gender;
  final Address address;

  UserInfo(this.name, this.email, this.password, this.phone, this.gender,
      this.address);
}
