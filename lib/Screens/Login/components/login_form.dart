import 'dart:convert';
import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Profile/CreateNewUser.dart';
import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:believeder_app/constant/font_constant.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../Signup/signup_screen.dart';
import 'package:dio/dio.dart';

//Import url form Values/value.dart
import '../../../Values/values.dart';
import '../cubit/cubit/login_cubit.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    // //Xử lý chuyển trang
    // void navigateToProfilePage(Response response) {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (context) => PersonalProfilePage(currentUser: User()
    //               // User.fromJson(jsonDecode(response.data.toString())))),
    //               )));
    // }

    // _navigateToCreateNewUserPage() {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const NewUserPage()),
    //   );
    // }

    // //Xử lý đăng nhập gọi api
    // Future<void> sendSignInRequest() async {
    //   // debugPrint(Value.baseUrl.toString());
    //   // debugPrint(emailController.text);
    //   // debugPrint(passwordController.text);
    //   Response response;
    //   var dio = Dio(options);

    //   response = await dio.post('api/Users/login', data: {
    //     "email": emailController.text,
    //     "password": passwordController.text,
    //   });

    //   debugPrint(response.data.toString());
    //   debugPrint(response.statusCode.toString());
    //   if (response.statusCode == HttpStatus.ok) {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Đăng nhập thành công"),
    //     ));
    //     navigateToProfilePage(response);
    //     if (response.statusCode == 400) {
    //       //Neu user chua duoc tao thi navigate vao trang tao user
    //       _navigateToCreateNewUserPage();
    //     }
    //     //Xử lý đăng nhập xong thì navigate, neu user da tao roi thi navigate qua home page
    //     //  navigateToProfilePage(response);
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //       content: Text("Có lỗi xảy ra trong quá trình đăng nhập"),
    //     ));
    //   }
    //   //xu ly them hoat anh , hieu ung khi dang nhap dang ky thanh cong hoac dell thanh cong
    // }

    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            title: Container(
              child: const Text(
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  'Dit me cai giao dien cua thang thang la cai loi chu dell phai cubit loi'),
            ),
          ),
          const SizedBox(height: defaultPadding),
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return Hero(
                  tag: "login_btn",
                  child: ElevatedButton(
                      onPressed: null,
                      child: Transform.scale(
                          scale: 1,
                          child: const Center(
                              child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          )))),
                );
              }
              if (state is LoginSuccess) {
                Future.delayed(Duration.zero, () async {
                  ElegantNotification.success(
                          background: kPrimaryLightColor,
                          height: 50,
                          notificationPosition: NotificationPosition.topCenter,
                          animation: AnimationType.fromTop,
                          toastDuration: const Duration(milliseconds: 1500),
                          description: Text("Login success !"))
                      .show(context);
                });
              }

              return Hero(
                tag: "login_btn",
                child: ElevatedButton(
                  onPressed: () {
                    print(emailController.text);
                    print(passwordController.text);
                    context
                        .read<LoginCubit>()
                        .login(emailController.text, passwordController.text);
                    print("da bam nut dang nhap");
                  },
                  child: Text(
                    style: TextStyle(color: Colors.white),
                    "Login".toUpperCase(),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SignUpScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),

    );
  }
}
