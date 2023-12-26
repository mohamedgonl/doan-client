import 'package:dartz/dartz.dart';
import 'package:giapha/core/api/api_service.dart';
import 'package:giapha/core/api/auth_service.dart';
import 'package:giapha/core/api/response_api.dart';
import 'package:giapha/core/exceptions/exceptions.dart';
import 'package:giapha/core/values/api_endpoint.dart';
import 'package:giapha/features/access/data/models/user_info.dart';

class ShareRemoteDataSource {
  Future<List<UserInfo>> timKiemUserTheoText(String keySearch) async {
    APIResponse apiResponse =
        await ApiService.postData(ApiEndpoint.searchUser, {"text": keySearch});

    List<UserInfo> users = [];
    if (apiResponse.status) {
      for (var e in apiResponse.metadata) {
        users.add(UserInfo.fromJson(e));
      }
    }
    return users;
  }

  Future<bool> share(List<UserInfo> list, int role, String familyId) async {
    APIResponse apiResponse =
        await ApiService.postData(ApiEndpoint.shareFamily, {
      "listIds": list.map((e) => e.userId).toList(),
      "role": role,
      "familyId": familyId
    });

    return apiResponse.status;
  }
}
