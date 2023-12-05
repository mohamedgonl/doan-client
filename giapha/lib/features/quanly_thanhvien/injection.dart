import 'package:get_it/get_it.dart';
import 'package:giapha/features/quanly_thanhvien/data/datasources/quanly_chucvu_remote_datasource.dart';
import 'package:giapha/features/quanly_thanhvien/data/datasources/quanly_thanhvien_remote_datasource.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_chucvu/quanly_chucvu_bloc.dart';
import 'package:giapha/features/quanly_thanhvien/presentation/bloc/quanly_thanhvien/quanly_thanhvien_bloc.dart';

Future<void> init(GetIt sl) async {
  //bloc
  sl.registerFactory(() => QuanLyChucVuBloc(sl()));
  sl.registerFactory(() => QuanLyThanhVienBloc(sl(), sl()));
  // usecase

  // repository

  // data sources
  sl.registerFactory(() => QuanLyChucVuDataSource(sl()));
  sl.registerFactory(() => QuanLyThanhVienDataSource(sl()));

  // remote

  // local
}
