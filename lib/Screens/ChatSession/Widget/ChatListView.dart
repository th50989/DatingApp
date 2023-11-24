import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_cubit.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_state.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Global_Members.dart';
import 'package:flutter/material.dart';
import 'package:believeder_app/Screens/ChatSession/Widget/SenderView.dart';
import 'package:believeder_app/Screens/ChatSession/Widget/RecieverView.dart';

class ChatListView extends StatefulWidget {
  ChatListView(
      {super.key,
      required this.scrollController,
      required this.peerUser,
      required this.currentUser});
  final ScrollController scrollController;
  User2 peerUser;
  User currentUser;
  // List<Chat> chatList = [];

  @override
  State<ChatListView> createState() => _ChatListViewState();
}

class _ChatListViewState extends State<ChatListView> {
  late ScrollController _scrollController;
  // Future<void> renderChatMessage(int peerUserId, String accessToken) async {
  //   var options = BaseOptions(
  //       contentType: 'application/json',
  //       method: 'GET',
  //       baseUrl: base_url,
  //       validateStatus: ((status) => status != null && status < 500));
  //   final Dio dio = Dio(options);
  //   dio.options.headers['Authorization'] = 'Bearer $accessToken';

  //   try {
  //     final response = await dio.get(
  //       "api/Users/get-messages?otherUserId=${widget.peerUser.userId}",
  //     );
  //     // debugPrint(response.data.toString());
  //     List<dynamic> responseData = response.data;
  //     //responseData.map((userJson) => Chat.fromJson(userJson)).toList();

  //     widget.chatList =
  //         responseData.map((chat) => Chat.fromJson(chat)).toList();
  //     debugPrint(widget.chatList.toString());
  //   } catch (e) {}
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    // });
    //context.read<ChatCubit>().renderChatMessage(widget.peerUser.userId);

    // renderChatMessage(widget.peerUser.userId, widget.currentUser.accessToken);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
    //   if (state is ChatRecived) {
    //     //Sort tin nhan theo time
    //     state.chatList.sort((a, b) => b.timeSent!.compareTo(a.timeSent!));
    //     // widget.chatList = widget.chatList.reversed.toList();
    //     return Expanded(
    //       child: ListView.builder(
    //           reverse: true,
    //           shrinkWrap: true,
    //           physics: const BouncingScrollPhysics(),
    //           controller: widget.scrollController,
    //           itemCount: state.chatList.length,
    //           itemBuilder: (context, index) =>
    //               (state.chatList[index].userIdFrom ==
    //                       widget.currentUser.userId)
    //                   ? SenderRowView(
    //                       senderMessage: state.chatList[index].content,
    //                       time: state.chatList[index].timeSent)
    //                   : ReceiverRowView(
    //                       receiverMessage: state.chatList[index].content,
    //                       time: state.chatList[index].timeSent,
    //                     )),
    //     );
    //   } else {
    //     // return Expanded(
    //     //   child: ListView.builder(
    //     //     reverse: true,
    //     //     shrinkWrap: true,
    //     //     physics: const BouncingScrollPhysics(),
    //     //     controller: widget.scrollController,
    //     //     itemCount: state.chatList.length,
    //     //     itemBuilder: (context, index) =>
    //     //         (state.chatList[index].userIdFrom == widget.currentUser.userId)
    //     //             ? ReceiverRowView(
    //     //                 receiverMessage: widget.chatList[index].content,
    //     //                 time: widget.chatList[index].timeSent,
    //     //               )
    //     //             : SenderRowView(
    //     //                 senderMessage: widget.chatList[index].content,
    //     //                 time: widget.chatList[index].timeSent),
    //     //   ),
    //     // );
    //     return CircularProgressIndicator();
    //   }
    // });
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Messages')
          .orderBy('timeSent', descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return Expanded(
            child: ListView.builder(
                // controller: _scrollController.jumpTo(value),
                // controller:ScrollController(initialScrollOffset: ),
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  // var testId = document['UserIdFrom'];
                  try {
                    if ((document['UserIdFrom'] == widget.currentUser.userId &&
                            document['UserIdTo'] == widget.peerUser.userId) ||
                        (document['UserIdFrom'] == widget.peerUser.userId &&
                            document['UserIdTo'] ==
                                widget.currentUser.userId)) {
                      if (document['UserIdFrom'] == widget.currentUser.userId) {
                        return SenderRowView(
                            senderMessage: document['content'],
                            time: document['timeSent']);
                      } else {
                        return ReceiverRowView(
                            receiverMessage: document['content'],
                            time: document['timeSent']);
                      }
                    }
                  } catch (e) {}
                  // } else {
                  //   return Center(child: CircularProgressIndicator());
                  // }
                  return Container();
                }),
          );
        }
      },
    );
  }
}
