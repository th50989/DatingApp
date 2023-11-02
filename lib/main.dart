import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
              Future.delayed(Duration(seconds: 1), () {
                //delay de hien thong bao dang nhap thanh cong
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                    return HomePage(); // Widget của màn hình mới bạn muốn hiển thị.
                  }),
                  (Route<dynamic> route) =>
                      false, // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
                );
              });
            }
          },
          child: const WelcomeScreen(),
        ));
  }
}
