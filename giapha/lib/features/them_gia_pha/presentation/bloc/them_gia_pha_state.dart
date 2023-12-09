// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'them_gia_pha_bloc.dart';

abstract class ThemGiaPhaState extends Equatable {
  const ThemGiaPhaState();

  @override
  List<Object> get props => [];
}

class ThemGiaPhaInitial extends ThemGiaPhaState {}

class ThemGiaPhaError extends ThemGiaPhaState {
  String msg;
  ThemGiaPhaError({
    required this.msg,
  });
}

class ThemGiaPhaLoading extends ThemGiaPhaState {}
class ThemGiaPhaSuccess extends ThemGiaPhaState {}

class SuaGiaPhaSuccess extends ThemGiaPhaState {}
class SuaGiaPhaError extends ThemGiaPhaState {
  String msg;
  SuaGiaPhaError({
    required this.msg,
  });
}