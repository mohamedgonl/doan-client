part of 'danhsach_giapha_bloc.dart';

abstract class DanhsachGiaphaState extends Equatable {
  const DanhsachGiaphaState();
  @override
  List<Object> get props => [];
}

class DanhsachGiaphaInitial extends DanhsachGiaphaState {}

class Loading extends DanhsachGiaphaState {}

class Loaded extends DanhsachGiaphaState {
  final List<GiaPha> danhSachGiaPha;

  const Loaded(this.danhSachGiaPha);
  @override
  List<Object> get props => [identityHashCode(this)];
}

class XoaGiaPhaSuccess extends DanhsachGiaphaState {}

class Empty extends DanhsachGiaphaState {}

// class LayDanhSachError extends DanhsachGiaphaState {
//   final message = "Không có kết nối mạng. Vui lòng kiểm tra & thử lại!";
// }

class LayDanhSachError extends DanhsachGiaphaState {
  final String message;

  const LayDanhSachError({required this.message}) : super();
}
