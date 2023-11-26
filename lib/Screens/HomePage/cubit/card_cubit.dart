import 'dart:io';

import 'package:believeder_app/Screens/HomePage/Widget/CardProvider/CardProvider.dart';

import 'package:believeder_app/Screens/HomePage/Widget/UserCard.dart';

import 'package:believeder_app/constant/url_constant.dart';

import 'package:bloc/bloc.dart';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:meta/meta.dart';

part 'card_state.dart';

class CardCubit extends Cubit<CardState> {
  CardCubit() : super(CardInitial());

  Future<void> getRandomUser() async {
    List<UserInfoModel> userInfoList;

    const storage = FlutterSecureStorage();

    var accessToken = await storage.read(key: 'accessToken');

    var options = BaseOptions(
        contentType: 'application/json',
        method: 'GET',
        baseUrl: base_url,
        headers: {'Authorization': 'Bearer $accessToken'},
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);

    try {
      final response = await dio.get('api/Relations/random-unmatched-users');
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        userInfoList =
            data.map((user) => UserInfoModel.fromJson(user)).toList();
        emit(CardSuccess(userInfoList));
      }
    } catch (e) {
      emit(CardFailed(e.toString()));
      throw (e.toString());
    }
  }

  Future<void> addFavorite(int otherUserId) async {
    const storage = FlutterSecureStorage();

    var accessToken = await storage.read(key: 'accessToken');
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'POST',
        baseUrl: base_url,
        headers: {'Authorization': 'Bearer $accessToken'},
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);
    var body = {"otherUserId": otherUserId, "isLike": true};
    try {
      final response =
          await dio.post('api/Relations/like-or-dislike', data: body);
      if (response.statusCode == 200) {
        print("like ok!");
      } else {
        print('Deo like duoc!');
      }
    } catch (e) {
      print(e.toString());
      throw (e.toString());
    }
  }
}
