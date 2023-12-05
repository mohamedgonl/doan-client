import 'package:equatable/equatable.dart';

enum PersonRole { viewer, editer, delete }

class Person extends Equatable {
  final String id;
  final String maLichViet;
       String idNhanh;
  final String avatar; // ảnh đại diện
  final String name; // tên người dùng
  final String phone; // số điện thoại
   PersonRole role;
   String idGiaPha;

   Person(
      {required this.avatar ,
      required this.name,
      required this.phone,
      required this.role,
      required this.maLichViet,
      required this.id,
      required this.idGiaPha,
      required this.idNhanh});

  @override
  List<Object?> get props => [
        avatar,
        name,
        phone,
        role,
        maLichViet,
        id,
        idNhanh,
        idGiaPha
      ]; // quyền hạn (có thể chỉnh sửa hay chỉ thể xem)
}
