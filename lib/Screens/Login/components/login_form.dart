import 'dart:io';

import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';
import 'package:dio/dio.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpUrl = "http://localhost:5214/";
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    Future<void> sendSignInRequest() async {
      var options = BaseOptions(
        baseUrl: signUpUrl,
        method: 'POST',
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 60),
      );
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

      print(response.data);
      if (response.statusCode == HttpStatus.ok) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Post created successfully!"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Failed to create post!"),
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
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
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
              decoration: InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(defaultPadding),
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
                    return SignUpScreen();
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
