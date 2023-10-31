import 'dart:convert';
import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    emit(LoginLoading());

    var options = BaseOptions(
      contentType: 'application/json',
      method: 'POST',
      baseUrl: login_url,
    );

    final Dio dio = Dio(options);
    final body = {"email": email, "password": password};
    try {
      final response = await dio.post(
        "",
        data: body,
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        // Map<String, dynamic> userData = json.decode(data);
        User currentUser = User.fromJson(data);
        print(currentUser.toJson());
        emit(LoginSuccess(currentUser));
      }
    } catch (e) {
      print(e.toString());
      emit(LoginFailed(e.toString()));
    }
  }
}
