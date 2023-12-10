import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:giapha/features/access/data/datasources/access_remote_datasource.dart';
import 'package:giapha/features/access/data/models/User.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  final AccessRemoteDataSource accessRemoteDataSource;

  AccessBloc(this.accessRemoteDataSource) : super(AccessInitial()) {
    on<AccessEvent>((event, emit) async {
      if (event is SendLoginEvent) {
        try {
          emit(AccessLoadingState());
          final result = await accessRemoteDataSource.login(event.userInfo);
          final res = (result.fold(
              (l) => LoginFailState(""), (r) => LoginSuccessState()));
          if (res is LoginSuccessState) {}
          emit.call(LoginSuccessState());
        } catch (e) {
          print(e.toString());
          emit(LoginFailState("Exception"));
        }
      }
    });
  }
}
