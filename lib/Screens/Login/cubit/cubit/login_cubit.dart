import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    User currentUser;
    emit(LoginLoading());

    var options = BaseOptions(
        contentType: 'application/json',
        method: 'POST',
        baseUrl: login_url,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);
    final body = {"email": email, "password": password};
    try {
      final response = await dio.post(
        "",
        data: body,
      );
      if (email.isEmpty || password.isEmpty) {
        emit(LoginFailed('Email or password is required!'));
      } else if (response.statusCode == HttpStatus.ok) {
        final data = response.data["userInfo"];

        final storage = FlutterSecureStorage();
        await storage.write(
            key: 'accessToken',
            value: response.data['userInfo']['accessToken']);
        await storage.write(
            key: 'accountId', value: response.data['accountId'].toString());
        if (data != null) {
          currentUser = User.fromJson(data);
          print(currentUser.toJson());
          Future.delayed(const Duration(seconds: 3), () {
            emit(LoginSuccess(currentUser));
          });
        } else {
          var data = response.data;
          print(data["accountId"]);
          await storage.write(
              key: 'accountId', value: response.data['accountId'].toString());
          emit(NewUser(data["accountId"]));
        }
      } else if (response.statusCode == 400) {
        emit(LoginFailed('Email or password is incorrect!'));
      }
    } catch (e) {
      print(e.toString());
      emit(LoginFailed(e.toString()));
    }
  }

  Future<User> getUser(int accountId) async {
    User currentUser = User();
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'GET',
        baseUrl: get_user_url,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);
    try {
      final response = await dio.get("$accountId");
      final storage = FlutterSecureStorage();
      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        currentUser = User.fromJson(data);
        await storage.write(
            key: 'accessToken', value: response.data['accessToken']);
        return currentUser;
      }
      return User.unknown();
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> isLogged() async {
    final storage = FlutterSecureStorage();
    String accessToken = await storage.read(key: "accessToken") ?? "";
    if (accessToken.isNotEmpty) {
      try {
        bool hasExpired = JwtDecoder.isExpired(accessToken);
        if (!hasExpired) {
          String accountId = await storage.read(key: "accountId") ?? "";
          User currentUser = await getUser(int.parse(accountId));
          print(currentUser.toJson());
          emit(LoginSuccess(currentUser));
        } else {
          storage.deleteAll();
          emit(LoginInitial());
        }
      } catch (e) {
        throw (e.toString());
      }
    } else {
      emit(LoginInitial());
    }
  }
}
