import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/features/cay_gia_pha/datasource/data/member_model.dart';
import 'package:giapha/features/quanly_thanhvien/data/datasources/quanly_chucvu_remote_datasource.dart';
import 'package:giapha/features/quanly_thanhvien/data/datasources/quanly_thanhvien_remote_datasource.dart';
import 'package:giapha/features/quanly_thanhvien/data/models/chucvu_model.dart';

part 'quanly_chucvu_event.dart';
part 'quanly_chucvu_state.dart';

class QuanLyChucVuBloc extends Bloc<QuanLyChucVuEvent, QuanLyChucVuState> {
  final QuanLyChucVuDataSource _quanlychucVuDataSource;

  QuanLyChucVuBloc(this._quanlychucVuDataSource)
      : super(QuanLyChucVuInitial()) {
    on<QuanLyChucVuEvent>((event, emit) async {
      if (event is LayChucVuEvent) {
        final result = await _quanlychucVuDataSource.layChucVu(event.giaPhaId);
        final fin =
            result.fold((l) => LayChucVuError(), (r) => LayChucVuSuccess(r));
        emit(fin);
      }

      if (event is CapNhapChucVuEvent) {
        final result = await _quanlychucVuDataSource.capNhapChucVu(
            event.id, event.tenChucVu);
        final fin = result.fold(
            (l) => CapNhapChucVuError(), (r) => CapNhapChucVuSuccess(r[0], r[1]));
        emit(fin);
      }

      if (event is XoaChucVuEvent) {
        final result = await _quanlychucVuDataSource.xoaChucVu(event.id);
        final fin =
            result.fold((l) => LayChucVuError(), (r) => XoaChucVuSuccess(r));
        emit(fin);
      }

      if (event is ThemChucVuEvent) {
        final result = await _quanlychucVuDataSource.themChucVu(
            event.giaPhaId, event.chucVu);
        final fin =
            result.fold((l) => ThemChucVuError(), (r) => ThemChucVuSuccess(r));
        emit(fin);
      }
    });
  }
}
