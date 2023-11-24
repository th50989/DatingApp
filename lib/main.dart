import 'package:believeder_app/Screens/ChatSession/FriendList.dart';
import 'package:believeder_app/Screens/ChatSession/cubit/chat_cubit.dart';
import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/HomePage/cubit/card_cubit.dart';
import 'package:believeder_app/Screens/Login/components/login_form.dart';

import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Profile/CreateNewUser.dart';
import 'package:believeder_app/api_chat/firebase_api.dart';
import 'package:believeder_app/firebase_options.dart';

import 'package:believeder_app/repositories/UserRepo.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/colors_constant.dart';
import 'constant/font_constant.dart';

final navigatorKey = GlobalKey<NavigatorState>();
// void main() => runApp(const App());
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseApi().initNotifications();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginCubit>(
        lazy: false,
        create: (context) => LoginCubit(UserRepo()),
      ),
      BlocProvider<CardCubit>(
        lazy: false,
        create: (context) => CardCubit(),
      ),
      BlocProvider<ChatCubit>(lazy: false, create: (context) => ChatCubit())
    ], child: const MyApp()); //cai nay de phan phoi cubit cho toan app
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<LoginCubit>().isLogged();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //2 cai nay dang duoc su dung de navigate bang notification
        navigatorKey: navigatorKey,
        routes: {'/chat_list_screen': (context) => FriendChatList()},
        //
        debugShowCheckedModeBanner: false,
        title: 'BelieveDer App',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: kPrimaryColor,
                shape: const StadiumBorder(),
                maximumSize: const Size(double.infinity, 56),
                minimumSize: const Size(double.infinity, 56),
              ),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              iconColor: kPrimaryColor,
              prefixIconColor: kPrimaryColor,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: defaultPadding, vertical: defaultPadding),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                borderSide: BorderSide.none,
              ),
            )),
        home: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Future.delayed(Duration.zero, () async {
                ElegantNotification.success(
                        background: kPrimaryLightColor,
                        height: 50,
                        notificationPosition: NotificationPosition.topCenter,
                        animation: AnimationType.fromTop,
                        toastDuration: const Duration(milliseconds: 2000),
                        description: const Text("Login success !"))
                    .show(context);
              });
              Future.delayed(const Duration(milliseconds: 500), () {
                //delay de hien thong bao dang nhap thanh cong
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return const HomePage(); // Widget của màn hình mới bạn muốn hiển thị.
                  }),
                  (Route<dynamic> route) =>
                      false, // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
                );
              });
            } else if (state is NewUser) {
              Future.delayed(const Duration(seconds: 1), () {
                //delay de hien thong bao dang nhap thanh cong
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const NewUserPage(); // Widget của màn hình mới bạn muốn hiển thị.
                  }),
                  // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
                );
              });
            } else if (state is LogoutSuccess) {
              Future.delayed(const Duration(seconds: 1), () {
                //delay de hien thong bao dang nhap thanh cong
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return const WelcomeScreen(); // Widget của màn hình mới bạn muốn hiển thị.
                  }),
                  // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
                );
              });
            }
          },
          child: const WelcomeScreen(),
        ));
  }
}
