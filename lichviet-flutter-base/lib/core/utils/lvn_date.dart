import 'dart:math';

import 'package:intl/intl.dart';

const CONST_NORMAL = 0;
const CONST_LEAP = 1;

// Tiet khi
const CONST_XUANPHAN = 1; // Xuan Phan ngay 21/3(Giua xuan)
const CONST_THANHMINH = 2; // Thanh Minh ngay 5/4 (troi trong sang)
const CONST_COCVU = 3; // Co^'c vu~ ngay 20/4 (Mua ra`o)
const CONST_LAPHA = 4; // La^p ha ngay 6/5 (Bat dau mua he)
const CONST_TIEUMAN = 5; // Tie^u ma~n ngay 21/5(Lu nho, duoi vang)
const CONST_MANGCHUNG = 6; // Mang Chu?ng ngay 6/6(Chom sao tua rua moc)
const CONST_HACHI = 7; // Ha Chi ngay 21/6 (Giua he)
const CONST_TIEUTHU = 8; // Tie^?u thuw? ngay 7/7(Nong nhe)
const CONST_DAITHU = 9; // Dai thuw? ngay 23/7(Nong oi)
const CONST_LAPTHU = 10; // Lap thu ngay 7/8(Bat dau mua thu)
const CONST_XUTHU = 11; // ngay 23/8 (Mua ngau)
const CONST_BACHLO = 12; // ngay 8/9 (Nang nhat)
const CONST_THUPHAN = 13; // Ngay 23/9 (Giua thu)
const CONST_HANLO = 14; // Ngay 8/10 (Mat me)
const CONST_SUONGGIANG = 15; // Ngay 23/10 (Suong mu xuat hien)
const CONST_LAPDONG = 16; // Ngay 7/11(Bat dau mua dong)
const CONST_TIEUTUYET = 17; // Ngay 22/11(Tuyet xuat hien)
const CONST_DAITUYEN = 18; // Ngay 7/12(Tuyet day)
const CONST_DONGCHI = 19; // Ngay 22/12(Giua Dong)
const CONST_TIEUHAN = 20; // Ngay 6/1 (Ret nhe)
const CONST_DAIHAN = 21; // Ngay 21/1 (Ret dam)
const CONST_LAPXUAN = 22; // Ngay 4/2 (Bat dau mua xuan)
const CONST_VUTHUY = 23; // Ngay 19/2 (Mua am)
const CONST_KINHTRAP = 24; // Ngay 5/3 (sau no)

const PI = 3.1415926535897932384626433832795;
// Thu trong ngay
const KMonday = 1;
const KTuesday = 2;
const KWednesday = 3;
const KThursday = 4;
const KFriday = 5;
const KSaturday = 6;
const KSunday = 7;

// Can
const KCanGiap = 0;
const KCanAt = 1;
const KCanBinh = 2;
const KCanDinh = 3;
const KCanMau = 4;
const KCanKy = 5;
const KCanCanh = 6;
const KCanTan = 7;
const KCanNham = 8;
const KCanQuy = 9;

final KArrCan = [
  KCanGiap,
  KCanAt,
  KCanBinh,
  KCanDinh,
  KCanMau,
  KCanKy,
  KCanCanh,
  KCanTan,
  KCanNham,
  KCanQuy,
];
// Chi
const KChiTys = 0; // Ty'
const KChiSuu = 1;
const KChiDan = 2;
const KChiMao = 3;
const KChiThin = 4;
const KChiTij = 5; // Ti.
const KChiNgo = 6;
const KChiMui = 7;
const KChiThan = 8;
const KChiDau = 9;
const KChiTuat = 10;
const KChiHoi = 11;

const KArrChi = [
  KChiTys,
  KChiSuu,
  KChiDan,
  KChiMao,
  KChiThin,
  KChiTij,
  KChiNgo,
  KChiMui,
  KChiThan,
  KChiDau,
  KChiTuat,
  KChiHoi,
];

// Hang su dung de chuyen ngay nhanh
const KCanDay0 = KCanQuy;
const KChiDay0 = KChiDau;
const KCanHour0 = KCanNham;

// Mang Hang so ngay so voi nam 0, VD: 0005 - 0000 =  73049 ngay
const KArrNumday = [
  73049,
  219146,
  365243,
  511340,
  657437,
  803534,
  949631,
  1095728,
  1241825,
  1387922,
  1534019,
  1680116,
  1826213,
  1972310,
  2118407,
  2264504,
  2410601,
  2556698,
  2702795,
  2848892,
  2994989,
  3141086,
  3287183,
  3433280,
  3579377,
];

// Goc do cua 24 tiet khi,bat dau la Xuan Phan
final SUNLONG_MAJOR = [
  0,
  PI / 12,
  (2 * PI) / 12,
  (3 * PI) / 12,
  (4 * PI) / 12,
  (5 * PI) / 12,
  (6 * PI) / 12,
  (7 * PI) / 12,
  (8 * PI) / 12,
  (9 * PI) / 12,
  (10 * PI) / 12,
  (11 * PI) / 12,
  PI,
  (13 * PI) / 12,
  (14 * PI) / 12,
  (15 * PI) / 12,
  (16 * PI) / 12,
  (17 * PI) / 12,
  (18 * PI) / 12,
  (19 * PI) / 12,
  (20 * PI) / 12,
  (21 * PI) / 12,
  (22 * PI) / 12,
  (23 * PI) / 12,
];

int INT(double d) {
  return d.floor();
}

class LVNSolarDate {
  int year = 0, month = 0, day = 0, hour = 0, minute = 0, second = 0;
  int weekday = -1;

  @override
  String toString() {
    return 'year: $year month: $month day: $day hour: $hour minute: $minute second: $second';
  }

  LVNSolarDate(
      [this.year = 0,
      this.month = 0,
      this.day = 0,
      this.hour = 12,
      this.minute = 0,
      this.second = 0]);

  int totalDaysInMonth() {
    var nDay = 31;
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      nDay = 30;
    } else if (month == 2) {
      if (LVNSolarDate.isLeapYear(year)) {
        nDay = 29;
      } else {
        nDay = 28;
      }
    }
    return nDay;
  }

  static today() {
    var date = LVNSolarDate();
    date.setCurrentDate();
    return date;
  }

  void set(int year, int month, int day, int hour, int minute, int second) {
    if (hour < 0) {
      hour = 0;
    } else if (hour > 23) {
      hour = 23;
    }
    if (minute < 0) {
      minute = 0;
    } else if (minute > 59) {
      minute = 59;
    }
    if (second < 0) {
      second = 0;
    } else if (second > 59) {
      second = 59;
    }
    if (month < 1) {
      month = 1;
    } else if (month > 12) {
      month = 12;
    }
    if (day < 1) {
      day = 1;
    }
    if ((month == 1 ||
            month == 3 ||
            month == 5 ||
            month == 7 ||
            month == 8 ||
            month == 10 ||
            month == 12) &&
        day > 31) {
      day = 31;
    } else if ((month == 4 || month == 6 || month == 9 || month == 11) &&
        day > 30) {
      day = 30;
    } else if (month == 2 && LVNSolarDate.isLeapYear(year) && day > 29) {
      day = 29;
    } else if (month == 2 && !LVNSolarDate.isLeapYear(year) && day > 28) {
      day = 28;
    }
    this.year = year;
    this.month = month;
    this.day = day;
    this.hour = hour;
    this.minute = minute;
    this.second = second;
  }

  static bool isLeapYear(year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0 && year % 400 != 0) return false;
    if (year % 4 == 0) return true;
    return false;
  }

  static dateWithDate(solar) {
    return LVNSolarDate(
      solar.year,
      solar.month,
      solar.day,
      solar.hour,
      solar.minute,
      solar.second,
    );
  }

  dateByCopying() {
    return LVNSolarDate(year, month, day, hour, minute, second);
  }

  void setCurrentDate() {
    final today = DateTime.now();
    set(today.year, today.month, today.day, today.hour, today.minute,
        today.second);
  }

  bool isEqualToDate(LVNSolarDate dat) {
    if (year == dat.year &&
        month == dat.month &&
        day == dat.day &&
        hour == dat.hour &&
        minute == dat.minute &&
        second == dat.second) return true;
    return false;
  }

  bool isEqualIgnoreTimeToDate(LVNSolarDate dat) {
    if (year == dat.year && month == dat.month && day == dat.day) return true;
    return false;
  }

  static void AddOneDayTo(LVNSolarDate date) {
    date.day += 1;
    if ((date.month == 1 ||
            date.month == 3 ||
            date.month == 5 ||
            date.month == 7 ||
            date.month == 8 ||
            date.month == 10 ||
            date.month == 12) &&
        date.day > 31) {
      date.day = 1;
      date.month++;
    } else if ((date.month == 4 ||
            date.month == 6 ||
            date.month == 9 ||
            date.month == 11) &&
        date.day > 30) {
      date.day = 1;
      date.month++;
    } else if (date.month == 2 &&
        LVNSolarDate.isLeapYear(date.year) &&
        date.day > 29) {
      date.day = 1;
      date.month++;
    } else if (date.month == 2 &&
        !LVNSolarDate.isLeapYear(date.year) &&
        date.day > 28) {
      date.day = 1;
      date.month++;
    }
    if (date.month > 12) {
      date.month = 1;
      date.year++;
    }
  }

  static void SubOneDayTo(LVNSolarDate date) {
    date.day -= 1;
    if (date.day <= 0) {
      date.month--;
      if (date.month <= 0) {
        date.month = 12;
        date.year--;
      }
      if ((date.month == 1 ||
              date.month == 3 ||
              date.month == 5 ||
              date.month == 7 ||
              date.month == 8 ||
              date.month == 10 ||
              date.month == 12) &&
          date.day <= 0) {
        date.day = 31;
      } else if ((date.month == 4 ||
              date.month == 6 ||
              date.month == 9 ||
              date.month == 11) &&
          date.day <= 0) {
        date.day = 30;
      } else if (date.month == 2 &&
          LVNSolarDate.isLeapYear(date.year) &&
          date.day <= 0) {
        date.day = 29;
      } else if (date.month == 2 &&
          !LVNSolarDate.isLeapYear(date.year) &&
          date.day <= 0) {
        date.day = 28;
      }
    }
  }

  // Friends
  int daysSinceDate(LVNSolarDate cdat2) {
    // const cdat1: LVNSolarDate = this;
    // bool flag = false;
    var tmpDat1 = LVNSolarDate();
    var tmpDat2 = LVNSolarDate();
    int iSign = 1;
    if (isGreaterThanDate(cdat2)) {
      tmpDat1.set(year, month, day, 12, 0, 0);
      tmpDat2.set(cdat2.year, cdat2.month, cdat2.day, 12, 0, 0);
      iSign = 1;
    } else {
      tmpDat2.set(year, month, day, 12, 0, 0);
      tmpDat1.set(cdat2.year, cdat2.month, cdat2.day, 12, 0, 0);
      iSign = -1;
    }
    int count = 0;
    while (!tmpDat1.isEqualToDate(tmpDat2)) {
      tmpDat2.increaseDay();
      count++;
    }
    return count * iSign;
  }

  // Sua de tang toc do tinh toan
  LVNSolarDate addMinutes(int min) {
    var date = LVNSolarDate(year, month, day);
    int tmpHour = hour;
    int tmpMinute = minute;
    int tmpHourNum = 0;
    int tmpDayNum = 0;
    if (min >= 0) {
      tmpDayNum = INT(min / (60 * 24));
      min -= tmpDayNum * (60 * 24);
      tmpHourNum = INT(min / 60);
      min -= tmpHourNum * 60;
      for (int i = 0; i < min; i++) {
        tmpMinute++;
        if (tmpMinute >= 60) {
          tmpMinute = 0;
          tmpHour++;
        }
        if (tmpHour >= 24) {
          tmpHour = 0;
          AddOneDayTo(date);
        }
      }
    } else {
      min = -min;
      tmpDayNum = INT(min / (60 * 24));
      min -= tmpDayNum * (60 * 24);
      tmpHourNum = INT(min / 60);
      min -= tmpHourNum * 60;
      tmpDayNum = -tmpDayNum;
      tmpHourNum = -tmpHourNum;
      for (int i = 0; i < min; i++) {
        tmpMinute--;
        if (tmpMinute < 0) {
          tmpMinute = 59;
          tmpHour--;
        }
        if (tmpHour < 0) {
          tmpHour = 23;
          SubOneDayTo(date);
        }
      }
    }
    var tmpdate = LVNSolarDate(
      date.year,
      date.month,
      date.day,
      tmpHour,
      tmpMinute,
      second,
    );
    tmpdate.addDays(tmpDayNum);
    tmpdate.addHours(tmpHourNum);

    year = tmpdate.year;
    month = tmpdate.month;
    day = tmpdate.day;
    hour = tmpdate.hour;
    minute = tmpdate.minute;
    second = tmpdate.second;
    return this;
  }

  // Sua de tang toc do tinh toan
  LVNSolarDate addHours(int h) {
    LVNSolarDate date = LVNSolarDate(year, month, day);
    int tmpHour = hour;
    int tmpDayNum = 0;
    if (h >= 0) {
      tmpDayNum = INT(h / 24);
      h -= tmpDayNum * 24;
      for (int i = 0; i < h; i++) {
        tmpHour++;
        if (tmpHour >= 24) {
          tmpHour = 0;
          LVNSolarDate.AddOneDayTo(date);
        }
      }
    } else {
      h = -h;
      tmpDayNum = INT(h / 24);
      h -= tmpDayNum * 24;
      tmpDayNum = -tmpDayNum;
      for (int i = 0; i < h; i++) {
        tmpHour--;
        if (tmpHour < 0) {
          tmpHour = 23;
          LVNSolarDate.SubOneDayTo(date);
        }
      }
    }
    LVNSolarDate tmpdate = LVNSolarDate(
      date.year,
      date.month,
      date.day,
      tmpHour,
      minute,
      second,
    );
    tmpdate.addDays(tmpDayNum);

    year = tmpdate.year;
    month = tmpdate.month;
    day = tmpdate.day;
    hour = tmpdate.hour;
    minute = tmpdate.minute;
    second = tmpdate.second;
    return this;
  }

  LVNSolarDate addDays(int d) {
    // const tmpYear = this.year;
    // const tmpMonth = this.month;
    // const tmpDay = this.day;
    LVNSolarDate date = LVNSolarDate(year, month, day);
    if (d >= 0) {
      for (int i = 0; i < d; i++) {
        LVNSolarDate.AddOneDayTo(date);
      }
    } else {
      d = -d;
      for (int i = 0; i < d; i++) {
        LVNSolarDate.SubOneDayTo(date);
      }
    }
    year = date.year;
    month = date.month;
    day = date.day;
    return this;
  }

  LVNSolarDate increaseDay() {
    return addDays(1);
  }

  LVNSolarDate decreaseDay() {
    return subDays(1);
  }

  LVNSolarDate subMinutes(minutes) {
    return addMinutes(-minutes);
  }

  LVNSolarDate subHours(hours) {
    return addHours(-hours);
  }

  LVNSolarDate subDays(days) {
    return addDays(-days);
  }

  static isGreater(LVNSolarDate cdat1, LVNSolarDate cdat2) {
    return cdat1.isGreaterThanDate(cdat2);
  }

  bool isGreaterThanDate(LVNSolarDate cdat2) {
    if (year > cdat2.year ||
        (year == cdat2.year && month > cdat2.month) ||
        (year == cdat2.year && month == cdat2.month && day > cdat2.day) ||
        (year == cdat2.year &&
            month == cdat2.month &&
            day == cdat2.day &&
            hour > cdat2.hour) ||
        (year == cdat2.year &&
            month == cdat2.month &&
            day == cdat2.day &&
            hour == cdat2.hour &&
            minute > cdat2.minute) ||
        (year == cdat2.year &&
            month == cdat2.month &&
            day == cdat2.day &&
            hour == cdat2.hour &&
            minute == cdat2.minute &&
            second > cdat2.second)) return true;
    return false;
  }

  bool isGreaterIgnoreTimeThanDate(cdat2) {
    if (year > cdat2.year ||
        (year == cdat2.year && month > cdat2.month) ||
        (year == cdat2.year && month == cdat2.month && day > cdat2.day))
      return true;
    return false;
  }

  LVNSolarDate increaseMonth() {
    if (month == 1 && day >= 30 && LVNSolarDate.isLeapYear(this.year)) {
      // Thang 1->2 phai kiem soat
      day = 29;
      month = 2;
    } else if (month == 1 && day >= 29 && !LVNSolarDate.isLeapYear(year)) {
      day = 28;
      month = 2;
    } else if (month == 3 && day == 31) {
      day = 30;
      month = 4;
    } else if (month == 5 && day == 31) {
      day = 30;
      month = 6;
    } else if (month == 8 && day == 31) {
      day = 30;
      month = 9;
    } else if (month == 10 && day == 31) {
      day = 30;
      month = 11;
    } else {
      month++;
      if (month > 12) {
        month = 1;
        year++;
      }
    }
    return this;
  }

  LVNSolarDate decreaseMonth() {
    if (month == 3 && day >= 30 && LVNSolarDate.isLeapYear(year)) {
      // Thang 1->2 phai kiem soat
      day = 29;
      month = 2;
    } else if (month == 3 && day >= 29 && !LVNSolarDate.isLeapYear(year)) {
      day = 28;
      month = 1;
    } else if (month == 5 && day == 31) {
      day = 30;
      month = 4;
    } else if (month == 7 && day == 31) {
      day = 30;
      month = 6;
    } else if (month == 10 && day == 31) {
      day = 30;
      month = 9;
    } else if (month == 12 && day == 31) {
      day = 30;
      month = 11;
    } else {
      month--;
      if (month <= 0) {
        month = 12;
        year--;
      }
    }
    return this;
  }

  LVNSolarDate increaseYear() {
    year++;
    // Kiem tra ngay
    if (month == 2 && day >= 29 && !LVNSolarDate.isLeapYear(year)) {
      day = 28;
    }
    return this;
  }

  LVNSolarDate decreaseYear() {
    year--;
    // Kiem tra ngay
    if (month == 2 && day >= 29 && !LVNSolarDate.isLeapYear(year)) {
      day = 28;
    }
    return this;
  }

  get dayInWeek {
    // 1: Monday, ..., 7: Sunday
    const arrMonthNum = [6, 2, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4];
    int tmp = year >= 0 ? year : -year;
    tmp = INT((tmp % 100) + (tmp % 100) / 4);
    tmp += day;
    tmp += arrMonthNum[month - 1];
    if (LVNSolarDate.isLeapYear(year) &&
        (month < 2 || (month == 2 && day < 29))) {
      tmp -= 1;
    }
    int adjustmentFactor = 0;
    int decade = INT(year / 100);
    int i;
    if (decade >= 20) {
      for (i = 20; i < decade; i++) {
        if ((i + 1) % 4 == 0)
          adjustmentFactor -= 1;
        else
          adjustmentFactor -= 2;
      }
    } else {
      for (i = decade; i < 20; i++) {
        if ((i + 1) % 4 == 0)
          adjustmentFactor += 1;
        else
          adjustmentFactor += 2;
      }
    }
    tmp += adjustmentFactor;
    if (tmp > 0) {
      while (tmp > 7) {
        tmp -= 7;
      }
    } else {
      while (tmp < 1) {
        tmp += 7;
      }
    }
    if (month == 2 && day == 29) {
      tmp -= 1;
      if (tmp == 0) {
        tmp = 7;
      }
    }
    return tmp;
  }
}

class LVNLunarDate {
  int year = 0,
      month = 0,
      day = 0,
      monthLeap = 0,
      leap = CONST_NORMAL,
      special = CONST_NORMAL;
  LVNLunarDate(
      [this.year = 0,
      this.month = 0,
      this.day = 0,
      this.leap = CONST_NORMAL,
      this.monthLeap = CONST_NORMAL,
      this.special = CONST_NORMAL]);

  @override
  String toString() {
    return 'year: $year month: $month day: $day leap: $leap';
  }

  static LVNLunarDate dateWithDate(LVNLunarDate solar) {
    return LVNLunarDate(
      solar.year,
      solar.month,
      solar.day,
      solar.leap,
    );
  }

  LVNLunarDate dateByCopying() {
    return LVNLunarDate(year, month, day, leap);
  }

  LVNLunarDate set(int year, int month, int day, [int? leap, int? special]) {
    this.year = year;
    if (month > 12 || month <= 0) {
      this.month = 1;
    } else {
      this.month = month;
    }
    if (day > 30 || day <= 0) {
      this.day = 1;
    } else {
      this.day = day;
    }
    this.special = special ?? this.special;
    this.leap = leap ?? this.leap;
    return this;
  }

  LVNLunarDate setLeap(int leap) {
    this.leap = leap;
    return this;
  }

  static bool isLeapYear(year) {
    // nam am lịch chia cho 19, nếu chia hết hoặc cho các số dư 3, 6, 9, 11, 14, 17
    int sodu = year % 19;
    return (sodu == 0 ||
        sodu == 3 ||
        sodu == 6 ||
        sodu == 9 ||
        sodu == 11 ||
        sodu == 14 ||
        sodu == 17);
  }

  Map getCanChiOfHour(int hour) {
    // Tinh chi gio
    int chi = INT(((hour + 1) % 24) / 2);
    int can = 0;
    // Tinh can gio
    LVNLunarDate cLunarDatTmp = LVNLunarDate(
      this.year,
      month,
      day,
      leap,
    );
    LVNDateConverter dateConvert = LVNDateConverter();
    LVNSolarDate? cDatTmp1 = dateConvert.Lunar2Solar(cLunarDatTmp);
    if (cDatTmp1 != null) {
      can = 0;
      chi = 0;
      return {'can': can, 'chi': chi};
    }
    int year = cDatTmp1!.year;
    int index = INT(year / 400);
    if (index < 0) {
      index = 0;
    }
    if (index > 24) {
      index = 24;
    }
    LVNSolarDate cDatTmp2 = LVNSolarDate(
      200 + 400 * index,
      1,
      1,
      12,
      0,
      0,
    );
    int numday = cDatTmp1.daysSinceDate(cDatTmp2) + KArrNumday[index];
    int tmp = numday;
    if (tmp < 0) {
      int k = INT(-tmp / 10) + 1;
      tmp += 10 * k;
    }
    can = (KCanHour0 + tmp * 2) % 10;
    can = (can + (chi - KChiTys)) % 10;
    return {'can': can, 'chi': chi};
  }

  Map<String, int> getLunarDayCanChi() {
    int can = 0;
    int chi = 0;
    LVNLunarDate cLunarDatTmp = LVNLunarDate(
      this.year,
      month,
      day,
      leap,
    );
    cLunarDatTmp.leap = leap;

    // console.log(this)

    LVNDateConverter dateConvert = LVNDateConverter();
    LVNSolarDate? cDatTmp1 = dateConvert.Lunar2Solar(cLunarDatTmp);
    if (cDatTmp1 != null) {
      can = 0;
      chi = 0;
      return {'can': can, 'chi': chi};
    }
    int year = cDatTmp1!.year;
    int index = INT(year / 400);
    if (index < 0) {
      index = 0;
    }
    if (index > 24) {
      index = 24;
    }
    LVNSolarDate cDatTmp2 = LVNSolarDate(
      200 + 400 * index,
      1,
      1,
      12,
      0,
      0,
    );

    int numday = cDatTmp1.daysSinceDate(cDatTmp2) + KArrNumday[index];
    // Tinh can ngay
    int tmp = numday;
    if (tmp < 0) {
      int k = INT(-tmp / 10) + 1;
      tmp += 10 * k;
    }
    can = (KCanDay0 + tmp) % 10;
    // Tinh chi ngay
    tmp = numday;
    if (tmp < 0) {
      int k = INT(-tmp / 12) + 1;
      tmp += 12 * k;
    }
    chi = (KChiDay0 + tmp) % 12;
    return {'can': can, 'chi': chi};
  }

  Map<String, int> getLunarMonthCanChi() {
    int can = (year * 12 + month + 3) % 10;
    int chi = (month + 1) % 12;
    return {'can': can, 'chi': chi};
  }

  Map<String, int> getLunarYearCanChi() {
    return {
      'can': (year + 6) % 10,
      'chi': (year + 8) % 12,
    };
  }

  int isBadGoodDayWith(int aMonth, int aChi) {
    int ret = 0;
    /*
        let tmpMonth = (aMonth+1)%12;
        let tmp = (aChi + tmpMonth*2)%12;
        if (tmp == KChiThan || tmp == KChiDau || tmp == KChiSuu || tmp == KChiMao)
        ret = 1;
        else if (tmp == KChiHoi || tmp == KChiDan || tmp == KChiTij || tmp == KChiMui)
        ret = -1;
        */
    if (aMonth == 4 || aMonth == 10) {
      // t
      // Ngọ, mùi, sửu, hợi
      // Tý, dậu, tị, mão,
      if (aChi == KChiNgo ||
          aChi == KChiMui ||
          aChi == KChiSuu ||
          aChi == KChiHoi) {
        ret = 1;
      } else if (aChi == KChiTys ||
          aChi == KChiMao ||
          aChi == KChiTij ||
          aChi == KChiDau) {
        ret = -1;
      }
    } else if (aMonth == 1 || aMonth == 7) {
      // Tý, sửu, tị, mùi
      // Ngọ, mão, hợi, dậu
      if (aChi == KChiTys ||
          aChi == KChiMui ||
          aChi == KChiSuu ||
          aChi == KChiTij) {
        ret = 1;
      } else if (aChi == KChiNgo ||
          aChi == KChiMao ||
          aChi == KChiHoi ||
          aChi == KChiDau) {
        ret = -1;
      }
    } else if (aMonth == 2 || aMonth == 8) {
      // Dần, mão, mùi, dậu
      // Thân, tị, sửu, hợi
      if (aChi == KChiDan ||
          aChi == KChiMao ||
          aChi == KChiMui ||
          aChi == KChiDau) {
        ret = 1;
      } else if (aChi == KChiThan ||
          aChi == KChiTij ||
          aChi == KChiHoi ||
          aChi == KChiSuu) {
        ret = -1;
      }
    } else if (aMonth == 3 || aMonth == 9) {
      // Thìn, tị,dậu, hợi
      // Tuất, mùi, sửu, Mao
      if (aChi == KChiThin ||
          aChi == KChiTij ||
          aChi == KChiDau ||
          aChi == KChiHoi) {
        ret = 1;
      } else if (aChi == KChiTuat ||
          aChi == KChiMui ||
          aChi == KChiSuu ||
          aChi == KChiMao) {
        ret = -1;
      }
    } else if (aMonth == 5 || aMonth == 11) {
      // Thân,dậu, sửu, mão
      // Dần, hợi, mùi, tị
      if (aChi == KChiThan ||
          aChi == KChiMao ||
          aChi == KChiDau ||
          aChi == KChiSuu) {
        ret = 1;
      } else if (aChi == KChiDan ||
          aChi == KChiMui ||
          aChi == KChiTij ||
          aChi == KChiHoi) {
        ret = -1;
      }
    } else if (aMonth == 6 || aMonth == 12) {
      // Tuất, hợi, mão, tị
      // Thìn, sửu, dậu, mùi
      if (aChi == KChiTuat ||
          aChi == KChiTij ||
          aChi == KChiMao ||
          aChi == KChiHoi) {
        ret = 1;
      } else if (aChi == KChiThin ||
          aChi == KChiMui ||
          aChi == KChiSuu ||
          aChi == KChiDau) {
        ret = -1;
      }
    }
    return ret;
  }

  /// //////////////// Tra ve so ngay trong thang am
  int totalDaysInMonth() {
    // Kiem tra xem ngay 30 co ton tai hay khong
    LVNLunarDate cLunarDate = LVNLunarDate(
      year,
      month,
      30,
      0,
    );
    cLunarDate.leap = leap;
    LVNDateConverter dateConvert = LVNDateConverter();
    LVNSolarDate? date = dateConvert.Lunar2Solar(cLunarDate);
    if (date != null) {
      LVNLunarDate dateLunarTemp = dateConvert.Solar2Lunar(date);
      if (dateLunarTemp.day == cLunarDate.day &&
          dateLunarTemp.month == cLunarDate.month &&
          dateLunarTemp.year == cLunarDate.year &&
          dateLunarTemp.leap == cLunarDate.leap) {
      } else {
        return 29;
      }
    }
    if (date != null) return 30;
    cLunarDate = dateConvert.Solar2Lunar(date!);
    return cLunarDate.day != 30 ? 29 : 30;
  }

  bool getDaySpecialInMonth() {
    bool bRet = false;
    if (month == 1) {
      if (day == 1 || day == 2 || day == 3) {
        bRet = true;
      }
    } else if (month == 3) {
      if (day == 10) {
        bRet = true;
      }
    } else if (month == 8) {
      if (day == 15) {
        bRet = true;
      }
    }
    return bRet;
  }
}

class LVNDateConverter {
  int GMT = 7;
  var bConvertError = false;
  var arrLunarYear = [
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0],
  ];
  LVNDateConverter();

  get isConvertFailed {
    return bConvertError;
  }

  int ToTInt(double d) {
    return INT(d);
  }

  int MOD(double x, double y) {
    int z = INT(x) - INT(y * INT(x / y));
    if (z == 0) {
      z = INT(y);
    }
    return z;
  }

  double UniversalToJD(int nDate, int nMonth, int nYear) {
    double dJD = 0;
    if (nYear > 1582 ||
        (nYear == 1582 && nMonth > 10) ||
        (nYear == 1582 && nMonth == 10 && nDate > 14)) {
      dJD = 367 * nYear -
          ToTInt((7 * (nYear + ToTInt((nMonth + 9) / 12))) / 4) -
          ToTInt((3 * (ToTInt((nYear + (nMonth - 9) / 7) / 100) + 1)) / 4) +
          ToTInt((275 * nMonth) / 9) +
          nDate +
          1721028.5;
    } else {
      dJD = 367 * nYear -
          ToTInt((7 * (nYear + 5001 + ToTInt((nMonth - 9) / 7))) / 4) +
          ToTInt((275 * nMonth) / 9) +
          nDate +
          1729776.5;
    }
    return dJD;
  }

  LVNSolarDate UniversalFromJD(JD) {
    int A;
    int alpha;
    int mm;
    int yyyy;
    double F = 0;
    int Z = ToTInt(JD + 0.5);
    F = JD + 0.5 - Z;
    if (Z < 2299161) {
      A = Z;
    } else {
      alpha = ToTInt((Z - 1867216.25) / 36524.25);
      A = Z + 1 + alpha - ToTInt(alpha / 4);
    }
    int B = A + 1524;
    int C = ToTInt((B - 122.1) / 365.25);
    int D = ToTInt(365.25 * C);
    int E = ToTInt((B - D) / 30.6001);
    int dd = ToTInt(B - D - ToTInt(30.6001 * E) + F);
    if (E < 14) {
      mm = E - 1;
    } else {
      mm = E - 13;
    }
    if (mm < 3) {
      yyyy = C - 4715;
    } else {
      yyyy = C - 4716;
    }
    LVNSolarDate cDat = LVNSolarDate(
      yyyy,
      mm,
      dd,
      12,
      0,
      0,
    );
    return cDat;
  }

  double NewMoon(k) {
    double T = k / 1236.85; // Time in Julian centuries from 1900 January 0.5
    double T2 = T * T;
    double T3 = T2 * T;
    double dr = PI / 180;
    double Jd1 =
        2415020.75933 + 29.53058868 * k + 0.0001178 * T2 - 0.000000155 * T3;
    Jd1 += 0.00033 *
        sin((166.56 + 132.87 * T - 0.009173 * T2) * dr); // Mean new moon
    double M = 359.2242 +
        29.10535608 * k -
        0.0000333 * T2 -
        0.00000347 * T3; // Sun's mean anomaly
    double Mpr = 306.0253 +
        385.81691806 * k +
        0.0107306 * T2 +
        0.00001236 * T3; // Moon's mean anomaly
    double F = 21.2964 +
        390.67050646 * k -
        0.0016528 * T2 -
        0.00000239 * T3; // Moon's argument of latitude
    double C1 =
        (0.1734 - 0.000393 * T) * sin(M * dr) + 0.0021 * sin(2 * dr * M);
    C1 = C1 - 0.4068 * sin(Mpr * dr) + 0.0161 * sin(dr * 2 * Mpr);
    C1 -= 0.0004 * sin(dr * 3 * Mpr);
    C1 = C1 + 0.0104 * sin(dr * 2 * F) - 0.0051 * sin(dr * (M + Mpr));
    C1 = C1 - 0.0074 * sin(dr * (M - Mpr)) + 0.0004 * sin(dr * (2 * F + M));
    C1 = C1 - 0.0004 * sin(dr * (2 * F - M)) - 0.0006 * sin(dr * (2 * F + Mpr));
    C1 =
        C1 + 0.001 * sin(dr * (2 * F - Mpr)) + 0.0005 * sin(dr * (2 * Mpr + M));
    double deltat;
    if (T < -11) {
      deltat = 0.001 +
          0.000839 * T +
          0.0002261 * T2 -
          0.00000845 * T3 -
          0.000000081 * T * T3;
    } else {
      deltat = -0.000278 + 0.000265 * T + 0.000262 * T2;
    }
    double JdNew = Jd1 + C1 - deltat;
    return JdNew;
  }

  double SunLongitude(double jdn) {
    double T = (jdn - 2451545.0) /
        36525; // Time in Julian centuries from 2000-01-01 12:00:00 GMT
    double T2 = T * T;
    double dr = PI / 180; // degree to radian
    double M = 357.5291 +
        35999.0503 * T -
        0.0001559 * T2 -
        0.00000048 * T * T2; // mean anomaly, degree
    double L0 =
        280.46645 + 36000.76983 * T + 0.0003032 * T2; // mean longitude, degree
    double DL = (1.9146 - 0.004817 * T - 0.000014 * T2) * sin(dr * M);
    DL = DL +
        (0.019993 - 0.000101 * T) * sin(dr * 2 * M) +
        0.00029 * sin(dr * 3 * M);
    double L = L0 + DL; // true longitude, degree
    L *= dr;
    L -= PI * 2 * ToTInt(L / (PI * 2)); // Normalize to (0, 2*PI)
    // Hieu chinh cho L ve 0 den 2*PI
    if (L < 0) {
      while (L < 0) {
        L += 2 * PI;
      }
    } else {
      while (L > 2 * PI) {
        L -= 2 * PI;
      }
    }
    return L;
  }

  int CaculateSpecDay(int SolarD, int SolarM, int SolarY) {
    // static TReal64 SUNLONG_MAJOR[] = {0, PI/12, 2*PI/12, 3*PI/12, 4*PI/12, 5*PI/12, 6*PI/12, 7*PI/12, 8*PI/12, 9*PI/12, 10*PI/12, 11*PI/12, PI, 13*PI/12, 14*PI/12, 15*PI/12, 16*PI/12, 17*PI/12, 18*PI/12, 19*PI/12, 20*PI/12, 21*PI/12, 22*PI/12, 23*PI/12};
    // Truong hop la ngay xuan phan khong phai itnh nua
    if (SolarD == 4 && SolarM == 2) return CONST_LAPXUAN;
    if (SolarD == 3 && SolarM == 2) return CONST_NORMAL;
    double iAngle0 = SunLongitude(LocalToJD(SolarD, SolarM, SolarY));
    LVNSolarDate cDat = LVNSolarDate(
      SolarY,
      SolarM,
      SolarD,
      12,
      0,
      0,
    );
    cDat.increaseDay();
    double iAngle1 = SunLongitude(LocalToJD(cDat.day, cDat.month, cDat.year));
    for (int i = CONST_THANHMINH; i <= CONST_KINHTRAP; i++) {
      if (iAngle0 <= SUNLONG_MAJOR[i - 1] && iAngle1 > SUNLONG_MAJOR[i - 1])
        return i;
    }
    // Xu ly rieng ngay Xuan Phan
    if (iAngle0 > SUNLONG_MAJOR[CONST_KINHTRAP - 1] &&
        iAngle0 <= 2 * PI &&
        iAngle1 > 0 &&
        iAngle1 < SUNLONG_MAJOR[CONST_THANHMINH - 1]) return CONST_XUANPHAN;
    return CONST_NORMAL;
  }

  LVNSolarDate LunarMonth11(int Year) {
    double off = LocalToJD(31, 12, Year) - 2415021.076998695;
    int k = ToTInt(off / 29.530588853);
    double jd = NewMoon(k);
    LVNSolarDate ret = LocalFromJD(jd);
    double sunLong = SunLongitude(LocalToJD(
        ret.day, ret.month, ret.year)); // sun longitude at local midnight
    if (sunLong > (3 * PI) / 2) {
      jd = NewMoon(k - 1);
    }
    return LocalFromJD(jd);
  }

  LVNSolarDate LocalFromJD(JD) {
    return UniversalFromJD(JD + GMT / 24.0);
  }

  double LocalToJD(nDate, nMonth, nYear) {
    return UniversalToJD(nDate, nMonth, nYear) - GMT / 24.0;
  }

  int LunarYear(int Year) {
    int length = 0;
    LVNSolarDate month11A = LunarMonth11(Year - 1);
    double jdMonth11A = LocalToJD(month11A.day, month11A.month, month11A.year);
    int k = ToTInt(0.5 + (jdMonth11A - 2415021.076998695) / 29.530588853);
    LVNSolarDate month11B = LunarMonth11(Year);
    double off =
        LocalToJD(month11B.day, month11B.month, month11B.year) - jdMonth11A;
    bool leap = off > 365.0;
    if (!leap) {
      length = 13;
    } else {
      length = 14;
    }
    arrLunarYear[0][0] = month11A.day;
    arrLunarYear[0][1] = month11A.month;
    arrLunarYear[0][2] = month11A.year;
    arrLunarYear[0][3] = 0;
    arrLunarYear[0][4] = 0;
    arrLunarYear[length - 1][0] = month11B.day;
    arrLunarYear[length - 1][1] = month11B.month;
    arrLunarYear[length - 1][2] = month11B.year;
    arrLunarYear[length - 1][3] = 0;
    arrLunarYear[length - 1][3] = 0;
    int i;
    for (i = 1; i < length - 1; i++) {
      double nm = NewMoon(k + i);
      LVNSolarDate a = LocalFromJD(nm);
      arrLunarYear[i][0] = a.day;
      arrLunarYear[i][1] = a.month;
      arrLunarYear[i][2] = a.year;
      arrLunarYear[i][3] = 0;
      arrLunarYear[i][4] = 0;
    }
    for (i = 0; i < length; i++) {
      arrLunarYear[i][3] = MOD(i + 11, 12);
    }
    if (leap) {
      initLeapYear(length);
    }
    return length;
  }

  void initLeapYear(length) {
    List<double> sunLongitudes = List<double>.filled(14, 0, growable: false);
    int i;
    for (i = 0; i < length; i++) {
      double jdAtMonthBegin =
          LocalToJD(arrLunarYear[i][0], arrLunarYear[i][1], arrLunarYear[i][2]);
      sunLongitudes[i] = SunLongitude(jdAtMonthBegin);
    }
    bool found = false;
    for (i = 0; i < length; i++) {
      if (found) {
        arrLunarYear[i][3] = MOD(i + 10, 12);
        continue;
      }
      double sl1 = sunLongitudes[i];
      double sl2 = sunLongitudes[i + 1];
      bool hasMajorTerm = ToTInt((sl1 / PI) * 6) != ToTInt((sl2 / PI) * 6);
      if (!hasMajorTerm) {
        found = true;
        arrLunarYear[i][4] = 1;
        arrLunarYear[i][3] = MOD(i + 10, 12);
      }
    }
  }

  int monthLeap(int year) {
    for (int i = 1; i < 13; i++) {
      LVNLunarDate lunarDate = Solar2Lunar(LVNSolarDate(year, i, 1));
      if (lunarDate.leap == 1 && lunarDate.year == year) {
        return lunarDate.month;
      }
    }
    return 0;
  }

  /// //////////////////////////////////////////////////////////////////////////////
  /// ///////// Chuyen doi ngay duong ra ngay am /////////////////
  /// /////////////////////////////////////////////////////////////////////////////
  LVNLunarDate Solar2Lunar(LVNSolarDate cDate) {
    // Hieu chinh lai GMT
    if (cDate.year >= 1968) {
      GMT = 7;
    } else {
      GMT = 8;
    }
    // Chuyen doi
    int D = cDate.day;
    int M = cDate.month;
    int Y = cDate.year;
    int yy = Y;
    // let length = 0;
    int length = 0;
    length = LunarYear(
        Y); // Please cache the result of this computation for later use!!!
    double jdToday = LocalToJD(D, M, Y);
    double jdMonth11 = LocalToJD(arrLunarYear[length - 1][0],
        arrLunarYear[length - 1][1], arrLunarYear[length - 1][2]);
    if (jdToday >= jdMonth11) {
      length = LunarYear(Y + 1);
      yy = Y + 1;
    }
    int i = length - 1;
    while (jdToday <
        LocalToJD(arrLunarYear[i][0], arrLunarYear[i][1], arrLunarYear[i][2])) {
      i--;
    }
    int dd = ToTInt(jdToday -
            LocalToJD(
                arrLunarYear[i][0], arrLunarYear[i][1], arrLunarYear[i][2])) +
        1;
    int mm = arrLunarYear[i][3];
    if (mm >= 11) {
      yy--;
    }
    LVNLunarDate cLunarDate = LVNLunarDate(
      yy,
      mm,
      dd,
      0,
    );
    cLunarDate.leap = arrLunarYear[i][4];
    cLunarDate.special = CaculateSpecDay(D, M, Y);
    // Set thang nhuan
    if (length == 14) {
      int tmpMonth = -1;
      for (int i = 0; i < length; i++) {
        if (tmpMonth == arrLunarYear[i][3]) {
          cLunarDate.monthLeap = tmpMonth;
          break;
        } else {
          tmpMonth = arrLunarYear[i][3];
        }
      }
    } else {
      cLunarDate.monthLeap = -1;
    }
    return cLunarDate;
  }

  LVNSolarDate? Lunar2Solar(LVNLunarDate cDat) {
    bConvertError = false;
    // Hieu chinh lai GMT
    if (cDat.year >= 1968 || (cDat.year == 1967 && cDat.month == 12)) {
      GMT = 7;
    } else {
      GMT = 8;
    }
    // Chuyen doi
    int D = cDat.day;
    int M = cDat.month;
    int Y = cDat.year;
    int leap = cDat.leap;
    int yy = Y;
    if (M >= 11) {
      yy = Y + 1;
    }
    int length = 0;
    length = LunarYear(yy);
    List<int> lunarMonth = List.filled(5, 0);
    bool isOk = false;
    for (int i = 0; i < length; i++) {
      if (arrLunarYear[i][3] == M && arrLunarYear[i][4] == leap) {
        for (int j = 0; j < 5; j++) {
          lunarMonth[j] = arrLunarYear[i][j];
        }
        isOk = true;
        break;
      }
    }
    if (/* lunarMonth != NULL */ isOk) {
      //        if(D != lunarMonth[0])
      //            _bConvertError = true;
      double jd = LocalToJD(lunarMonth[0], lunarMonth[1], lunarMonth[2]);
      LVNSolarDate temp = LocalFromJD(jd + D - 1);
      return LVNSolarDate(
        temp.year,
        temp.month,
        temp.day,
        12,
        0,
        0,
      );
    }
    bConvertError = true;
    return null;
  }

  static final sharedConverter = LVNDateConverter();

  static String convertDateTimeAndTypeLich(DateTime dateTime, bool isLunar) {
    if (isLunar) {
      LVNLunarDate lunarDate = LVNDateConverter().Solar2Lunar(LVNSolarDate(
          dateTime.year,
          dateTime.month,
          dateTime.day,
          dateTime.hour,
          dateTime.minute));
      return '${formatInt(dateTime.hour)}:${formatInt(dateTime.minute)} - ${formatInt(lunarDate.day)}/${formatInt(lunarDate.month)}/${lunarDate.year} (Âm Lịch)';
    }
    return '${DateFormat('HH:mm - dd/MM/yyyy').format(dateTime)}  (Dương Lịch)';
  }

  static String formatInt(int input) {
    return input < 10 ? '0$input' : input.toString();
  }
}
