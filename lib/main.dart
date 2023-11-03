import 'package:believeder_app/Screens/HomePage/HomePage.dart';

import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Profile/CreateNewUser.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';

import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constant/colors_constant.dart';
import 'constant/font_constant.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<LoginCubit>(
        lazy: false,
        create: (context) => LoginCubit(),
      ),
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
                    return NewUserPage(
                      AccountId: state.AccountId,
                    ); // Widget của màn hình mới bạn muốn hiển thị.
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
