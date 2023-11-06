import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserRepo {
  UserRepo();

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
      } else {
        return User.unknown();
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<User> sendCreateUserRequest(var body) async {
    User currentUser;
    Response response;
    var options = BaseOptions(
      baseUrl: create_new_user,
      method: 'POST',
      contentType: 'application/json',
      connectTimeout: 30000,
    );
    var dio = Dio(options);
    try {
      response = await dio.post('', data: body);
    } catch (e) {
      throw (e.toString());
    }

    if (response.statusCode == 200) {
      currentUser = await getUser(body.accountId);
      return currentUser;
    } else {
      return User.unknown();
    }
  }
}
