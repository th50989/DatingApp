import 'dart:math';
import 'package:flutter/material.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:believeder_app/Screens/ChatSession/FriendList.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:believeder_app/Screens/HomePage/Widget/UserCard.dart';
import 'package:believeder_app/Screens/HomePage/cubit/card_cubit.dart';
import 'package:believeder_app/Screens/HomePage/Widget/ChoiceButton.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Welcome/components/welcome_image.dart';
import 'package:believeder_app/Screens/HomePage/Widget/CardProvider/CardProvider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CardCubit>(context).getRandomUser();
  }

  final CardSwiperController controller = CardSwiperController();

  late List<UserCard> shuffledCards;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CardCubit, CardState>(
        builder: (context, state) {
          if (state is CardSuccess) {
            shuffledCards =
                state.userInfoList.map((user) => UserCard(user)).toList();
          } else if (state is CardInitial) {
            return Center(
              child: Transform.scale(
                scale: 1,
                child: const CircularProgressIndicator(),
              ),
            );
          } else {
            shuffledCards = [];
          }
          return Column(children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    16.0, // Lấy padding trên cùng của màn hình
                left: 20.0,
                right: 20.0,
                bottom: 16.0,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(111, 53, 165, 1),
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
                      height: 60,
                      width: 60,
                      child: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Text(
                    "F O R   Y O U",
                    style: TextStyle(
                      color: Colors.white,
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
                          height: 60,
                          width: 60,
                          child: Icon(
                            Icons.chat,
                            color: Colors.white,
                          ))),
                ],
              ),
            ),
            Expanded(
                // height: MediaQuery.of(context).size.height / 1.2,
                // width: MediaQuery.of(context).size.width / 0.9,

                child: shuffledCards.length < 1
                    ? Center(
                        child: Text('Run out of user'),
                      )
                    : Column(
                        children: [
                          Flexible(
                            child: CardSwiper(
                                controller: controller,
                                cardsCount: shuffledCards.length,
                                onSwipe: _onSwipe,
                                onUndo: _onUndo,
                                onEnd: () async {
                                  print('End list');
                                  BlocProvider.of<CardCubit>(context)
                                      .getRandomUser();
                                },
                                allowedSwipeDirection:
                                    AllowedSwipeDirection.symmetric(
                                        horizontal: true),
                                numberOfCardsDisplayed: 1,
                                backCardOffset: const Offset(10, 35),
                                padding: const EdgeInsets.all(24.0),
                                cardBuilder: (
                                  context,
                                  index,
                                  horizontalThresholdPercentage,
                                  verticalThresholdPercentage,
                                ) {
                                  bool shouldShowText =
                                      horizontalThresholdPercentage.abs() >=
                                          30; // Hành trình quẹt
                                  bool isLike =
                                      horizontalThresholdPercentage > 0;
                                  return Stack(
                                    children: [
                                      shuffledCards[index],
                                      // Hiển thị chữ "Like" khi quẹt phải
                                      if (shouldShowText)
                                        Positioned(
                                          top: 0,
                                          right: isLike
                                              ? 2
                                              : null, // Nếu là "Like" thì hiển thị bên phải, ngược lại hiển thị bên trái
                                          left: isLike
                                              ? null
                                              : 2, // Nếu là "Dislike" thì hiển thị bên trái, ngược lại hiển thị bên phải
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.4,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              color: isLike
                                                  ? Colors.lightGreen
                                                  : Colors.redAccent,
                                            ),
                                            child: Center(
                                              child: Text(
                                                isLike
                                                    ? 'L I K E'
                                                    : 'D I S L I K E',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  );
                                }),
                          ),
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
                                    controller.swipeLeft();
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
                                    controller.swipeRight();
                                  },
                                ),
                                ChoiceButton(
                                  width: 60,
                                  height: 60,
                                  size: 25,
                                  icon: Icons.watch_later,
                                  color: Colors.red,
                                  onPressed: () {
                                    controller.undo();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ))
          ]);
        },
      ),
    );
  }

  Future<bool> _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) async {
    if (direction.name == 'right') {
      var userId = shuffledCards[currentIndex!].userInfo.userId;
      print(userId);
      await BlocProvider.of<CardCubit>(context).addFavorite(userId);
    } else if (direction.name == 'left') {
      print('Ban eo thich nguoi nay');
    }
    return true;
  }

  bool _onUndo(
    int? previousIndex,
    int currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'The card $currentIndex was undod from the ${direction.name}',
    );
    return true;
  }
}
