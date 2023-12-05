import 'package:lichviet_flutter_base/core/utils/format_datetime.dart';
import 'package:lichviet_flutter_base/domain/entities/user_entity.dart';

class UserUtils {
  // 1: pro hien tai, 2: pro xem ngay tot
  static bool checkProGroup(UserEntity? userInfo, String groupId) {
    if (userInfo == null) {
      return false;
    } else {
      final premiumList = userInfo.premiums;
      if (premiumList == null || premiumList.isEmpty) {
        return false;
      } else {
        final index = premiumList
            .indexWhere((element) => element.premiumGroups == groupId);
        if (index == -1) {
          return false;
        } else {
          final premiumResult = premiumList[index];
          if (premiumResult.isPro == "1" && premiumResult.placeShowAd == '1') {
            return true;
          }
          return false;
        }
      }
    }
  }

  static bool checkProGroupAndAds(UserEntity? userInfo, String groupId) {
    if (userInfo == null) {
      return false;
    } else {
      final premiumList = userInfo.premiums;
      if (premiumList == null || premiumList.isEmpty) {
        return false;
      } else {
        final index = premiumList
            .indexWhere((element) => element.premiumGroups == groupId);
        if (index == -1) {
          return false;
        } else {
          final premiumResult = premiumList[index];
          if (premiumResult.isPro == "1") {
            return true;
          }
          return false;
        }
      }
    }
  }

  static bool checkAllPro(UserEntity? userInfo) {
    if (userInfo == null) {
      return false;
    } else {
      if (userInfo.premiums == null || userInfo.premiums!.isEmpty) {
        return false;
      } else {
        for (var premium in userInfo.premiums!) {
          if (premium.isPro == "1" && premium.placeShowAd == '1') {
            return true;
          }
        }
        return false;
      }
    }
  }

  static String getFullName(UserEntity? userInfo) {
    if (userInfo != null) {
      if (userInfo.fullName == null || userInfo.fullName!.isEmpty) {
        return (userInfo.firstName ?? "") +
            ((userInfo.firstName != null && userInfo.firstName!.isNotEmpty)
                ? ' '
                : '') +
            (userInfo.lastName ?? "");
      }
      return userInfo.fullName!;
    }
    return "";
  }

  static String getExperienceTime(UserEntity? userInfo) {
    if (userInfo == null) {
      return '';
    } else if (userInfo.premiums!.isEmpty) {
      return '';
    } else {
      DateTime? timeExperience;
      for (var element in userInfo.premiums!) {
        if (element.isPro == '1' && element.placeShowAd == '1') {
          DateTime timeNew =
              DateTimeCommon.formatStringToDateZ(element.endTime!);
          if (timeExperience == null) {
            timeExperience = timeNew;
          } else if (timeNew.isAfter(timeExperience)) {
            timeExperience = timeNew;
          }
        }
      }
      if (timeExperience == null) return '';
      return DateTimeCommon.formatDateTime2(timeExperience);
    }
  }

  static String getExperienceTimeOfGroup(UserEntity? userInfo, String groupId) {
    if (userInfo == null) {
      return '';
    } else if (userInfo.premiums!.isEmpty) {
      return '';
    } else {
      DateTime? timeExperience;
      for (var element in userInfo.premiums!) {
        if (element.isPro == '1' &&
            element.placeShowAd == '1' &&
            element.id == groupId) {
          DateTime timeNew =
              DateTimeCommon.formatStringToDateZ(element.endTime!);
          if (timeExperience == null) {
            timeExperience = timeNew;
          } else if (timeNew.isAfter(timeExperience)) {
            timeExperience = timeNew;
          }
        }
      }
      if (timeExperience == null) return '';
      return DateTimeCommon.formatDateTime2(timeExperience);
    }
  }

  static bool checkHasExperienceTimeOfGroup(
      UserEntity? userInfo, String groupId) {
    if (userInfo == null) {
      return false;
    } else {
      final premiumList = userInfo.premiums;
      if (premiumList == null || premiumList.isEmpty) {
        return false;
      } else {
        final index = premiumList
            .indexWhere((element) => element.premiumGroups == groupId);
        if (index == -1) {
          return false;
        } else {
          final premiumResult = premiumList[index];
          if (premiumResult.endTime != null &&
              premiumResult.endTime!.isNotEmpty) {
            return true;
          }
          return false;
        }
      }
    }
  }

  static List<ServiceDate> getListTimeServiceDate(UserEntity? userInfo) {
    if (userInfo == null) {
      return [];
    } else if (userInfo.premiums!.isEmpty) {
      return [];
    } else {
      List<ServiceDate> listServiceDate = [];
      for (var element in userInfo.premiums!) {
        DateTime dateTime =
            DateTimeCommon.formatStringToDateZ(element.endTime!);
        if (dateTime.isBefore(DateTime.now())) {
          continue;
        }
        if (element.isPro != "1") {
          continue;
        }
        if (element.premiumGroups == '1') {
          listServiceDate
              .removeWhere((element) => element.name == 'Lịch Việt PRO');
          listServiceDate.add(ServiceDate(
              "Lịch Việt PRO", element.endTime!, element.thumb ?? ''));
        }
        if (element.premiumGroups == '2') {
          listServiceDate
              .removeWhere((element) => element.name == 'Chọn ngày tốt');
          listServiceDate.add(ServiceDate(
              "Chọn ngày tốt", element.endTime!, element.thumb ?? ''));
        }

        if (element.premiumGroups == '3') {
          listServiceDate
              .removeWhere((element) => element.name == 'Xem phong thủy');
          listServiceDate.add(ServiceDate(
              "Xem phong thủy", element.endTime!, element.thumb ?? ''));
        }
        if (element.premiumGroups == '5') {
          listServiceDate
              .removeWhere((element) => element.name == 'Lục Hào');
          listServiceDate.add(ServiceDate(
              "Lục Hào", element.endTime!, element.thumb ?? ''));
        }
        if (element.premiumGroups == '6') {
          listServiceDate
              .removeWhere((element) => element.name == 'Giải mã ngày sinh');
          listServiceDate.add(ServiceDate(
              "Giải mã ngày sinh", element.endTime!, element.thumb ?? ''));
        }
      }

      return listServiceDate;
    }
  }

  static bool checkLogin(UserEntity? userInfo) {
    if (userInfo == null) {
      return false;
    } else if (userInfo.id == null) {
      return false;
    } else {
      return true;
    }
  }
}

class ServiceDate {
  String name;
  String dateTime;
  String icon;
  ServiceDate(this.name, this.dateTime, this.icon);
}
