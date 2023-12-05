// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';

class CayGiaPhaModel {
  final List<List<Member>> rawData;

  CayGiaPhaModel(this.rawData);

  int? getPartnerCount(String id) {
    for (var i in rawData) {
      for (var x in i) {
        if (x.info!.memberId == id) {
          return x.pids?.length;
        } else if (x.pids != null) {
          for (var y in x.pids!) {
            if (y.memberId == id) {
              return 1;
            }
          }
        }
      }
    }
    return null;
  }

  int getMemberCount() {
    int count = 0;
    for (var x in rawData) {
      for (var y in x) {
        count++;
        if (y.pids != null) count += y.pids!.length;
      }
    }
    return count;
  }

  int getChildCount(String? id, int? gen) {
    int count = 0;
    if (gen! + 1 >= rawData.length) return count;
    for (var x in rawData[gen + 1]) {
      if (x.info?.fid == id || x.info?.mid == id) {
        count++;
      }
    }

    return count;
  }

  List<MemberInfo> getChildren(String? fid, String? mid, int? gen) {
    try {
      if (fid == null && mid == null) throw Error();
      List<MemberInfo> children = [];
      // Nếu là thế hệ cuối thì children rỗng
      if (gen! < rawData.length - 1) {
        // Duyệt qua gen + 1 để lấy con
        if (fid != null && mid != null) {
          // Trường hợp đủ id cả bố mẹ
          for (var element in rawData[gen + 1]) {
            if ((element.info?.fid == fid && element.info?.mid == mid) ||
                    (element.info?.mid == fid &&
                        element.info?.fid ==
                            mid) // handle trường hợp set sai cha/mẹ
                ) {
              children.add(element.info!);
            }
          }
        } else {
          // trường hợp chỉ có id 1 parent
          for (var element in rawData[gen + 1]) {
            if ( (element.info?.fid == fid && element.info?.mid == null) ||
                    (element.info?.mid == fid && element.info?.fid == null) // handle trường hợp set sai cha/mẹ
                ) {
              children.add(element.info!);
            }
          }
        }
      }

      return children;
    } catch (e) {
      print(e);
      return [];
    }
  }
}
