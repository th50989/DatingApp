import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

import 'package:meta/meta.dart';

part 'edit_info_state.dart';

enum Info { bio, fname, lname, bday, gender, location }

class EditInfoCubit extends Cubit<EditInfoState> {
  EditInfoCubit() : super(EditInfoInitial());

  dynamic genBodyJson(Info part, String data, User currentUser) {
    var body;
    switch (part) {
      case Info.bio:
        return body = {
          'Bio': data,
        };

      case Info.fname:
        return body = {
          "gender": currentUser.gender,
          "birthday": currentUser.birthDay,
          "lastName": currentUser.lastName,
          "firstName": data,
          "location": currentUser.location
        };

      case Info.lname:
        return body = {
          "gender": currentUser.gender,
          "birthday": currentUser.birthDay,
          "lastName": data,
          "firstName": currentUser.firstName,
          "location": currentUser.location
        };

      case Info.bday:
        return body = {
          "gender": currentUser.gender,
          "birthday": data,
          "lastName": currentUser.lastName,
          "firstName": currentUser.firstName,
          "location": currentUser.location
        };

      case Info.gender:
        return body = {
          "gender": data,
          "birthday": currentUser.birthDay,
          "lastName": currentUser.lastName,
          "firstName": currentUser.firstName,
          "location": currentUser.location
        };

      case Info.location:
        return body = {
          "gender": currentUser.gender,
          "birthday": currentUser.birthDay,
          "lastName": currentUser.lastName,
          "firstName": currentUser.firstName,
          "location": data
        };
    }
  }

  Future<void> updateBio(String data, Info part, User currentUser) async {
    var body = genBodyJson(part, data, currentUser);

    var options = BaseOptions(
        contentType: 'application/json',
        method: 'PUT',
        baseUrl: base_url,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);

    try {
      final response = await dio
          .put('/api/Users/update-bio/${currentUser.userId}', data: body);

      if (response.statusCode == 200) {
        emit(EditInfoSuccess());
      }
    } catch (e) {
      emit(EditInfoFailed(e.toString()));
      throw (e.toString());
    }
  }

  Future<void> updateInfo(String data, Info part, User currentUser) async {
    var body = genBodyJson(part, data, currentUser);

    var options = BaseOptions(
        contentType: 'application/json',
        method: 'PUT',
        baseUrl: base_url,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);

    try {
      final response = await dio
          .put('api/Users/update-user/${currentUser.userId}', data: body);

      if (response.statusCode == 204) {
        emit(EditInfoSuccess());
      }
    } catch (e) {
      emit(EditInfoFailed(e.toString()));
      throw (e.toString());
    }
  }
}
