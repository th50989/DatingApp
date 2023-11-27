part of 'edit_info_cubit.dart';

@immutable
class EditInfoState {}

class EditInfoInitial extends EditInfoState {}

class EditInfoSuccess extends EditInfoState {}

class EditInfoFailed extends EditInfoState {
  final String error;
  EditInfoFailed(this.error);
}
