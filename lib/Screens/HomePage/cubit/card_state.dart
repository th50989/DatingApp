part of 'card_cubit.dart';

@immutable
class CardState {}

class CardInitial extends CardState {}

class CardSuccess extends CardState {
  final List<UserInfoModel> userInfoList;
  CardSuccess(this.userInfoList);
}

class CardFailed extends CardState {
  final String error;
  CardFailed(this.error);
}
