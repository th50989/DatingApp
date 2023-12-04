import 'dart:math';
import 'package:dio/dio.dart';
import 'Widget/ChatListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constant/colors_constant.dart';
import 'package:believeder_app/Models/models.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:believeder_app/Screens/ChatSession/FriendList.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_cubit.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_state.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';



class ChatSession extends StatefulWidget {
  const ChatSession({super.key, required this.user});
  final User2 user;
  @override
  State<ChatSession> createState() => _ChatSessionState();
}

class _ChatSessionState extends State<ChatSession> {
  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();
  void popOut() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      var storage = FlutterSecureStorage();
      storage.delete(key: 'peerUserId');
      return FriendChatList();
    }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var storage = FlutterSecureStorage();
    storage.write(key: 'peerUserId', value: widget.user.userId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kPrimaryLightColor,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          leadingWidth: 110.0,
          titleSpacing: -5.0,
          leading: Padding(
            padding: const EdgeInsets.only(
              left: 7.0,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    popOut();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    )
                  ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: const CircleAvatar(                
                    backgroundColor: Colors.blueAccent,
                    child: Text('Q',
                        style: TextStyle(
                          color: Colors.black,
                        )
                    ),
                  ),
                ),
              ],
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(left: 7.0),
            child: ListTile(
              title: Text(widget.user.firstName,
                  style: const TextStyle(
                    color: Colors.white,
                  )),
              subtitle: Text(
                widget.user.bio,
                style: TextStyle(
                  color: Colors.white70,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 1,
              ),
            ),
          ),
          actions: const [            
            Padding(
              padding: EdgeInsets.only(right: 20.0, left: 20.0),
              child: Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
          if (state is LoginSuccess) {
            // renderChatMessage(widget.user.userId, state.user.accessToken);
            return Column(
              children: [
                // BlocBuilder<ChatCubit, ChatState>(
                //     builder: (context, chatState) {
                ChatListView(
                  scrollController: scrollController,
                  peerUser: widget.user,
                  currentUser: state.user,
                ),
                // }),
                Container(
                  // height: 50,
                  margin: const EdgeInsets.all(8.0),
                  decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [                   
                      Expanded(
                        child: TextFormField(
                          controller: textEditingController,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 1,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            hintText: 'Type your message...',
                            hintStyle: TextStyle(color: Colors.grey),
                            isDense: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(21.0)),
                              borderSide: BorderSide(
                                color: kPrimaryColor,  // Màu sắc của viền
                                width: 2.0,           // Độ rộng của viền
                              ),
                            ),                          
                          ),
                        ),
                      ),
                      Container(
                        // color: Colors.white,
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 11.0),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              sendMessage(state.user.accessToken, state.user,
                                  widget.user);
                            },
                            onLongPress: () {},
                            child: const Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else
            return CircularProgressIndicator();
        }));
  }

  void sendMessage(String accessToken, User user, User2 peerUser) async {
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'POST',
        baseUrl: base_url,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dio = Dio(options);
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final body = {
      "OtherUserId": widget.user.userId,
      "Content": textEditingController.text
    };
    try {
      final response = await dio.post(
        "/api/Messages/send-message",
        data: body,
      );
      //context.read<ChatCubit>().renderChatMessage(widget.user.userId);

      debugPrint(response.data.toString());
    } catch (e) {}
    var base_url1 = '';
    var optionsFirebase = BaseOptions(
        contentType: 'application/json',
        method: 'POST',
        baseUrl: addmess,
        validateStatus: ((status) => status != null && status < 500));

    final Dio dioFirebase = Dio(optionsFirebase);
    final bodyFirebase = {
      "UserIdTo": peerUser.userId,
      "UserIdFrom": user.userId,
      "content": textEditingController.text,
      "status": 'sent'
    };
    try {
      final response = await dioFirebase.post(
        "/addmessages",
        data: bodyFirebase,
      );
      debugPrint(response.data.toString());
      setState(() {
        // ChatListView(
        //   scrollController: scrollController,
        //   peerUser: widget.user, //nay la user 2
        //   currentUser: user, // nay la user
        // );
        // context.read<ChatCubit>().renderChatMessage(widget.peerUser.userId);
        textEditingController.text = '';
      });
    } catch (e) {}
  }
}
