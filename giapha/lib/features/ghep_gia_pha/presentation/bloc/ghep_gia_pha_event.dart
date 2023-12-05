// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'ghep_gia_pha_bloc.dart';

abstract class GhepGiaPhaEvent extends Equatable {
  const GhepGiaPhaEvent();

  @override
  List<Object> get props => [];
}

class LayDanhSachGiaPhaDaTaoEvent extends GhepGiaPhaEvent {}

class LayDanhSachNhanhSrcEvent extends GhepGiaPhaEvent {
  String giaPhaId;
  LayDanhSachNhanhSrcEvent(
    this.giaPhaId,
  );
}

class LayDanhSachNhanhDesEvent extends GhepGiaPhaEvent {
  String giaPhaId;
  LayDanhSachNhanhDesEvent(
    this.giaPhaId,
  );
}

class GuiYeuCauGhepGiaPhaEvent extends GhepGiaPhaEvent {
  String giaPhaChoosed;
  String nhanhSrcChoosed;
  String nhanhDesChoosed;
  String? content;
  GuiYeuCauGhepGiaPhaEvent(
    this.content, {
    required this.giaPhaChoosed,
    required this.nhanhSrcChoosed,
    required this.nhanhDesChoosed,
  });
}
