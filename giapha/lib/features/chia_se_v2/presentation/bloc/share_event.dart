part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();

  @override
  List<Object?> get props => [];
}

class TimKiemUser extends ShareEvent {
  final String keySearch;
  const TimKiemUser(this.keySearch);
}
