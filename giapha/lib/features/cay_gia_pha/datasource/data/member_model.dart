import 'package:equatable/equatable.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/shared/utils/string_extension.dart';
// import 'package:lichviet_flutter_base/core/core.dart';
import '../../../../core/clone/graph/GraphView.dart';

class UserInfo extends Equatable {
  String? idTamThoi;

  int? depth;
  String? memberId; // id của node
  String? userId;
  String? giaPhaId;
  String? mid; // id của mẹ
  String? fid; // id của cha
  String? trangThai;
  String? ten;
  String? avatar;
  String? tenKhac;
  String? gioiTinh;
  String? ngaySinh;

  String? soDienThoai;
  String? email;
  // String? nguyenQuan;
  String? diaChiHienTai;
  String? trangThaiMat;
  String? tieuSu;
  String? ngayMat;
  String? ngheNghiep;

  String? thoiGianTao;

  String? pid; // id cua thanh vien truc he
  String? cid; // id cua con
  int? root;
  int? trangThaiNode; // 0: create, 1: delete, 2: update
  int? soCon;
  int? soVoChong;
  bool isMerge = false;

  UserInfo({
    this.idTamThoi,
    this.depth,
    this.memberId,
    this.userId,
    this.giaPhaId,
    this.mid,
    this.fid,
    this.trangThai,
    this.ten,
    this.avatar,
    this.tenKhac,
    this.gioiTinh,
    this.ngaySinh,
    this.soDienThoai,
    this.email,
    // this.nguyenQuan,
    this.diaChiHienTai,
    this.trangThaiMat,
    this.tieuSu,
    this.ngayMat,
    this.ngheNghiep,
    this.thoiGianTao,
    this.pid,
    this.cid,
    this.root,
    this.trangThaiNode,
    this.soCon,
    this.soVoChong,
  });

  UserInfo.fromJson(Map<String, dynamic> json, {bool saveCidPid = false}) {
    idTamThoi = json["id"] ?? "";
    depth = json['generation'];
    memberId = json['_id'];
    userId = json['user_id'] ?? "";
    giaPhaId = json['familyId'];
    mid = json['mid'];
    fid = json['fid'];
    // trangThai = json['trang_thai'];
    ten = json["profile"]['name'];
    avatar = json["profile"]['avatar'];
    tenKhac = json["profile"]['otherName'];
    gioiTinh = json["profile"]['sex'];
    ngaySinh = json['profile']["dob"] ?? "";

    soDienThoai = json['profile']["phone"] ?? "";
    email = json['profile']['email'];
    // nguyenQuan = json['nguyen_quan'];
    diaChiHienTai = json['profile']["address"] == null
        ? ""
        : json['profile']["address"]["display_address"];
    trangThaiMat = json['status']['alive'];
    tieuSu = json['profile']['description'];
    ngayMat = json['status']["dod"] ?? "";
    ngheNghiep = json['profile']["job"] ?? "";
    thoiGianTao = json['createdAt'] ?? "";
    if (json['root'] != null) {
      if (json['root'] == true) {
        root = 1;
      } else if (json['root'] == false) {
        root = 0;
      } else {
        root = json['root'];
      }
    }
    if (saveCidPid) {
      cid = json['cid'];
      pid = json['pid'];
    }
    if (json['trang_thai_node'] != null) {
      trangThaiNode = json['trang_thai_node'];
    }
    soCon = json['so_con'];
    soVoChong = json['so_vo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'profile': <String, dynamic>{'address': <String, dynamic>{}},
      'status': <String, dynamic>{},
    };

    if (idTamThoi.isNotNullOrEmpty) data["id"] = idTamThoi;
    if (memberId.isNotNullOrEmpty) data['_id'] = memberId;
    if (giaPhaId.isNotNullOrEmpty) data['familyId'] = giaPhaId;
    if (mid.isNotNullOrEmpty) data['mid'] = mid;
    if (fid.isNotNullOrEmpty) data['fid'] = fid;
    if (ten.isNotNullOrEmpty) data['profile']['name'] = ten;
    if (avatar.isNotNullOrEmpty) data['profile']['avatar'] = avatar;
    if (tenKhac.isNotNullOrEmpty) data['profile']['otherName'] = tenKhac;
    if (gioiTinh.isNotNullOrEmpty) data['profile']['sex'] = gioiTinh;
    if (ngaySinh.isNotNullOrEmpty) data['profile']['dob'] = ngaySinh;

    if (soDienThoai.isNotNullOrEmpty) data['profile']['phone'] = soDienThoai;
    if (email.isNotNullOrEmpty) data['profile']['email'] = email;
    if (diaChiHienTai.isNotNullOrEmpty) {
      data['profile']['address']['display_address'] = diaChiHienTai;
    }
    if (trangThaiMat.isNotNullOrEmpty) data["status"]['alive'] = trangThaiMat;
    if (tieuSu.isNotNullOrEmpty) data["profile"]['description'] = tieuSu;

    if (ngayMat.isNotNullOrEmpty) data["status"]['dod'] = ngayMat;

    if (ngheNghiep.isNotNullOrEmpty) data["profile"]['job'] = ngheNghiep;
    if (thoiGianTao.isNotNullOrEmpty) data['createAt'] = thoiGianTao;
    if (pid.isNotNullOrEmpty) data['sid'] = pid;
    if (cid.isNotNullOrEmpty) data['cid'] = cid;

    if (root != null) data['root'] = root;
    if (trangThaiNode != null) {
      data['trang_thai_node'] = trangThaiNode;
    }
    return data;
  }

  UserInfo copyWith({
    String? maChiaSe,
    String? idTamThoi,
    int? depth,
    String? memberId,
    String? userId,
    String? giaPhaId,
    String? mid,
    String? fid,
    String? trangThai,
    String? ten,
    String? avatar,
    String? tenKhac,
    String? gioiTinh,
    String? ngaySinh,
    String? gioSinh,
    String? soDienThoai,
    String? email,
    String? trinhDo,
    String? nguyenQuan,
    String? diaChiHienTai,
    String? trangThaiMat,
    String? tieuSu,
    String? ngayMat,
    String? ngayGio,
    String? noiThoCung,
    String? nguoiPhuTrachCung,
    String? ngheNghiep,
    String? moTang,
    String? trucXuat,
    String? lyDoTrucXuat,
    String? thoiGianTao,
    String? pid,
    String? cid,
    int? root,
    int? trangThaiNode,
    int? soCon,
    int? soVoChong,
  }) {
    return UserInfo(
      idTamThoi: idTamThoi ?? this.idTamThoi,
      depth: depth ?? this.depth,
      memberId: memberId ?? this.memberId,
      userId: userId ?? this.userId,
      giaPhaId: giaPhaId ?? this.giaPhaId,
      mid: mid ?? this.mid,
      fid: fid ?? this.fid,
      trangThai: trangThai ?? this.trangThai,
      ten: ten ?? this.ten,
      avatar: avatar ?? this.avatar,
      tenKhac: tenKhac ?? this.tenKhac,
      gioiTinh: gioiTinh ?? this.gioiTinh,
      ngaySinh: ngaySinh ?? this.ngaySinh,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      email: email ?? this.email,
      diaChiHienTai: diaChiHienTai ?? this.diaChiHienTai,
      trangThaiMat: trangThaiMat ?? this.trangThaiMat,
      tieuSu: tieuSu ?? this.tieuSu,
      ngayMat: ngayMat ?? this.ngayMat,
      ngheNghiep: ngheNghiep ?? this.ngheNghiep,
      thoiGianTao: thoiGianTao ?? this.thoiGianTao,
      pid: pid ?? this.pid,
      cid: cid ?? this.cid,
      root: root ?? this.root,
      trangThaiNode: trangThaiNode ?? this.trangThaiNode,
      soCon: soCon ?? this.soCon,
      soVoChong: soVoChong ?? this.soVoChong,
    );
  }

  @override
  List<Object?> get props => [
        idTamThoi,
        depth,
        memberId,
        userId,
        giaPhaId,
        mid,
        fid,
        trangThai,
        ten,
        avatar,
        tenKhac,
        gioiTinh,
        ngaySinh,
        soDienThoai,
        email,
        diaChiHienTai,
        trangThaiMat,
        tieuSu,
        ngayMat,
        ngheNghiep,
        thoiGianTao,
        pid,
        cid,
        root,
        trangThaiNode,
      ];
}

class Member {
  UserInfo? info;
  List<UserInfo>? pids;
  UserInfo? fInfo;
  UserInfo? mInfo;
  List<UserInfo>? cInfo;
  List<UserInfo>? pInfo;
  Member(
    this.info,
    this.pids, {
    this.fInfo,
    this.mInfo,
    this.cInfo,
    this.pInfo,
  });

  Member.fromJson(Map<String, dynamic> json, {bool saveCidPid = false}) {
    if (saveCidPid) {
      info = UserInfo.fromJson(json['info'], saveCidPid: saveCidPid);
    } else {
      info = UserInfo.fromJson(json, saveCidPid: saveCidPid);
    }
    pids = [];
    if (json['pid'] != null && json['pid'].toString() != "[]") {
      for (var element in List.from(json['pid'])) {
        pids?.add(UserInfo.fromJson(element, saveCidPid: saveCidPid));
      }
    }

    if (json['fInfo'] != null) {
      fInfo = UserInfo.fromJson(json['fInfo']);
    }
    if (json['mInfo'] != null) {
      mInfo = UserInfo.fromJson(json['mInfo']);
    }
    pInfo = [];
    if (json['pInfo'] != null && json['pInfo'].toString() != "[]") {
      for (var element in List.from(json['pInfo'])) {
        pInfo?.add(UserInfo.fromJson(element));
      }
    }
    cInfo = [];
    if (json['cInfo'] != null && json['cInfo'].toString() != "[]") {
      for (var element in List.from(json['cInfo'])) {
        if (element.runtimeType != String) {
          cInfo?.add(UserInfo.fromJson(element));
        }
      }
    }
  }

  Member copyWith({
    UserInfo? info,
    List<UserInfo>? pids,
    // MemberInfo? fInfo,
    // MemberInfo? mInfo,
    List<UserInfo>? cInfo,
  }) {
    return Member(
      (info ?? this.info)?.copyWith(),
      (pids ?? this.pids)?.map((e) => e.copyWith()).toList(),
      // {(fInfo ?? this.fInfo)?.map((e) => e.copyWith()).toList(),
      //   (mInfo ?? this.mInfo)?.map((e) => e.copyWith()).toList() } ,
      // (cid ?? this.cid),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    if (info != null) {
      data['info'] = info!.toJson();
      if (pids != null && pids!.isNotEmpty) {
        data.putIfAbsent("pid", () => pids!.map((e) => e.toJson()).toList());
      }
    }
    return data;
  }

  static Node castNode(Member member) {
    if (member.info != null) {
      List<String> listIdVoChong = [];
      if (member.pids != null && member.pids!.isNotEmpty) {
        for (var element in member.pids!) {
          listIdVoChong.add((element.memberId ?? "") +
              (element.trangThaiNode == TrangThaiNode.delete ? "da_xoa" : ""));
        }
      }
      return Node(
        idTamThoi: member.info!.idTamThoi,
        depth: member.info!.depth,
        memberId: member.info!.memberId,
        userId: member.info!.userId,
        giaPhaId: member.info!.giaPhaId,
        mid: member.info!.mid,
        fid: member.info!.fid,
        trangThai: member.info!.trangThai,
        ten: member.info!.ten,
        avatar: member.info!.avatar,
        tenKhac: member.info!.tenKhac,
        gioiTinh: member.info!.gioiTinh,
        ngaySinh: member.info!.ngaySinh,
        soDienThoai: member.info!.soDienThoai,
        email: member.info!.email,
        diaChiHienTai: member.info!.diaChiHienTai,
        trangThaiMat: member.info!.trangThaiMat,
        tieuSu: member.info!.tieuSu,
        ngayMat: member.info!.ngayMat,
        ngheNghiep: member.info!.ngheNghiep,
        thoiGianTao: member.info!.thoiGianTao,
        pids: listIdVoChong,
        pid: member.info!.pid,
        trangThaiNode: member.info!.trangThaiNode,
        cid: member.info!.cid,
        root: member.info!.root,
        isMerge: member.info?.isMerge ?? false
      );
    }
    return Node();
  }

  static Node castNodeFromMemberInfo(UserInfo memberInfo) {
    return Node(
      idTamThoi: memberInfo.idTamThoi,
      depth: memberInfo.depth,
      memberId: memberInfo.memberId,
      userId: memberInfo.userId,
      giaPhaId: memberInfo.giaPhaId,
      mid: memberInfo.mid,
      fid: memberInfo.fid,
      trangThai: memberInfo.trangThai,
      ten: memberInfo.ten,
      avatar: memberInfo.avatar,
      tenKhac: memberInfo.tenKhac,
      gioiTinh: memberInfo.gioiTinh,
      ngaySinh: memberInfo.ngaySinh,
      soDienThoai: memberInfo.soDienThoai,
      email: memberInfo.email,
      diaChiHienTai: memberInfo.diaChiHienTai,
      trangThaiMat: memberInfo.trangThaiMat,
      tieuSu: memberInfo.tieuSu,
      ngayMat: memberInfo.ngayMat,
      ngheNghiep: memberInfo.ngheNghiep,
      thoiGianTao: memberInfo.thoiGianTao,
      pid: memberInfo.pid,
      cid: memberInfo.cid,
      root: memberInfo.root,
      trangThaiNode: memberInfo.trangThaiNode,
    );
  }
}
