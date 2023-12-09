part of 'tim_kiem_gia_pha_bloc.dart';

abstract class TimKiemGiaPhaState extends Equatable {
  const TimKiemGiaPhaState();

   @override
  List<Object?> get props => [];
}

class TimKiemGiaPhaInitial extends TimKiemGiaPhaState{}

class TimKiemGiaPhaLoading extends TimKiemGiaPhaState {}

class TimKiemGiaPhaSuccess extends TimKiemGiaPhaState {
  final List<GiaPhaModel> listGiaPha;
  const TimKiemGiaPhaSuccess(this.listGiaPha);
}

class TimKiemGiaPhaError extends TimKiemGiaPhaState {
  final String msg;
  const TimKiemGiaPhaError(this.msg);
}
