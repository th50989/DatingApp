import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:believeder_app/Screens/HomePage/Widget/UserCard.dart';
import 'package:believeder_app/Screens/HomePage/Widget/ChoiceButton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 16.0, // Lấy padding trên cùng của màn hình
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
                Container(
                  height: 20,
                  width: 20,
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                ),
                Text(
                  "F O R   Y O U",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: "Proxima Nova Bold",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  child: Icon(
                    Icons.chat,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      UserCard(),
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
                              onPressed: () {},
                              color: Colors.red,
                            ),
                            ChoiceButton(
                              width: 80,
                              height: 80,
                              size: 30,
                              icon: Icons.favorite, 
                              color: Colors.red, 
                              onPressed: () {}
                            ),
                            ChoiceButton(
                              width: 60,
                              height: 60,
                              size: 25,
                              icon: Icons.watch_later, 
                              color: Colors.red, 
                              onPressed: () {}
                            )
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