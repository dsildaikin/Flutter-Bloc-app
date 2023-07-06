import 'package:bloc_test/data/user.dart';

abstract class ApiState {}

class InitialState extends ApiState {}

class FailureState extends ApiState {}

class LoadingState extends ApiState {}

class SuccessUserList extends ApiState {
  List<User> usersList;
  SuccessUserList(this.usersList);
}
