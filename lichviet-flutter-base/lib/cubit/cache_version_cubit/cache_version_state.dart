part of 'cache_version_cubit.dart';

class CacheVersionState extends Equatable {
  final LoadingStatus? status;

  final dynamic error;
  final Map<String, dynamic>?  versionData;

  const CacheVersionState({this.status, this.error, this.versionData});

  factory CacheVersionState.initial() {
    return const CacheVersionState(status: LoadingStatus.initial);
  }

  CacheVersionState copyWith(
      {LoadingStatus? status, dynamic error, Map<String, dynamic>?  versionData}) {
    return CacheVersionState(
      status: status ?? LoadingStatus.success,
      error: error ?? this.error,
     versionData:  versionData?? this.versionData,
    );
  }

  @override
  List<Object?> get props => [
        error,
        status,
        versionData,
      ];
}
