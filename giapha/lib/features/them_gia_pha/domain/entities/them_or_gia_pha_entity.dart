// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ThemOrSuaGiaPhaEntity extends Equatable {
  String? giaPhaId;
  final String tenGiaPha;
  final String diaChi;
  final String moTa;
   ThemOrSuaGiaPhaEntity({
    required this.giaPhaId,
    required this.tenGiaPha,
    required this.diaChi,
    required this.moTa,
  });

  @override
  List<Object?> get props => [tenGiaPha, diaChi, moTa];

    Map<String, dynamic> toJSON() {
    return {
      'name': tenGiaPha,
      'address': {
        "display_address" : diaChi
      },
      'description': moTa,
      'familyId': giaPhaId ?? ""
    };
  }
}
