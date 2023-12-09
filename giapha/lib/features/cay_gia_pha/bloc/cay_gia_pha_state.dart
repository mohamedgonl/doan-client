// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "cay_gia_pha_bloc.dart";

abstract class CayGiaPhaState extends Equatable {
  const CayGiaPhaState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class CayGiaPhaInitial extends CayGiaPhaState {}

class GetCayGiaPhaSuccess extends CayGiaPhaState {
  final List<List<Member>> listMember;
  const GetCayGiaPhaSuccess(this.listMember);
}

class GetCayGiaPhaError extends CayGiaPhaState {
  final String message;
  const GetCayGiaPhaError(
    this.message,
  );
}

class GetDanhSachNguoiMatSuccess extends CayGiaPhaState {
  final List<MemberInfo> listTVDaMat;
  const GetDanhSachNguoiMatSuccess(this.listTVDaMat);
}

class GetDanhSachNguoiMatError extends CayGiaPhaState {
  final String message;
  const GetDanhSachNguoiMatError(
    this.message,
  );
}

class XoaThanhVienError extends CayGiaPhaState {}

class XoaThanhVienSuccess extends CayGiaPhaState {}

class CayGiaPhaLoading extends CayGiaPhaState {}

class GetDanhSachNguoiMatLoading extends CayGiaPhaState {}

class LayCacYeuCauGhepGiaPhaSuccess extends CayGiaPhaState {
  final List<YeuCau> listRequired;
  const LayCacYeuCauGhepGiaPhaSuccess(
    this.listRequired,
  );
}

class LayCacYeuCauGhepGiaPhaError extends CayGiaPhaState {}

class GetLocalCayGiaPhaSuccess extends CayGiaPhaState {
  final List<List<Member>> listLocalMember;
  const GetLocalCayGiaPhaSuccess(this.listLocalMember);
}

// class XuLyNhieuActionSuccess extends CayGiaPhaState {
//   final PosiClickSave viTriClick;
//   const XuLyNhieuActionSuccess(this.viTriClick);
// }

// class XuLyNhieuActionLoading extends CayGiaPhaState {}

// class XuLyNhieuActionError extends CayGiaPhaState {
//   final String msg;
//   final PosiClickSave viTriClick;
//   const XuLyNhieuActionError(this.msg, this.viTriClick);
// }
