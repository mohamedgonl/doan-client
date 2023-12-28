// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ghep_gia_pha_bloc.dart';

abstract class GhepGiaPhaState extends Equatable {
  const GhepGiaPhaState();

  @override
  List<Object> get props => [identityHashCode(this)];
}

class GhepGiaPhaInitial extends GhepGiaPhaState {}

class LayDanhSachGiaPhaDaTaoSuccess extends GhepGiaPhaState {
  List<GiaPhaModel> danhsach;
  LayDanhSachGiaPhaDaTaoSuccess(
    this.danhsach,
  );
}

class LayDanhSachGiaPhaDaTaoError extends GhepGiaPhaState {}

class LayDanhSachNhanhSrcSuccess extends GhepGiaPhaState {
  List<Member> danhsach;
  LayDanhSachNhanhSrcSuccess(
    this.danhsach,
  );
  @override
  List<Object> get props => [danhsach];
}

class LayDanhSachNhanhSrcError extends GhepGiaPhaState {}

class LayDanhSachNhanhDesSuccess extends GhepGiaPhaState {
  List<Member> danhsach;
  LayDanhSachNhanhDesSuccess(
    this.danhsach,
  );
  @override
  List<Object> get props => [danhsach];
}

class LayDanhSachNhanhDesError extends GhepGiaPhaState {}

class GhepPreviewReady extends GhepGiaPhaState {
  List<List<Member>> cayGiaPha;
  GhepPreviewReady({
    required this.cayGiaPha,
  });
}

class GhepPreviewFail extends GhepGiaPhaState {
  String message;
  GhepPreviewFail({
    required this.message,
  });
}



class GhepSuccess extends GhepGiaPhaState {

}

class GhepFail extends GhepGiaPhaState {
    String message;
  GhepFail({
    required this.message,
  });
}
