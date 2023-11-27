part of 'avatar_cubit.dart';

@immutable
class AvatarState {}

class AvatarInitial extends AvatarState {}

class AvatarGetSuccess extends AvatarState {
  final String imageUrl;
  AvatarGetSuccess(this.imageUrl);
}

class AvatarGetFailed extends AvatarState {
  final String error;
  AvatarGetFailed(this.error);
}

class AvatarUploadSuccess extends AvatarState {
  final String imageUrl;
  AvatarUploadSuccess(this.imageUrl);
}

class AvatarSelectSuccess extends AvatarState {
  final File image;
  AvatarSelectSuccess(this.image);
}

class AvatarSelectFailed extends AvatarState {}

class AvatarUploadFailed extends AvatarState {
  final String error;
  AvatarUploadFailed(this.error);
}
