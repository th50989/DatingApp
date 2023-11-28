import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:believeder_app/Screens/ChatSession/Chat.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';

class FriendChatList extends StatefulWidget {
  FriendChatList({super.key});
  late Future<List<User2>> matchedUser;
  @override
  State<FriendChatList> createState() => _FriendChatListState();
}

class _FriendChatListState extends State<FriendChatList> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // context.read<LoginCubit>().fetchMatchedUser();
  }

  Future<List<User2>> fetchMatchedUser(accessToken) async {
    var options = BaseOptions(
        contentType: 'application/json',
        method: 'GET',
        baseUrl: base_url,
        validateStatus: ((status) => status != null && status < 500));
    final Dio dio = Dio(options);
    dio.options.headers['Authorization'] = 'Bearer $accessToken';

    final response = await dio.get(
      "api/Users/matched-users-with-latest-message",
    );
    // debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      // Parse the response data and convert it into a list of User2 objects
      List<dynamic> responseData = response.data;
      // List<dynamic> test =
      //     responseData.map((userJson) => User2.fromJson(userJson)).toList();
      // test.forEach((element) {
      //   debugPrint(element.toString());
      // });
      return responseData.map((userJson) => User2.fromJson(userJson)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      backgroundColor: kPrimaryColor,
      body: BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
        if (state is LoginSuccess) {
          widget.matchedUser = fetchMatchedUser(state.user.accessToken);
          // debugPrint(widget.matchedUser.then.toString());
          return FutureBuilder(
              future: widget.matchedUser,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final matchedUsers = snapshot.data;
                  return Stack(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 70, left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                const Text(
                                  "Chat",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 130,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 15, left: 25, right: 25),
                          height: 220,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 239, 99, 145),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                kPrimaryColor,
                                Colors.white70,
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Recently contacts",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 100,
                                child: ListView.builder(
                                  itemCount: matchedUsers?.length,
                                  itemBuilder: (context, index) {
                                    final User2? user = matchedUsers?[index];
                                    return buildContactAvatar(
                                        user!.firstName.toString(), '');
                                  },
                                  scrollDirection: Axis.horizontal,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          top: 300,
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(40),
                                  topRight: Radius.circular(40)),
                              color: Color(0xFFEFFFFC),
                            ),
                            child: ListView.builder(
                              itemCount: matchedUsers?.length,
                              itemBuilder: (context, index) {
                                // Sort matchedUsers based on latestMessageTimeSent
                                matchedUsers?.sort((a, b) {
                                  DateTime timeA = DateTime.tryParse(
                                          a!.latestMessageTimeSent) ??
                                      DateTime.now();
                                  DateTime timeB = DateTime.tryParse(
                                          b!.latestMessageTimeSent) ??
                                      DateTime.now();
                                  return timeB.compareTo(
                                      timeA); // Compare in descending order
                                });
                                final user = matchedUsers?[index];
                                String datetimeStr =
                                    user!.latestMessageTimeSent;
                                try {
                                  DateTime dateTime =
                                      DateTime.parse(datetimeStr);
                                  String formattedTime =
                                      DateFormat('HH:mm').format(dateTime);
                                  user.latestMessageTimeSent = formattedTime;
                                } catch (e) {}

                                return buildConversationRow(
                                    user!, 1, state.user.userId);
                              },
                              padding: const EdgeInsets.only(left: 25),
                            ),
                          ))
                    ],
                  );
                }
              });
        } else {
          return const CircularProgressIndicator();
        }
      }),
    );
  }

  Column buildConversationRow(User2 user, msgCount, int CurrentUserid) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (context) {
              return ChatSession(
                user: user,
              );
            }));
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(filename: user.imgUrl),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.firstName,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        CurrentUserid == user.latestMessageUserIdFrom
                            ? 'You sent : ${user.latestMessageContent}'
                            : '${user.firstName} sent to you :${user.latestMessageContent} ',
                        // user.latestMessageContent,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 5),
                child: Column(
                  children: [
                    Text(
                      user.latestMessageTimeSent,
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (msgCount > 0)
                      CircleAvatar(
                        radius: 7,
                        backgroundColor: Color.fromARGB(255, 42, 61, 58),
                        child: Text(
                          msgCount.toString(),
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
        const Divider(
          indent: 70,
          height: 20,
        )
      ],
    );
  }

  Padding buildContactAvatar(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          UserAvatar(
            filename: filename,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          )
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.network(filename).image,
      ),
    );
  }
}
