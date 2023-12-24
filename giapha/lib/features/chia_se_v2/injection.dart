import 'package:get_it/get_it.dart';
import 'package:giapha/features/chia_se_v2/datasource/share_remote_datasource.dart';
import 'package:giapha/features/chia_se_v2/presentation/bloc/share_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => ShareBloc(sl()));

  // data sources
  sl.registerFactory(() => ShareRemoteDataSource());

}
