import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'access_event.dart';
part 'access_state.dart';

class AccessBloc extends Bloc<AccessEvent, AccessState> {
  AccessBloc() : super(AccessInitial()) {
    on<AccessEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
