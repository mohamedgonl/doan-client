part of 'them_gia_pha_bloc.dart';

abstract class ThemGiaPhaEvent extends Equatable {
  const ThemGiaPhaEvent();

  @override
  List<Object> get props => [];
}

class ThemGiaPhaInitEvent extends ThemGiaPhaEvent {}

class SaveThemOrSuaGiaPhaEvent extends ThemGiaPhaEvent {
  final ThemOrSuaGiaPhaEntity data;
  final String? giaPhaId;

  const SaveThemOrSuaGiaPhaEvent(this.data, this.giaPhaId);

  @override
  List<Object> get props => [data];
}
