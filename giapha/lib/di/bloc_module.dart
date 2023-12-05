import 'package:get_it/get_it.dart';
import 'package:giapha/features/cay_gia_pha/bloc/cay_gia_pha_bloc.dart';
import 'package:giapha/features/cay_gia_pha/bloc/xu_ly_nhieu_action/xu_ly_nhieu_action_bloc.dart';

Future<void> blocModule(GetIt getIt) async {
  getIt.registerFactory<CayGiaPhaBloc>(
      () => CayGiaPhaBloc(getIt(), getIt(), getIt()));
  getIt
      .registerFactory<XuLyNhieuActionBloc>(() => XuLyNhieuActionBloc(getIt()));

 
}
