part of 'danhsach_giapha_bloc.dart';

abstract class DanhsachGiaphaEvent extends Equatable {
  const DanhsachGiaphaEvent();

  @override
  List<Object> get props => [];
}

class LayDanhSachGiaPhaEvent extends DanhsachGiaphaEvent {}

class XoaGiaPhaEvent extends DanhsachGiaphaEvent {
  final String idGiaPha;

  const XoaGiaPhaEvent(this.idGiaPha);
}
