import 'Widget/ChatListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ChatSession extends StatefulWidget {
  const ChatSession({super.key});

  @override
  State<ChatSession> createState() => _ChatSessionState();
}

class _ChatSessionState extends State<ChatSession> {

  TextEditingController textEditingController = TextEditingController();
  late String senderMessage, receiverMessage;
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 242, 37, 105),
        leadingWidth: 50.0,
        titleSpacing: -8.0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blueAccent,
            child: Text('Q',
                style: TextStyle(
                  color: Colors.black,
                )),
          ),
        ),
        title: const ListTile(
          title: Text('Quân Nguyễn',
              style: TextStyle(
                color: Colors.white,
              )),
          subtitle: Text('crosssuck',
              style: TextStyle(
                color: Colors.white70,
              )),
        ),
        actions: const [
          Icon(Icons.videocam),
          Padding(
            padding: EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(Icons.call),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: ChatListView(scrollController: scrollController)),
          Container(
            // height: 50,
            margin: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
                shape: BoxShape.rectangle,
                color: Color(0xFF333D56),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 12.0),
                  child: Transform.rotate(
                      angle: 0,
                      child: const Icon(
                        Icons.emoji_emotions,
                        color: Colors.white,
                      )),
                ),
                Expanded(
                  child: TextFormField(
                    controller: textEditingController,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.multiline,
                    minLines: 1,
                    maxLines: 6,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin:
                  const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 11.0),
                  child: Transform.rotate(
                    angle: -3.14 / 5,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: GestureDetector(
                        onTap: () {
                         
                        },
                        onLongPress: () {
                          
                        },
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }    

}