import 'package:giapha/features/chia_se/domain/entities/Person.dart';

class PersonModel extends Person {
   PersonModel(
      { required super.name,
      required super.avatar,
      required super.phone,
      required super.role,
      required super.maLichViet,
      required super.id,
      required super.idNhanh,
      required super.idGiaPha});

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      avatar: json['avatar'] ?? "",
      name: json['name'],
      phone: json['phone'] ?? "",
      role: json['phan_quyen'] == '0' ? PersonRole.editer : PersonRole.viewer,
      maLichViet: json['ma_lich_viet'],
      id: json['user_id'],
      idNhanh: json['id_nhanh'],    
      idGiaPha: json['id']
    );
  }
}
