import 'package:equatable/equatable.dart';
import 'package:lichviet_flutter_base/cubit/cubit.dart';
import 'package:lichviet_flutter_base/cubit/loading_status.dart';
import 'package:lichviet_flutter_base/domain/entities/config_entity.dart';

class AppState extends Equatable {
  final LoadingStatus? status;
  final bool? checkXemNgayTot;
  final ConfigEntity? config;
  final dynamic error;
  final MenuTab? index;

  const AppState({
    this.status,
    this.checkXemNgayTot,
    this.config,
    this.error,
    this.index,
  });

  factory AppState.initial() {
    return const AppState(status: LoadingStatus.initial);
  }

  AppState copyWith({
    LoadingStatus? status,
    bool? checkXemNgayTot,
    dynamic error,
    ConfigEntity? config,
    MenuTab? index,
  }) {
    return AppState(
      status: status ?? LoadingStatus.initial,
      checkXemNgayTot: checkXemNgayTot ?? this.checkXemNgayTot,
      config: config ?? this.config,
      error: error,
      index: index ?? this.index,
    );
  }

  @override
  List<Object?> get props => [
        error,
        status,
        checkXemNgayTot,
        config,
        index,
      ];
}
