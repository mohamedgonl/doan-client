// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "xu_ly_nhieu_action_bloc.dart";

abstract class XuLyActionState extends Equatable {
  const XuLyActionState();

  @override
  List<Object?> get props => [identityHashCode(this)];
}

class XuLyNhieuInitial extends XuLyActionState {}

class XuLyNhieuActionSuccess extends XuLyActionState {
  final PosiClickSave viTriClick;
  const XuLyNhieuActionSuccess(this.viTriClick);
}

class XuLyNhieuActionLoading extends XuLyActionState {}

class XuLyNhieuActionError extends XuLyActionState {
  final String msg;
  final PosiClickSave viTriClick;
  const XuLyNhieuActionError(this.msg, this.viTriClick);
}
