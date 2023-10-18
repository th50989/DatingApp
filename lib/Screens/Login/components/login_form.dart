import 'dart:convert';
import 'dart:io';

import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:dio/dio.dart';

//Import url form Values/value.dart
import '../../../Values/values.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    //Xử lý chuyển trang
    void navigateToProfilePage(Response response) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PersonalProfilePage(
                  currentUser:
                      // User.fromJson(jsonDecode(response.data.toString())))),
                      User(
                          '${response.data['lastName']}', //cai nay phai la age nay, server chua co age
                          '${response.data['firstName']}',
                          '${response.data['lastName']}',
                          '${response.data['birthday']}',
                          '${response.data['gender']}',
                          '${response.data['location']}',
                          '${response.data['accessToken']}',
                          '${response.data['bio']}',
                          '${response.data['ImageURL']}'))));
    }

    //Xử lý đăng nhập gọi api
    Future<void> sendSignInRequest() async {
      var options = BaseOptions(
        baseUrl: Value.baseUrl,
        method: 'POST',
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 60),
      );
      // debugPrint(Value.baseUrl.toString());
      // debugPrint(emailController.text);
      // debugPrint(passwordController.text);
      Response response;
      var dio = Dio(options);
      try {
        response = await dio.post('api/Users/login', data: {
          "email": emailController.text,
          "password": passwordController.text,
        });
      } catch (e) {
        throw (e.toString());
      }

      debugPrint(response.data.toString());
      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đăng nhập thành công"),
        ));

        //Xử lý đăng nhập xong thì navigate
        navigateToProfilePage(response);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Có lỗi xảy ra trong quá trình đăng nhập"),
        ));
      }
      //xu ly them hoat anh , hieu ung khi dang nhap dang ky thanh cong hoac dell thanh cong
    }

    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () {
                sendSignInRequest();
                print("da bam nut dang nhap");
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
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
