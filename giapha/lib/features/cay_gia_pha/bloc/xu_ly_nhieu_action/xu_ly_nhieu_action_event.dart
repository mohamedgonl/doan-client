// ignore_for_file: public_member_api_docs, sort_constructors_first
part of "xu_ly_nhieu_action_bloc.dart";

abstract class XuLyAction extends Equatable {
  const XuLyAction();

  @override
  List<Object?> get props => [];
}

class LuuNhieuAction extends XuLyAction {
  final List<MemberInfo> listCreated;
  final List<String> listIdDelete;
  final List<MemberInfo> listUpdated;
  final PosiClickSave viTri;
  final String giaPhaId;

  const LuuNhieuAction( {
    required this.viTri,
    required this.listCreated,
    required this.listIdDelete,
    required this.listUpdated,
    required this.giaPhaId
  });
}
