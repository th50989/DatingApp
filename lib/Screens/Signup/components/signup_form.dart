import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../Login/login_screen.dart';
import '../../../constant/font_constant.dart';
import '../../../constant/colors_constant.dart';
import 'package:believeder_app/constant/url_constant.dart';
import '../../../components/already_have_an_account_acheck.dart';
//import 'dart:convert';

// import 'package:http/http.dart' as http;


class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    Future<void> sendSignUpRequest() async {
      Response response;
      var options = BaseOptions(
          contentType: 'application/json',
          method: 'POST',
          baseUrl: base_url,
          validateStatus: (status) {
            return status! < 500; // Accept all status codes below 500
          });
      var dio = Dio(options);
      response = await dio.post('api/Authentication/register', data: {
        "email": emailController.text,
        "password": passwordController.text,
        "confirmPassword": confirmPasswordController.text,
      });
      //Ham nay se xu ly token nhung de sau di
      // Future<void> sendVerifiedRequest() async {
      //   String userVerifyToken = '';
      // }

      //Navigation

      debugPrint(response.data.toString());
      //Post data
      if (response.statusCode == HttpStatus.ok) {
        // sendVerifiedRequest();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đăng ký thành công"),
        ));
        Future.delayed(const Duration(seconds: 2));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Đăng ký thất bại do có lỗi đã xảy ra"),
        ));
      }
    }

    // Future<void> sendSignUpRequest() async {
    //   var response = await http.post(Uri.parse(signUpUrl),
    //       headers: {"Content-Type": "application/json"},
    //       body: jsonEncode({
    //         "email": emailController.text,
    //         "password": passwordController.text,
    //         "confirmPassword": confirmPasswordController.text,
    //       }));
    //   print(response.body);
    //   if (response.statusCode == 201) {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Post created successfully!"),
    //     ));
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //       content: Text("Failed to create post!"),
    //     ));
    //   }
    // }
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
              textInputAction: TextInputAction.next,
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
          TextFormField(
            obscureText: true,
            controller: confirmPasswordController,
            // keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Confirm password",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.lock),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () {
              sendSignUpRequest();
              print("da bam nut sign up");
            },
            child: Text(
              "Sign Up".toUpperCase(),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
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
