

import 'package:equatable/equatable.dart';
import 'package:giapha/core/constants/api_value_constants.dart';
import 'package:giapha/core/core_gia_pha.dart';
import '../../../../core/clone/graph/GraphView.dart';

class MemberInfo extends Equatable {
  String? maChiaSe;
  String? idTamThoi;
  String? ancestorId;
  String? descendantId;
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
  String? gioSinh;
  String? soDienThoai;
  String? email;
  String? trinhDo;
  String? nguyenQuan;
  String? diaChiHienTai;
  String? trangThaiMat;
  String? tieuSu;
  String? ngayMat;
  String? ngayGio;
  String? noiThoCung;
  String? nguoiPhuTrachCung;
  String? ngheNghiep;
  String? moTang;
  String? trucXuat;
  String? lyDoTrucXuat;
  String? thoiGianTao;
  String? chucVu;
  String? chucVuId;
  String? pid; // id cua thanh vien truc he
  String? cid; // id cua con
  int? root;
  int? trangThaiNode; // 0: create, 1: delete, 2: update
  int? soCon;
  int? soVoChong;

  MemberInfo({
    this.maChiaSe,
    this.idTamThoi,
    this.ancestorId,
    this.descendantId,
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
    this.gioSinh,
    this.soDienThoai,
    this.email,
    this.trinhDo,
    this.nguyenQuan,
    this.diaChiHienTai,
    this.trangThaiMat,
    this.tieuSu,
    this.ngayMat,
    this.ngayGio,
    this.noiThoCung,
    this.nguoiPhuTrachCung,
    this.ngheNghiep,
    this.moTang,
    this.trucXuat,
    this.lyDoTrucXuat,
    this.thoiGianTao,
    this.chucVu,
    this.chucVuId,
    this.pid,
    this.cid,
    this.root,
    this.trangThaiNode,
    this.soCon,
    this.soVoChong,
  });

  MemberInfo.fromJson(Map<String, dynamic> json, {bool saveCidPid = false}) {
    maChiaSe = json['user_id'];
    idTamThoi = json["id"];
    ancestorId = json['ancestor_id'];
    descendantId = json['descendant_id'];
    depth = json['depth'];
    memberId = json['member_id'];
    userId = json['user_id'];
    giaPhaId = json['gia_pha_id'];
    mid = json['mid'];
    fid = json['fid'];
    trangThai = json['trang_thai'];
    ten = json['ten'];
    avatar = json['avatar'];
    tenKhac = json['ten_khac'];
    gioiTinh = json['gioi_tinh'];
    chucVuId = json['chuc_vu'];
    ngaySinh = json['ngay_sinh'];
    gioSinh = json['gio_sinh'];
    soDienThoai = json['so_dien_thoai'];
    email = json['email'];
    trinhDo = json['trinh_do'];
    nguyenQuan = json['nguyen_quan'];
    diaChiHienTai = json['dia_chi_hien_tai'];
    trangThaiMat = json['trang_thai_mat'];
    tieuSu = json['tieu_su'];
    ngayMat = json['ngay_mat'];
    ngayGio = json['ngay_gio'];
    noiThoCung = json['noi_tho_cung'];
    nguoiPhuTrachCung = json['nguoi_phu_trach_cung'];
    ngheNghiep = json['nghe_nghiep'];
    moTang = json['mo_tang'];
    trucXuat = json['truc_xuat'];
    lyDoTrucXuat = json['ly_do_truc_xuat'];
    thoiGianTao = json['thoi_gian_tao'];
    chucVu = json['ten_chuc_vu'];
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
    final Map<String, dynamic> data = {};
    if (idTamThoi.isNotNullOrEmpty) data["id"] = idTamThoi;
    if (maChiaSe.isNotNullOrEmpty) data["user_id"] = maChiaSe;
    if (memberId.isNotNullOrEmpty) data['member_id'] = memberId;
    if (giaPhaId.isNotNullOrEmpty) data['gia_pha_id'] = giaPhaId;
    if (mid.isNotNullOrEmpty) data['mid'] = mid;
    if (fid.isNotNullOrEmpty) data['fid'] = fid;
    if (ten.isNotNullOrEmpty) data['ten'] = ten;
    if (avatar.isNotNullOrEmpty) data['avatar'] = avatar;
    if (tenKhac.isNotNullOrEmpty) data['ten_khac'] = tenKhac;
    if (gioiTinh.isNotNullOrEmpty) data['gioi_tinh'] = gioiTinh;
    if (ngaySinh.isNotNullOrEmpty) data['ngay_sinh'] = ngaySinh;
    if (gioSinh.isNotNullOrEmpty) {
      data['gio_sinh'] = gioSinh;
    }
    if (soDienThoai.isNotNullOrEmpty) data['so_dien_thoai'] = soDienThoai;
    if (email.isNotNullOrEmpty) data['email'] = email;
    if (trinhDo.isNotNullOrEmpty) data['trinh_do'] = trinhDo;
    if (diaChiHienTai.isNotNullOrEmpty) {
      data['dia_chi_hien_tai'] = diaChiHienTai;
    }
    if (trangThaiMat.isNotNullOrEmpty) data['trang_thai_mat'] = trangThaiMat;
    if (tieuSu.isNotNullOrEmpty) data['tieu_su'] = tieuSu;

    if (ngayMat.isNotNullOrEmpty) data['ngay_mat'] = ngayMat;
    if (ngayGio.isNotNullOrEmpty) data['ngay_gio'] = ngayGio;
    if (noiThoCung.isNotNullOrEmpty) data['noi_tho_cung'] = noiThoCung;
    if (nguoiPhuTrachCung.isNotNullOrEmpty) {
      data['nguoi_phu_trach_cung'] = nguoiPhuTrachCung;
    }
    if (ngheNghiep.isNotNullOrEmpty) data['nghe_nghiep'] = ngheNghiep;
    if (moTang.isNotNullOrEmpty) data['mo_tang'] = moTang;
    if (trucXuat.isNotNullOrEmpty) data['truc_xuat'] = trucXuat;
    if (lyDoTrucXuat.isNotNullOrEmpty) data['ly_do_truc_xuat'] = lyDoTrucXuat;
    if (thoiGianTao.isNotNullOrEmpty) data['thoi_gian_tao'] = thoiGianTao;
    if (chucVu.isNotNullOrEmpty) data['ten_chuc_vu'] = chucVu;
    if (chucVuId.isNotNullOrEmpty) data['chuc_vu'] = chucVuId;
    if (pid.isNotNullOrEmpty) data['pid'] = pid;
    if (cid.isNotNullOrEmpty) data['cid'] = cid;

    if (root != null) data['root'] = root;
    if (trangThaiNode != null) {
      data['trang_thai_node'] = trangThaiNode;
    }
    return data;
  }

  MemberInfo copyWith({
    String? maChiaSe,
    String? idTamThoi,
    String? ancestorId,
    String? descendantId,
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
    String? chucVu,
    String? chucVuId,
    String? pid,
    String? cid,
    int? root,
    int? trangThaiNode,
    int? soCon,
    int? soVoChong,
  }) {
    return MemberInfo(
      maChiaSe: maChiaSe ?? this.maChiaSe,
      idTamThoi: idTamThoi ?? this.idTamThoi,
      ancestorId: ancestorId ?? this.ancestorId,
      descendantId: descendantId ?? this.descendantId,
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
      gioSinh: gioSinh ?? this.gioSinh,
      soDienThoai: soDienThoai ?? this.soDienThoai,
      email: email ?? this.email,
      trinhDo: trinhDo ?? this.trinhDo,
      nguyenQuan: nguyenQuan ?? this.nguyenQuan,
      diaChiHienTai: diaChiHienTai ?? this.diaChiHienTai,
      trangThaiMat: trangThaiMat ?? this.trangThaiMat,
      tieuSu: tieuSu ?? this.tieuSu,
      ngayMat: ngayMat ?? this.ngayMat,
      ngayGio: ngayGio ?? this.ngayGio,
      noiThoCung: noiThoCung ?? this.noiThoCung,
      nguoiPhuTrachCung: nguoiPhuTrachCung ?? this.nguoiPhuTrachCung,
      ngheNghiep: ngheNghiep ?? this.ngheNghiep,
      moTang: moTang ?? this.moTang,
      trucXuat: trucXuat ?? this.trucXuat,
      lyDoTrucXuat: lyDoTrucXuat ?? this.lyDoTrucXuat,
      thoiGianTao: thoiGianTao ?? this.thoiGianTao,
      chucVu: chucVu ?? this.chucVu,
      chucVuId: chucVuId ?? this.chucVuId,
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
        maChiaSe,
        idTamThoi,
        ancestorId,
        descendantId,
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
        gioSinh,
        soDienThoai,
        email,
        trinhDo,
        nguyenQuan,
        diaChiHienTai,
        trangThaiMat,
        tieuSu,
        ngayMat,
        ngayGio,
        noiThoCung,
        nguoiPhuTrachCung,
        ngheNghiep,
        moTang,
        trucXuat,
        lyDoTrucXuat,
        thoiGianTao,
        chucVu,
        chucVuId,
        pid,
        cid,
        root,
        trangThaiNode,
      ];
}

class Member {
  MemberInfo? info;
  List<MemberInfo>? pids;
  MemberInfo? fInfo;
  MemberInfo? mInfo;
  List<MemberInfo>? cInfo;
  List<MemberInfo>? pInfo;
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
      info = MemberInfo.fromJson(json['info'], saveCidPid: saveCidPid);
    } else {
      info = MemberInfo.fromJson(json, saveCidPid: saveCidPid);
    }
    pids = [];
    if (json['pid'] != null && json['pid'].toString() != "[]") {
      for (var element in List.from(json['pid'])) {
        pids?.add(MemberInfo.fromJson(element, saveCidPid: saveCidPid));
      }
    }

    if (json['fInfo'] != null) {
      fInfo = MemberInfo.fromJson(json['fInfo']);
    }
    if (json['mInfo'] != null) {
      mInfo = MemberInfo.fromJson(json['mInfo']);
    }
    pInfo = [];
    if (json['pInfo'] != null && json['pInfo'].toString() != "[]") {
      for (var element in List.from(json['pInfo'])) {
        pInfo?.add(MemberInfo.fromJson(element));
      }
    }
    cInfo = [];
    if (json['cInfo'] != null && json['cInfo'].toString() != "[]") {
      for (var element in List.from(json['cInfo'])) {
        if (element.runtimeType != String) {
          cInfo?.add(MemberInfo.fromJson(element));
        }
      }
    }
  }

  Member copyWith({
    MemberInfo? info,
    List<MemberInfo>? pids,
    // MemberInfo? fInfo,
    // MemberInfo? mInfo,
    List<MemberInfo>? cInfo,
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
        maChiaSe: member.info!.maChiaSe,
        idTamThoi: member.info!.idTamThoi,
        ancestorId: member.info!.ancestorId,
        descendantId: member.info!.descendantId,
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
        gioSinh: member.info!.gioSinh,
        soDienThoai: member.info!.soDienThoai,
        email: member.info!.email,
        trinhDo: member.info!.trinhDo,
        nguyenQuan: member.info!.nguyenQuan,
        diaChiHienTai: member.info!.diaChiHienTai,
        trangThaiMat: member.info!.trangThaiMat,
        tieuSu: member.info!.tieuSu,
        ngayMat: member.info!.ngayMat,
        ngayGio: member.info!.ngayGio,
        noiThoCung: member.info!.noiThoCung,
        nguoiPhuTrachCung: member.info!.nguoiPhuTrachCung,
        ngheNghiep: member.info!.ngheNghiep,
        moTang: member.info!.moTang,
        trucXuat: member.info!.trucXuat,
        lyDoTrucXuat: member.info!.lyDoTrucXuat,
        thoiGianTao: member.info!.thoiGianTao,
        chucVu: member.info!.chucVu,
        chucVuId: member.info!.chucVuId,
        pids: listIdVoChong,
        pid: member.info!.pid,
        trangThaiNode: member.info!.trangThaiNode,
        cid: member.info!.cid,
        root: member.info!.root,
      );
    }
    return Node();
  }

  static Node castNodeFromMemberInfo(MemberInfo memberInfo) {
    return Node(
      maChiaSe: memberInfo.maChiaSe,
      idTamThoi: memberInfo.idTamThoi,
      ancestorId: memberInfo.ancestorId,
      descendantId: memberInfo.descendantId,
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
      gioSinh: memberInfo.gioSinh,
      soDienThoai: memberInfo.soDienThoai,
      email: memberInfo.email,
      trinhDo: memberInfo.trinhDo,
      nguyenQuan: memberInfo.nguyenQuan,
      diaChiHienTai: memberInfo.diaChiHienTai,
      trangThaiMat: memberInfo.trangThaiMat,
      tieuSu: memberInfo.tieuSu,
      ngayMat: memberInfo.ngayMat,
      ngayGio: memberInfo.ngayGio,
      noiThoCung: memberInfo.noiThoCung,
      nguoiPhuTrachCung: memberInfo.nguoiPhuTrachCung,
      ngheNghiep: memberInfo.ngheNghiep,
      moTang: memberInfo.moTang,
      trucXuat: memberInfo.trucXuat,
      lyDoTrucXuat: memberInfo.lyDoTrucXuat,
      thoiGianTao: memberInfo.thoiGianTao,
      chucVu: memberInfo.chucVu,
      chucVuId: memberInfo.chucVuId,
      pid: memberInfo.pid,
      cid: memberInfo.cid,
      root: memberInfo.root,
      trangThaiNode: memberInfo.trangThaiNode,
    );
  }
}
