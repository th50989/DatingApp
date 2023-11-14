import 'package:believeder_app/Models/models.dart';
import 'package:flutter/material.dart';

@immutable
class ChatState {}

class ChatRecived extends ChatState {
  List<Chat> chatList = [];
  ChatRecived(this.chatList);
}

class ChatReciving extends ChatState {
  ChatReciving();
}

class ChatRecivedFail extends ChatState {
  final String error;
  ChatRecivedFail(this.error);
}

class newMessage extends ChatState {
  newMessage();
}
