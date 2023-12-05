import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';

class IconUtils {
  static String getIconPath(String typeId) {
    switch (typeId) {
      // viec Hy
      case '0':
        return IconBaseConstants.icViecHy;
      //ngay gio
      case '1':
        return IconBaseConstants.icNgayGio;
      //ca nhan
      case '2':
        return IconBaseConstants.icCaNhan;
      // gia dinh
      case '3':
        return IconBaseConstants.icGiaDinh;
      // cong viec
      case '4':
        return IconBaseConstants.icCongViec;
      // sinh nhat
      case '5':
        return IconBaseConstants.icSinhNhat;
      // he thong
      case '6':
        return IconBaseConstants.icKhac;
      // khac
      case '7':
        return IconBaseConstants.icKhac;
      // cuoc doi
      case '8':
        return IconBaseConstants.icKhac;
      // ki uc
      case '9':
        return IconBaseConstants.icKhac;
      // ki niem
      case '10':
        return IconBaseConstants.icKyNiem;
      // ngay le
      case '11':
        return IconBaseConstants.icKhac;
      // ngay le
      case '12':
        return IconBaseConstants.icKhac;
      // sinh nhat cua nguoi dung de ban notify
      case '13':
        return IconBaseConstants.icSinhNhat;
      // ram, mung 1
      case '14':
        return IconBaseConstants.icKhac;
      // dem xuoi dem nguoc
      case '15':
        return IconBaseConstants.icKhac;
      // nhip sinh hoc
      case '16':
        return IconBaseConstants.icKhac;
      // google calendar
      case '17':
        return IconBaseConstants.icKhac;
      // facebook calendar
      case '18':
        return IconBaseConstants.icKhac;
      // film calendar
      case '27':
        return IconBaseConstants.icLichPhim;
      // ngay nay nam xua
      case '24':
        return IconBaseConstants.icKhac;
      // ...
      case '25':
        return IconBaseConstants.icKhac;
      // ...
      case '26':
        return IconBaseConstants.icKhac;
      // hen ho
      case '543':
        return IconBaseConstants.icHenHo;
      // ky niem
      case '568':
        return IconBaseConstants.icKyNiem;
      // quang cao
      case '569':
        return IconBaseConstants.icEventAds;
      // sinh nhat ban be tren fb
      case '8888':
        return IconBaseConstants.icKhac;
      // nhip sinh hoc cua toi
      case '9999':
        return IconBaseConstants.icKhac;
      default:
        return IconBaseConstants.icKhac;
    }
  }

  static String getIconPathOnDetailScreen(String typeId) {
    switch (typeId) {
      // viec Hy
      case '0':
        return IconBaseConstants.icViecHy;
      //ngay gio
      case '1':
        return IconBaseConstants.icNgayGio;
      //ca nhan
      case '2':
        return IconBaseConstants.icCaNhan;
      // gia dinh
      case '3':
        return IconBaseConstants.icGiaDinh;
      // cong viec
      case '4':
        return IconBaseConstants.icCongViec;
      // sinh nhat
      case '5':
        return IconBaseConstants.icSinhNhat;
      // he thong
      case '6':
        return IconBaseConstants.icNgayLeItem;
      // khac
      case '7':
        return IconBaseConstants.icKhac;
      // cuoc doi
      case '8':
        return IconBaseConstants.icKhac;
      // ki uc
      case '9':
        return IconBaseConstants.icKhac;
      // ki niem
      case '10':
        return IconBaseConstants.icKyNiem;
      // ngay le
      case '11':
        return IconBaseConstants.icNgayLeItem;
      // ngay le
      case '12':
        return IconBaseConstants.icNgayLeItem;
      // sinh nhat cua nguoi dung de ban notify
      case '13':
        return IconBaseConstants.icSinhNhat;
      // ram, mung 1
      case '14':
        return IconBaseConstants.icNgayLeItem;
      // dem xuoi dem nguoc
      case '15':
        return IconBaseConstants.icKhac;
      // nhip sinh hoc
      case '16':
        return IconBaseConstants.icKhac;
      // google calendar
      case '17':
        return IconBaseConstants.icKhac;
      // facebook calendar
      case '18':
        return IconBaseConstants.icKhac;
      // film calendar
      case '27':
        return IconBaseConstants.icLichPhim;
      // ngay nay nam xua
      case '24':
        return IconBaseConstants.icKhac;
      // ...
      case '25':
        return IconBaseConstants.icKhac;
      // ...
      case '26':
        return IconBaseConstants.icKhac;
      // hen ho
      case '543':
        return IconBaseConstants.icHenHo;
      // ky niem
      case '568':
        return IconBaseConstants.icKyNiem;
      // quang cao
      case '569':
        return IconBaseConstants.icEventAds;
      // sinh nhat ban be tren fb
      case '8888':
        return IconBaseConstants.icFacebook;
      // nhip sinh hoc cua toi
      case '9999':
        return IconBaseConstants.icKhac;
      default:
        return IconBaseConstants.icKhac;
    }
  }

  static String getUrlIcon12ConGiap(int index) {
    switch (index) {
      case 0:
        return IconBaseConstants.icTy;
      case 1:
        return IconBaseConstants.icSuu;
      case 2:
        return IconBaseConstants.icDan;
      case 3:
        return IconBaseConstants.icMao;
      case 4:
        return IconBaseConstants.icThin;
      case 5:
        return IconBaseConstants.icTi;
      case 6:
        return IconBaseConstants.icNgo;
      case 7:
        return IconBaseConstants.icMui;
      case 8:
        return IconBaseConstants.icThan;
      case 9:
        return IconBaseConstants.icDau;
      case 10:
        return IconBaseConstants.icTuat;
      case 11:
        return IconBaseConstants.icHoi;
      default:
        return IconBaseConstants.icTy;
    }
  }

  static String getUrlIcon12ConGiapFromText(String text) {
    if (text.contains('Tý')) {
      return IconBaseConstants.icTy; 
    }
    if (text.contains('Sửu')) {
      return IconBaseConstants.icSuu; 
    }
    if (text.contains('Dần')) {
      return IconBaseConstants.icDan; 
    }
    if (text.contains('Mão')) {
      return IconBaseConstants.icMao; 
    }
    if (text.contains('Thìn')) {
      return IconBaseConstants.icThin; 
    }
    if (text.contains('Tị')) {
      return IconBaseConstants.icTi; 
    }
    if (text.contains('Ngọ')) {
      return IconBaseConstants.icNgo; 
    }
    if (text.contains('Mùi')) {
      return IconBaseConstants.icMui; 
    }
    if (text.contains('Thân')) {
      return IconBaseConstants.icThan; 
    }
    if (text.contains('Dậu')) {
      return IconBaseConstants.icDau; 
    }
    if (text.contains('Tuất')) {
      return IconBaseConstants.icTuat; 
    }
    if (text.contains('Hợi')) {
      return IconBaseConstants.icHoi; 
    }
    return IconBaseConstants.icTy;
  }
}
