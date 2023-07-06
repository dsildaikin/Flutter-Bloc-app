import 'package:bloc_test/bloc/api_event.dart';
import 'package:bloc_test/bloc/api_state.dart';
import 'package:bloc_test/data/api_provider.dart';
import 'package:bloc_test/data/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(InitialState()) {
    on<GetUsersEvent>(_getUserList);
  }

  _getUserList(GetUsersEvent event, Emitter<ApiState> emit) async {
    try {
      emit(LoadingState());
      List<User> users = await ApiProvider().getUsers();
      emit(SuccessUserList(users));
    } catch (e) {
      emit(FailureState());
    }
  }
}
