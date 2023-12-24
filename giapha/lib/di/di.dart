import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:giapha/di/bloc_module.dart';
import 'package:giapha/di/local_module.dart';
import 'package:giapha/di/remote_module.dart';
import '../features/access//injection.dart' as access_di;
import '../features/danhsach_giapha/injection.dart' as danhsach_giapha_di;

import '../features/them_gia_pha/injection.dart' as themgiapha_di;
import '../features/quanly_thanhvien/injection.dart' as quanlythanhvien_di;
import '../features/ghep_gia_pha/injection.dart' as ghepgiapha_di;
import '../features/tim_kiem/injection.dart' as timkiem_di;
import '../features/chia_se_v2/injection.dart' as chiase_di;

///
/// Setup DI
///

Future<void> setupDiGiaPha() async {
  final getIt = GetIt.I;
  await remoteModule(getIt);
  await localModule(getIt);
  await blocModule(getIt);

  await access_di.init(getIt);

  await danhsach_giapha_di.init(getIt);

  await themgiapha_di.init(getIt);
  await quanlythanhvien_di.init(getIt);
  await ghepgiapha_di.init(getIt);
  await timkiem_di.init(getIt);

  await chiase_di.init(getIt);
}
