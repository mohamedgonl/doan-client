import 'package:get_it/get_it.dart';
import 'package:lichviet_flutter_base/data/datasource/native/lunar_calendar_data_source.dart';
import 'package:lichviet_flutter_base/data/datasource/native/user_native_datasource.dart';


Future<void> nativeModule(GetIt getIt) async {
  getIt
  ..registerFactory<UserNativeDatasource>(() => UserNativeDatasource(getIt()))
  ..registerFactory<LunarCalendarDatasource>(() => LunarCalendarDatasource(getIt()))
   ;
}
