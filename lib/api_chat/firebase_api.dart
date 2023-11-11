import 'package:believeder_app/Screens/ChatSession/FriendList.dart';
import 'package:believeder_app/Screens/ChatSession/Widget/ChatListView.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_cubit.dart';
import 'package:believeder_app/main.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class FirebaseApi {
  //tao instance cua firebase messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // init notification va lay token device
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();

    //lay token cua device
    final fCMToken = await _firebaseMessaging.getToken();
    print('My device`s Token: $fCMToken');

    initPushNotifications();
  }

  //function de xu ly khi user click vao thong bao
  void handleNotiPressed(RemoteMessage? message) {
    if (message == null) return;
    navigatorKey.currentState
        ?.pushNamed('/chat_list_screen', arguments: message);
  }

  //khi app dang chaybackground hoac da dong thi chay function nay
  Future initPushNotifications() async {
    FirebaseMessaging.instance.getInitialMessage().then(handleNotiPressed);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotiPressed);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle the message here
      print('Foreground Message Received: ${message.notification?.title}');
      handleIncomingNotification(message);
      // var storage = FlutterSecureStorage();
      // String peerUserId = await storage.read(key: 'peerUserId') ?? "";
      // context.read<ChatCubit>().renderChatMessage(int.parse(peerUserId));
    });

    // });
  }

  void handleIncomingNotification(RemoteMessage message) {
    // Perform actions based on the notification, e.g., show a dialog, update UI, etc.
    print('Handling Incoming Notification: ${message.notification?.title}');
  }

  // Future<void> handleIncomingNotification1(RemoteMessage message) {
  //   // Perform actions based on the notification, e.g., show a dialog, update UI, etc.
  //   print('Handling Incoming Notification: ${message.notification?.title}');
  //   // Add your custom logic here

  //   throw (e) {};
  // }
}
