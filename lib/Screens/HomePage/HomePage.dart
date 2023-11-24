import 'dart:math';
import 'package:believeder_app/Screens/HomePage/cubit/card_cubit.dart';
import 'package:flutter/material.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:believeder_app/Screens/ChatSession/FriendList.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:believeder_app/Screens/HomePage/Widget/UserCard.dart';
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
  //Thằng Tâm handle cái xáo trộn người dùng UserCard nha t đang xài
  //Raw trong cardProvider á, hiện tại nó đang đi theo danh sách từ trên xuống
  //m shuffle nó đi random thẻ là đc

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
          return Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top +
                      16.0, // Lấy padding trên cùng của màn hình
                  left: 20.0,
                  right: 20.0,
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
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                // width: MediaQuery.of(context).size.width / 0.9,
                child: Column(
                  children: [
                    Flexible(
                      child: CardSwiper(
                          controller: controller,
                          cardsCount: shuffledCards.length,
                          onSwipe: _onSwipe,
                          onUndo: _onUndo,
                          onEnd: () async {
                            print('End list');
                            BlocProvider.of<CardCubit>(context).getRandomUser();
                          },
                          allowedSwipeDirection:
                              AllowedSwipeDirection.symmetric(horizontal: true),
                          numberOfCardsDisplayed: 3,
                          backCardOffset: const Offset(10, 35),
                          padding: const EdgeInsets.all(24.0),
                          cardBuilder: (
                            context,
                            index,
                            horizontalThresholdPercentage,
                            verticalThresholdPercentage,
                          ) =>
                              shuffledCards[index]),
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
                              context.read<LoginCubit>().logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const MyApp()),
                                (route) => false,
                              );
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
                              controller.swipeLeft();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  bool _onSwipe(
    int previousIndex,
    int? currentIndex,
    CardSwiperDirection direction,
  ) {
    debugPrint(
      'Bạn vừa quẹt người dùng $currentIndex sang ${direction.name} bạn đã yêu / sẽ gầy hoặc ghét với người đó',
    );
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
