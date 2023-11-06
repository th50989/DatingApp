part of 'login_cubit.dart';

@immutable
class LoginState {}

class LoginInitial extends LoginState {
  LoginInitial();
}

class LoginLoading extends LoginState {
  LoginLoading();
}

class NewUser extends LoginState {
  int AccountId;
  NewUser(this.AccountId);
}

class NewUserCreating extends LoginState {}

class LoginSuccess extends LoginState {
  final User user;
  LoginSuccess(this.user);
}

class LogoutSuccess extends LoginState {
  LogoutSuccess();
}

class LoginFailed extends LoginState {
  final String error;
  LoginFailed(this.error);
}
