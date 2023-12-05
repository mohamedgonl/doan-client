import 'package:dio/dio.dart';
import 'package:giapha/core/constants/authentication.dart';
import 'package:giapha/core/constants/endpoint_constrants.dart';
import 'package:giapha/features/chia_se/data/models/person_model.dart';
import 'package:giapha/features/chia_se/data/models/response_model.dart';
import 'package:giapha/features/chia_se/domain/entities/Person.dart';
import 'package:lichviet_flutter_base/core/core.dart';

abstract class ChiaSeRemoteDataSource {
  Future<String> createLinkShare(String option);
  Future<List<Person>> getPeopleShared(String giaPhaId);
  Future<void> setAccessions(List<Person> people);
  Future<List<Person>> search(String searchString, String idGiaPha);
  Future<void> saveEveryChanges(List<Person> choosedPeople,
      List<Person> sharedPeople, PersonRole generalRole);
}

class ChiaSeRemoteDataSourceImpl implements ChiaSeRemoteDataSource {
  final ApiHandler _apiHandler;
  late ResponseModel response;

  ChiaSeRemoteDataSourceImpl(this._apiHandler);

  @override
  Future<String> createLinkShare(String option) async {
    print('call create link');
    await _apiHandler.post( EndPointConstrants.domain + EndPointConstrants.taoLinkChiaSe, parser: (json) {
      response = ResponseModel.fromJson(json);
    },
        body: {
          "options": option,
          "memberid": "985cdf89-eade-4e6e-83f1-d3a3416c44ff"
        },
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }));

    if (response.status == true) {
      final String link = response.data;
      return link;
    } else {
      throw ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<List<Person>> getPeopleShared(String giaPhaId) async {
    await _apiHandler.post( EndPointConstrants.domain +EndPointConstrants.layUsersDuocChiaSe,
        parser: (json) {
      print(json);
      response = ResponseModel.fromJson(json);
    },
        body: {"genealogy": giaPhaId},
        options: Options(headers: {
          "userid": Authentication.userid,
          "secretkey": Authentication.secretkey,
        }));

    if (response.status == true) {
      final danhsach = <Person>[];

      for (var e in response.data) {
        danhsach.add(PersonModel.fromJson(e));
      }
      return danhsach;
    } else {
      throw ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<void> setAccessions(List<Person> people) async {
    for (var i = 0; i < people.length; i++) {
      await _apiHandler.post( EndPointConstrants.domain +EndPointConstrants.capNhapQuyen, parser: (json) {
        response = ResponseModel.fromJson(json);
      },
          body: {
            "memberid": people[i].idNhanh,
            "userid": people[i].id,
            "options": people[i].role == PersonRole.editer ? "edit" : "view"
          },
          options: Options(headers: {
            "userid": Authentication.userid,
            "secretkey": Authentication.secretkey,
          }));
    }
  }

  @override
  Future<List<Person>> search(String searchString, String idGiaPha) async {
    // await _apiHandler.post(EndPointConstrants.searchNguoiDung, parser: (json) {
    //   response = ResponseModel.fromJson(json);
    // },
    //     body: {"genealogy": idGiaPha, "name": searchString},
    //     options: Options(headers: {
    //       "userid": Authentication.userid,
    //       "secretkey": Authentication.secretkey,
    //     }));
    final jsonData = {
      "status": true,
      "data": [
        {
          "id": "1",
          "name": "Le Ton A",
          "ma_lich_viet": "3",
          "phan_quyen": "1",
          "id_nhanh": "2",
          "user_id": "1",
          "phone": "2",
          "avatar":
              "https://ment-wordpress.s3.ap-southeast-1.amazonaws.com/gametop/2022/04/26044210/https-lh6-googleusercontent-com-aom0fqucsib6m-zl-1024x576.jpeg"
        },
        {
          "id": "2",
          "name": "Le Ton C",
          "ma_lich_viet": "4",
          "phan_quyen": "41",
          "id_nhanh": "2-ede-4e6e-83f1-d3a3416c44ff",
          "user_id": "c533d7ed-2-47a1-b619-a6b5e7315c38",
          "phone": "1",
          "avatar":
              "https://ment-wordpress.s3.ap-southeast-1.amazonaws.com/gametop/2022/04/26044210/https-lh6-googleusercontent-com-aom0fqucsib6m-zl-1024x576.jpeg"
        },
        {
          "id": "3",
          "name": "Dan thuong",
          "ma_lich_viet": "000001",
          "phan_quyen": "1",
          "id_nhanh": "985cdf89-ead-4e6e-83f1-d3a3416c44ff",
          "user_id": "c533d7ed-a6e-47a1-b619-a6b5e7315c38",
          "phone": "1122132143243423423423423",
          "avatar":
              "https://ment-wordpress.s3.ap-southeast-1.amazonaws.com/gametop/2022/04/26044210/https-lh6-googleusercontent-com-aom0fqucsib6m-zl-1024x576.jpeg"
        }
      ]
    };
    response = ResponseModel.fromJson(jsonData);

    if (response.status == true) {
      final danhsach = <Person>[];

      for (var e in response.data) {
        danhsach.add(PersonModel.fromJson(e));
      }
      return danhsach;
    } else {
      throw ServerException("Lỗi hệ thống hoặc kết nối mạng có vấn đề! Vui lòng thử lại");
    }
  }

  @override
  Future<String> saveEveryChanges(List<Person> choosedPeople,
      List<Person> sharedPeople, PersonRole personRole) async {
    return '';
  }
}
