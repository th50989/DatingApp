import 'dart:io';

import 'package:believeder_app/constant/url_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:meta/meta.dart';

part 'avatar_state.dart';

class AvatarCubit extends Cubit<AvatarState> {
  AvatarCubit() : super(AvatarInitial());

  void selectImage(File image) {
    if (image.path.isNotEmpty) {
      emit(AvatarSelectSuccess(image));
    } else {
      emit(AvatarSelectFailed());
    }
  }

  Future<void> uploadImage(int userId, File image) async {
    String imgUrl;
    if (image != 'null') {
      final storageReference = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('avatar/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await storageReference.putFile(image);
      imgUrl = await storageReference.getDownloadURL();
      var body = {'ImgUrl': imgUrl};
      print('Image uploaded successfully. URL: $imgUrl');
      if (imgUrl.isNotEmpty) {
        try {
          var optionsAvt = BaseOptions(
              contentType: "application/json",
              method: 'PUT',
              baseUrl: base_url,
              validateStatus: ((status) => status != null && status < 500));

          final Dio dioAvt = Dio(optionsAvt);

          final responseAvt = await dioAvt
              .put('api/Users/update-image-url/$userId', data: body);
          if (responseAvt.statusCode == 200) {
            print('Image uploaded successfully. URL: $imgUrl');
            emit(AvatarUploadSuccess(imgUrl));
          }
        } catch (error) {
          print('Error uploading image: $error');
          emit(AvatarUploadFailed(error.toString()));
          throw (error.toString());
        }
      }
    }
  }
}
