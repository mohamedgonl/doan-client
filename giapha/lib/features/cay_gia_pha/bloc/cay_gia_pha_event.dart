// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "cay_gia_pha_bloc.dart";

abstract class CayGiaPhaEvent extends Equatable {
  const CayGiaPhaEvent();

  @override
  List<Object?> get props => [];
}

class GetTreeGenealogy extends CayGiaPhaEvent {
  final String idGiaPha;
  const GetTreeGenealogy(this.idGiaPha) : super();
}

class LayDanhSachNguoiMat extends CayGiaPhaEvent {
  final String idGiaPha;
  final String? textSearch;
  final bool isTabTuDuong;
  const LayDanhSachNguoiMat(
    this.idGiaPha, {
    this.textSearch,
    this.isTabTuDuong = true,
  }) : super();
}

class XoaThanhVienEvent extends CayGiaPhaEvent {
  final String memberId;
  const XoaThanhVienEvent(
    this.memberId,
  );
}

class LayCacYeuCauGhepGiaPhaEvent extends CayGiaPhaEvent {}

class SaveLocalCayGiaPha extends CayGiaPhaEvent {
  final List<List<Member>> cayGiaPhaCache;
  final int indexStep;
  const SaveLocalCayGiaPha(this.cayGiaPhaCache, {required this.indexStep});
}

class GetLocalCayGiaPha extends CayGiaPhaEvent {
  final int indexStep;
  const GetLocalCayGiaPha(this.indexStep);
}

class ClearCacheEvent extends CayGiaPhaEvent {
  const ClearCacheEvent();
}

// class LuuNhieuAction extends CayGiaPhaEvent {
//   final List<MemberInfo> listCreated;
//   final List<String> listIdDelete;
//   final List<MemberInfo> listUpdated;
//   final PosiClickSave viTri;

//   const LuuNhieuAction({
//     required this.viTri,
//     required this.listCreated,
//     required this.listIdDelete,
//     required this.listUpdated,
//   });
// }
