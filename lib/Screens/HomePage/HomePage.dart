import 'package:believeder_app/Screens/ChatSession/FriendList.dart';

import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';

import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:believeder_app/Screens/Welcome/components/welcome_image.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter/material.dart';
import 'package:believeder_app/Screens/HomePage/Widget/UserCard.dart';
import 'package:believeder_app/Screens/HomePage/Widget/ChoiceButton.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const CrossButton = SnackBar(
        content: Text(
      "Bạn đã dislike người dùng này",
    ));
    const LikeButton = SnackBar(
        content: Text(
      "Bạn đã like người dùng này",
    ));
    const PendingButton = SnackBar(
        duration: Duration(milliseconds: 1000),
        content: Text(
          "Bạn đã tạm thời lướt qua người dùng này",
        ));

    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top +
                  16.0, // Lấy padding trên cùng của màn hình
              left: 24.0,
              right: 24.0,
              bottom: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.pinkAccent.withOpacity(0.5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return const PersonalProfilePage();
                    }));
                  },
                  child: Container(
                    height: 20,
                    width: 20,
                    child: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Text(
                  "F O R   Y O U",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Proxima Nova Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return FriendChatList();
                      }));
                    },
                    child: Container(
                        height: 20, width: 20, child: Icon(Icons.chat))),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      const UserCard(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 60,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ChoiceButton(
                              width: 60,
                              height: 60,
                              size: 25,
                              icon: Icons.clear_rounded,
                              onPressed: () {
                                context.read<LoginCubit>().logout();
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => const MyApp()),
                                    (route) => false);
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(CrossButton);
                              },
                              color: Colors.red,
                            ),
                            ChoiceButton(
                                width: 80,
                                height: 80,
                                size: 30,
                                icon: Icons.favorite,
                                color: Colors.red,
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(LikeButton);
                                }),
                            ChoiceButton(
                                width: 60,
                                height: 60,
                                size: 25,
                                icon: Icons.watch_later,
                                color: Colors.red,
                                onPressed: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(PendingButton);
                                })
                          ],
                        ),
                      ),
                    ],
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
