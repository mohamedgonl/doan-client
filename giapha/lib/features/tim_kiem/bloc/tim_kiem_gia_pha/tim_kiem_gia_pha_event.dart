part of 'tim_kiem_gia_pha_bloc.dart';

abstract class TimKiemGiaPhaEvent extends Equatable {
  const TimKiemGiaPhaEvent();

  @override
  List<Object?> get props => [];
}

class TimKiemGiaPhaTheoText extends TimKiemGiaPhaEvent {
  final String keySearch;
  const TimKiemGiaPhaTheoText(this.keySearch);
}
