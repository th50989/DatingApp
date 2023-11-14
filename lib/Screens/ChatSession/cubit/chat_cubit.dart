import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_state.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatReciving());

  void handleNoti() {
    //Xu ly render() lai giao dien
    emit(newMessage());
  }

  Future<void> renderChatMessage(int peerUserId) async {
    var storage = FlutterSecureStorage();
    var accessToken = await storage.read(key: 'accessToken');
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'GET',
        baseUrl: base_url,
        validateStatus: ((status) => status != null && status < 500));
    final Dio dio = Dio(options);
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    try {
      final response = await dio.get(
        "api/Users/get-messages?otherUserId=${peerUserId}",
      );
      if (response.statusCode == 200) {
        List<dynamic> responseData = response.data;

        List<Chat> listChat =
            responseData.map((chatJson) => Chat.fromJson(chatJson)).toList();

        emit(ChatRecived(listChat));
      }
      // debugPrint(response.data.toString());

      //responseData.map((userJson) => Chat.fromJson(userJson)).toList();

      // widget.chatList =
      //     responseData.map((chat) => Chat.fromJson(chat)).toList();
      // debugPrint(widget.chatList.toString());
    } catch (e) {
      throw (e.toString());
    }
  }
}
