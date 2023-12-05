part of 'init_cubit.dart';

class InitState extends Equatable {
  final LoadingStatus status;
  final dynamic error;
  final bool update;

  const InitState({required this.status, this.error, required this.update});

  factory InitState.initial() {
    return const InitState(status: LoadingStatus.initial, update: false);
  }

  InitState copyWith({
    LoadingStatus? status,
    required bool update,
    dynamic error,
  }) {
    return InitState(
      status: status ?? LoadingStatus.initial,
      update: update,
      error: error,
    );
  }

  @override
  List<Object?> get props => [error, status, update];
}
