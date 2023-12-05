import 'package:lichviet_flutter_base/core/constants/icon_base_constants.dart';
import 'package:lichviet_flutter_base/core/constants/image_base_constants.dart';
import 'package:lichviet_flutter_base/data/model/city_model.dart';

class ArrayBaseConstants {
  Map<int, List<String>> getZodiacHour() {
    var canChiGio = {
      0: [
        "Giáp Tý",
        "Ất Sửu",
        "Bính Dần",
        "Đinh Mão",
        "Mậu Thìn",
        "Kỷ Tị",
        "Canh Ngọ",
        "Tân Mùi",
        "Nhâm Thân",
        "Quý Dậu",
        "Giáp Tuất",
        "Ất Hợi"
      ],
      5: [
        "Giáp Tý",
        "Ất Sửu",
        "Bính Dần",
        "Đinh Mão",
        "Mậu Thìn",
        "Kỷ Tị",
        "Canh Ngọ",
        "Tân Mùi",
        "Nhâm Thân",
        "Quý Dậu",
        "Giáp Tuất",
        "Ất Hợi"
      ],
      1: [
        "Bính Tý",
        "Đinh Sửu",
        "Mậu Dần",
        "Kỷ Mão",
        "Canh Thìn",
        "Tân Tị",
        "Nhâm Ngọ",
        "Quý Mùi",
        "Giáp Thân",
        "Ất Dậu",
        "Bính Tuất",
        "Đinh Hợi"
      ],
      6: [
        "Bính Tý",
        "Đinh Sửu",
        "Mậu Dần",
        "Kỷ Mão",
        "Canh Thìn",
        "Tân Tị",
        "Nhâm Ngọ",
        "Quý Mùi",
        "Giáp Thân",
        "Ất Dậu",
        "Bính Tuất",
        "Đinh Hợi"
      ],
      2: [
        "Mậu Tý",
        "Kỷ Sửu",
        "Canh Dần",
        "Tân Mão",
        "Nhâm Thìn",
        "Quý Tị",
        "Giáp Ngọ",
        "Ất Mùi",
        "Bính Thân",
        "Đinh Dậu",
        "Mậu Tuất",
        "Kỷ Hợi"
      ],
      7: [
        "Mậu Tý",
        "Kỷ Sửu",
        "Canh Dần",
        "Tân Mão",
        "Nhâm Thìn",
        "Quý Tị",
        "Giáp Ngọ",
        "Ất Mùi",
        "Bính Thân",
        "Đinh Dậu",
        "Mậu Tuất",
        "Kỷ Hợi"
      ],
      3: [
        "Canh Tý",
        "Tân Sửu",
        "Nhâm Dần",
        "Quý Mão",
        "Giáp Thìn",
        "Ất Tị",
        "Bính Ngọ",
        "Đinh Mùi",
        "Mậu Thân",
        "Kỷ Dậu",
        "Canh Tuất",
        "Tân Hợi"
      ],
      8: [
        "Canh Tý",
        "Tân Sửu",
        "Nhâm Dần",
        "Quý Mão",
        "Giáp Thìn",
        "Ất Tị",
        "Bính Ngọ",
        "Đinh Mùi",
        "Mậu Thân",
        "Kỷ Dậu",
        "Canh Tuất",
        "Tân Hợi"
      ],
      4: [
        "Nhâm Tý",
        "Quý Sửu",
        "Giáp Dần",
        "Ất Mão",
        "Bính Thìn",
        "Đinh Tị",
        "Mậu Ngọ",
        "Kỷ Mùi",
        "Canh Thân",
        "Tân Dậu",
        "Nhâm Tuất",
        "Quý Hợi"
      ],
      9: [
        "Nhâm Tý",
        "Quý Sửu",
        "Giáp Dần",
        "Ất Mão",
        "Bính Thìn",
        "Đinh Tị",
        "Mậu Ngọ",
        "Kỷ Mùi",
        "Canh Thân",
        "Tân Dậu",
        "Nhâm Tuất",
        "Quý Hợi"
      ],
    };
    return canChiGio;
  }

  int formatZodiacToHour(int time) {
    switch (time) {
      case 23:
      case 0:
        return 0;
      case 1:
      case 2:
        return 1;

      case 3:
      case 4:
        return 2;

      case 5:
      case 6:
        return 3;

      case 7:
      case 8:
        return 4;

      case 9:
      case 10:
        return 5;

      case 11:
      case 12:
        return 6;

      case 13:
      case 14:
        return 7;

      case 15:
      case 16:
        return 8;
      case 17:
      case 18:
        return 9;

      case 19:
      case 20:
        return 10;

      case 21:
      case 22:
      default:
        return 11;
    }
  }

  Map<int, List<String>> colorTheoNgayTietKhi = {
    22: [
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#4b904b"
    ],
    23: ["#4b904b"],
    24: ["#4b904b"],
    1: ["#4b904b"],
    2: [
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#cfa92b"
    ],
    3: ["#cfa92b"],
    4: [
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#d14b5b"
    ],
    5: ["#d14b5b"],
    6: ["#d14b5b"],
    7: ["#d14b5b"],
    8: [
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#cfa92b"
    ],
    9: ["#cfa92b"],
    10: [
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#949494"
    ],
    11: ["#949494"],
    12: ["#949494"],
    13: ["#949494"],
    14: [
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#949494",
      "#d14b5b",
      "#d14b5b",
      "#d14b5b",
      "#cfa92b"
    ],
    15: ["#cfa92b"],
    16: [
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#cfa92b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4b904b",
      "#4978b0"
    ],
    17: ["#4978b0"],
    18: ["#4978b0"],
    19: ["#4978b0"],
    20: [
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#4978b0",
      "#949494",
      "#949494",
      "#949494",
      "#cfa92b"
    ],
    21: ["#cfa92b"]
  };

  static const conGiap = [
    'Tý',
    'Sửu',
    'Dần',
    'Mão',
    'Thìn',
    'Tị',
    'Ngọ',
    'Mùi',
    'Thân',
    'Dậu',
    'Tuất',
    'Hợi'
  ];

  static const gioSinh = [
    'Tý (23h - 1h)',
    'Sửu (1h - 3h)',
    'Dần (3h - 5h)',
    'Mão (5h - 7h)',
    'Thìn (7h - 9h)',
    'Tị (9h - 11h)',
    'Ngọ (11h - 13h)',
    'Mùi (13h - 15h)',
    'Thân (15h - 17h)',
    'Dậu (17h - 19h)',
    'Tuất (19h - 21h)',
    'Hợi (21h - 23h)'
  ];

  static const gio = [
    '23h - 1h',
    '1h - 3h',
    '3h - 5h',
    '5h - 7h',
    '7h - 9h',
    '9h - 11h',
    '11h - 13h',
    '13h - 15h',
    '15h - 17h',
    '17h - 19h',
    '19h - 21h',
    '21h - 23h'
  ];

  static const can = [
    "Giáp",
    "Ất",
    "Bính",
    "Đinh",
    "Mậu",
    "Kỷ",
    "Canh",
    "Tân",
    "Nhâm",
    "Quý"
  ];
  static const chi = [
    "Tý",
    "Sửu",
    "Dần",
    "Mão",
    "Thìn",
    "Tỵ",
    "Ngọ",
    "Mùi",
    "Thân",
    "Dậu",
    "Tuất",
    "Hợi"
  ];

  static const iconKhamPha = [
    IconBaseConstants.icKhamPhaNnnx,
    IconBaseConstants.icKhamPhaDanhNgon,
    IconBaseConstants.icKhamPhaVideo,
    IconBaseConstants.icKhamPhaLeHoi,
    IconBaseConstants.icKhamPhaPhongTuc,
    IconBaseConstants.icKhamPhaHatRu,
    IconBaseConstants.icKhamPhaDongDao,
    IconBaseConstants.icKhamPhaGuiThiep,
    IconBaseConstants.icKhamPhaDemXuoiNguoc,
    IconBaseConstants.icKhamPhaTruyenTieuLam,
    IconBaseConstants.icKhamPhaTroChoi,
    IconBaseConstants.icKhamPhaCtbcb,
    IconBaseConstants.icKhamPhaGocThuGian,
    IconBaseConstants.icKhamPhaPhongSuAnh,
    IconBaseConstants.icKhamPhaBvtch
  ];

  static const titleKhamPha = [
    "Ngày Này \nNăm Xưa",
    "Danh Ngôn",
    "Video Hay",
    "Lễ Hội",
    "Phong Tục",
    "Hát Ru",
    "Đồng Dao",
    "Gửi Thiệp",
    "Đếm \nXuôi Ngược",
    "Truyện \nTiếu Lâm",
    "Trò Chơi",
    "Có Thể Bạn \nChưa Biết?",
    "Góc \nThư Giãn",
    "Phóng Sự \nẢnh",
    "Bài Viết Truyền \nCảm Hứng"
  ];

  static const listLinkKhamPha = [
    "today_in_history",
    "kham_pha:danh_ngon",
    "video_cam_hung",
    "kham_pha:le_hoi",
    "kham_pha:phong_tuc",
    "kham_pha:hat_ru",
    "kham_pha:dong_dao",
    "kham_pha:thiep_mung",
    "kham_pha:dem_nguoc_xuoi",
    "kham_pha:truyen_cuoi",
    "kham_pha:tro_choi",
    "home:fun_fact",
    "kham_pha:goc_thu_gian",
    "phong_su_anh",
    "home:feature_article"
  ];

  static List iconTuViPhongThuyPro = [
    IconBaseConstants.icXemNgayTot1_0,
    IconBaseConstants.icTVPTXemTuVi,
    IconBaseConstants.icTVPTTuVi2023,
    IconBaseConstants.icTuvihangngay,
    IconBaseConstants.icTuvitrondoi,
    // IconConstants.icLichNgocHap,
    IconBaseConstants.icNhipsinhhoc,
    IconBaseConstants.icCunghoangdao,
    IconBaseConstants.icBoiTinhDuyen,
    IconBaseConstants.icThuocloban,
    IconBaseConstants.icLaban,
    IconBaseConstants.icXemsao,
    IconBaseConstants.icVankhan,
    IconBaseConstants.icDoingay,
    IconBaseConstants.icGiaimong,
  ];

  static const titleTuviPhongThuyPro = [
    "Xem Ngày \nTốt 1.0",
    "Xem \nTử Vi",
    "Tử Vi \n2023",
    "Tử vi \nHàng Ngày",
    "Tử vi \nTrọn Đời",
    // "Lịch \nNgọc Hạp",
    "Nhịp \nSinh Học",
    "12 Cung \nHoàng Đạo",
    "Bói \nTình Duyên",
    "Thước \nLỗ Ban",
    "La Bàn",
    "Xem Sao",
    "Văn Khấn",
    "Đổi Ngày",
    "Giải Mộng",
  ];

  static const listLinkTuViPhongThuyPro = [
    "xem_ngay_tot_1",
    "la_so_tu_vi",
    "kham_pha:tu_vi",
    "kham_pha:tu_vi&tuvi_cate_id=tuvi_hangngay",
    "kham_pha:tu_vi&tuvi_cate_id=tuvi_trondoi",
    // "lich_ngoc_hap",
    "kham_pha:nhip_sinh_hoc",
    "kham_pha:cung_hoang_dao",
    "kham_pha:tu_vi&tuvi_cate_id=tinh_duyen",
    "kham_pha:thuoc_lo_ban",
    "kham_pha:la_ban",
    "kham_pha:tu_vi&tuvi_cate_id=xem_sao",
    "tu_vi:van_khan",
    "doi_ngay",
    "kham_pha:tu_vi&tuvi_cate_id=giai_mong",
  ];

  static const imgPro = [
    ImageBaseConstants.imgXemNgayTot,
    ImageBaseConstants.imgPhongThuy,
    ImageBaseConstants.imgXemTuVi,
    ImageBaseConstants.imgLucHao,
  ];

  static const imgDanhNgonBg = [
    ImageBaseConstants.imgDanhNgonBg1,
    ImageBaseConstants.imgDanhNgonBg2,
    ImageBaseConstants.imgDanhNgonBg3,
    ImageBaseConstants.imgDanhNgonBg4,
    ImageBaseConstants.imgDanhNgonBg5,
    ImageBaseConstants.imgDanhNgonBg6,
    ImageBaseConstants.imgDanhNgonBg7,
    ImageBaseConstants.imgDanhNgonBg8,
    ImageBaseConstants.imgDanhNgonBg9,
    ImageBaseConstants.imgDanhNgonBg10,
    ImageBaseConstants.imgDanhNgonBg11,
    ImageBaseConstants.imgDanhNgonBg12,
  ];

  static const nameMark = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'X',
    'Y',
    'Z',
    'W',
  ];

  String converDateToStringVietNam(DateTime dateTime) {
    String date = '';
    switch (dateTime.weekday) {
      case DateTime.monday:
        date = "T.HAI";
        break;

      case DateTime.tuesday:
        date = "T.BA";
        break;
      case DateTime.wednesday:
        date = "T.TƯ";
        break;
      case DateTime.thursday:
        date = "T.NĂM";
        break;
      case DateTime.friday:
        date = "T.SÁU";
        break;
      case DateTime.saturday:
        date = "T.BẢY";
        break;
      case DateTime.sunday:
        date = "CHỦ NHẬT";
        break;
    }

    return date;
  }

  String converDateToStringVietNam2(DateTime dateTime) {
    String date = '';
    switch (dateTime.weekday) {
      case DateTime.monday:
        date = "T.HAI";
        break;

      case DateTime.tuesday:
        date = "T.BA";
        break;
      case DateTime.wednesday:
        date = "T.TƯ";
        break;
      case DateTime.thursday:
        date = "T.NĂM";
        break;
      case DateTime.friday:
        date = "T.SÁU";
        break;
      case DateTime.saturday:
        date = "T.BẢY";
        break;
      case DateTime.sunday:
        date = "CN";
        break;
    }

    return date;
  }

  List<CityModel> getCityName() {
    List<CityModel> listCityName = [];
    listCityName.add(CityModel(id: -1, name: 'Tự động', cityName: 'Auto'));
    listCityName
        .add(CityModel(id: 0, name: 'Hồ Chí Minh', cityName: 'Ho Chi Minh'));
    listCityName.add(CityModel(id: 1, name: "Hà Nội", cityName: "Hanoi"));
    listCityName.add(CityModel(id: 2, name: "Đà Nẵng", cityName: "Da Nang"));
    listCityName.add(CityModel(id: 3, name: "Hải Phòng", cityName: "Haiphong"));
    listCityName
        .add(CityModel(id: 4, name: "An Giang", cityName: "An Giang Province"));
    listCityName.add(CityModel(
        id: 5, name: "Bà Rịa Vũng Tàu", cityName: "Ba Ria - Vung Tau"));
    listCityName
        .add(CityModel(id: 6, name: "Bắc Giang", cityName: "Bac Giang"));
    listCityName
        .add(CityModel(id: 7, name: "Bắc Kạn", cityName: "Bắc Kạn Province"));
    listCityName.add(CityModel(id: 8, name: "Bạc Liêu", cityName: "Bac Lieu"));

    listCityName
        .add(CityModel(id: 9, name: "Bắc Ninh", cityName: "Bac Ninh Province"));
    listCityName.add(CityModel(id: 10, name: "Bến Tre", cityName: "Ben Tre"));
    listCityName
        .add(CityModel(id: 11, name: "Bình Dương", cityName: "Binh Duong"));
    listCityName
        .add(CityModel(id: 12, name: "Bình Phước", cityName: "Binh Phuoc"));
    listCityName
        .add(CityModel(id: 13, name: "Bình Thuận", cityName: "Binh Thuan"));
    listCityName
        .add(CityModel(id: 14, name: "Bình Định", cityName: "Bình Định"));
    listCityName.add(CityModel(id: 15, name: "Cà Mau", cityName: "Ca Mau"));
    listCityName.add(CityModel(id: 16, name: "Cần Thơ", cityName: "Can Tho"));
    listCityName.add(CityModel(id: 17, name: "Cao Bằng", cityName: "Cao Bang"));
    listCityName
        .add(CityModel(id: 18, name: "Gia Lai", cityName: "Gia Lai Province"));

    listCityName.add(CityModel(id: 19, name: "Hà Giang", cityName: "Ha Giang"));
    listCityName
        .add(CityModel(id: 20, name: "Hà Nam", cityName: "Hà Nam Province"));
    listCityName
        .add(CityModel(id: 21, name: "Hà Tĩnh", cityName: "Ha Tinh Province"));
    listCityName
        .add(CityModel(id: 22, name: "Hải Dương", cityName: "Hai Duong"));
    listCityName
        .add(CityModel(id: 23, name: "Hậu Giang", cityName: "Hau Giang"));
    listCityName.add(CityModel(id: 24, name: "Hoà Bình", cityName: "Hoa Binh"));
    listCityName
        .add(CityModel(id: 25, name: "Huế", cityName: "Thua Thien Hue"));
    listCityName.add(
        CityModel(id: 26, name: "Hưng Yên", cityName: "Hung Yen Province"));
    listCityName.add(
        CityModel(id: 27, name: "Khánh Hoà", cityName: "Khanh Hoa Province"));
    listCityName
        .add(CityModel(id: 28, name: "Kiên Giang", cityName: "Kien Giang"));
    listCityName
        .add(CityModel(id: 29, name: "Kon Tum", cityName: "Kon Tum Province"));
    listCityName.add(CityModel(id: 30, name: "Lai Châu", cityName: "Lai Chau"));

    listCityName.add(CityModel(id: 31, name: "Lâm Đồng", cityName: "Lâm Đồng"));
    listCityName.add(
        CityModel(id: 32, name: "Lạng Sơn", cityName: "Lang Son Province"));
    listCityName.add(CityModel(id: 33, name: "Lào Cai", cityName: "Lao Cai"));
    listCityName
        .add(CityModel(id: 34, name: "Long An", cityName: "Long An Province"));
    listCityName.add(CityModel(id: 35, name: "Nam Định", cityName: "Nam Dinh"));
    listCityName.add(CityModel(id: 36, name: "Nghệ An", cityName: "Nghe An"));
    listCityName.add(
        CityModel(id: 37, name: "Ninh Bình", cityName: "Ninh Bình Province"));
    listCityName.add(
        CityModel(id: 38, name: "Ninh Thuận", cityName: "Ninh Thuan Province"));
    listCityName
        .add(CityModel(id: 39, name: "Phú Thọ", cityName: "Phu Tho Province"));
    listCityName
        .add(CityModel(id: 40, name: "Phú Yên", cityName: "Phú Yên Province"));

    listCityName.add(
        CityModel(id: 41, name: "Quảng Bình", cityName: "Quang Binh Province"));
    listCityName.add(
        CityModel(id: 42, name: "Quảng Nam", cityName: "Quang Nam Province"));
    listCityName
        .add(CityModel(id: 43, name: "Quảng Ngãi", cityName: "Quang Ngai"));
    listCityName.add(
        CityModel(id: 44, name: "Quảng Ninh", cityName: "Quảng Ninh Province"));
    listCityName.add(
        CityModel(id: 45, name: "Quảng Trị", cityName: "Quảng Trị Province"));
    listCityName
        .add(CityModel(id: 46, name: "Sóc Trăng", cityName: "Soc Trang"));
    listCityName.add(CityModel(id: 47, name: "Sơn La", cityName: "Son La"));
    listCityName.add(
        CityModel(id: 48, name: "Tây Ninh", cityName: "Tây Ninh Province"));
    listCityName
        .add(CityModel(id: 49, name: "Thái Bình", cityName: "Thai Binh"));
    listCityName
        .add(CityModel(id: 50, name: "Thái Nguyên", cityName: "Thai Nguyen"));

    listCityName
        .add(CityModel(id: 51, name: "Thanh Hoá", cityName: "Thanh Hoa"));
    listCityName
        .add(CityModel(id: 52, name: "Tiền Giang", cityName: "Tien Giang"));
    listCityName.add(CityModel(id: 53, name: "Trà Vinh", cityName: "Tra Vinh"));
    listCityName.add(CityModel(
        id: 54, name: "Tuyên Quang", cityName: "Tuyên Quang Province"));
    listCityName
        .add(CityModel(id: 55, name: "Vĩnh Long", cityName: "Vinh Long"));
    listCityName.add(
        CityModel(id: 56, name: "Vĩnh Phúc", cityName: "Vinh Phuc Province"));
    listCityName
        .add(CityModel(id: 57, name: "Yên Bái", cityName: "Yen Bai Province"));
    listCityName
        .add(CityModel(id: 58, name: "Đắk Lắk", cityName: "Đắk Lắk Province"));
    listCityName.add(CityModel(id: 59, name: "Đắk Nông", cityName: "Dak Nong"));
    listCityName.add(CityModel(id: 60, name: "Đồng Nai", cityName: "Dong Nai"));

    listCityName.add(
        CityModel(id: 61, name: "Đồng Tháp", cityName: "Đồng Tháp Province"));
    listCityName
        .add(CityModel(id: 62, name: "Điện Biên", cityName: "Dien Bien"));

    return listCityName;
  }
}
