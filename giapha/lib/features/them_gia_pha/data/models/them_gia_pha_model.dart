import 'package:giapha/core/core_gia_pha.dart';
import 'package:giapha/features/them_gia_pha/domain/entities/them_or_gia_pha_entity.dart';

class ThemGiaPhaModel extends ThemOrSuaGiaPhaEntity {
   ThemGiaPhaModel(
      {
        required super.giaPhaId,
        required super.tenGiaPha,
      required super.tenNhanh,
      required super.diaChi,
      required super.moTa});

  Map<String, dynamic> toJSON() {
    return {
      'ten_gia_pha': tenGiaPha,
      'ten_nhanh': tenNhanh,
      'dia_chi': diaChi,
      'mo_ta': moTa,
      if (giaPhaId.isNotNullOrEmpty) 'genealogy_id': giaPhaId
    };
  }
}
