import 'dart:convert';
import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  String userNoInfor = 'User information not found.';
  Future<void> login(String email, String password) async {
    emit(LoginLoading());
    Future.delayed(Duration(seconds: 1));
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'POST',
        baseUrl: base_url,
        validateStatus: (status) {
          return status! < 500; // Accept all status codes below 500
        });

    final Dio dio = Dio(options);
    final body = {"email": email, "password": password};
    try {
      final response = await dio.post(
        "api/Users/login",
        data: body,
      );
      debugPrint(response.data.toString());
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        // Map<String, dynamic> userData = json.decode(data);
        User currentUser = User.fromJson(data);
        print(currentUser.toJson());
        emit(LoginSuccess(currentUser));
      } else if (response.data.toString() == userNoInfor) {
        emit(LoginSuccessButNoUser());
      } else {
        emit(LoginFailed('Error of API'));
      }
    } catch (e) {
      print(e.toString());
      emit(LoginFailed(e.toString()));
    }
  }
}
