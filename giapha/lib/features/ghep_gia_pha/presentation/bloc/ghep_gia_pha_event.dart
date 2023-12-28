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

class YeuCauGhepGiaPhaEvent extends GhepGiaPhaEvent {
  String giaPhaId;
  String nhanhSrcChoosed;
  String nhanhDesChoosed;
  YeuCauGhepGiaPhaEvent(
{
    required this.giaPhaId,
    required this.nhanhSrcChoosed,
    required this.nhanhDesChoosed,
  });
}

class GhepPreviewEvent extends GhepGiaPhaEvent {
  String giaPhaId;
  String nhanhSrcChoosed;
  String nhanhDesChoosed;
  GhepPreviewEvent({
    required this.giaPhaId,
    required this.nhanhSrcChoosed,
    required this.nhanhDesChoosed,
  });
}
