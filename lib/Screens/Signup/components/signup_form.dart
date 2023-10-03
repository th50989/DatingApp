import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signUpUrl = "http://localhost:5214/";
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    Future<void> sendSignUpRequest() async {
      var options = BaseOptions(
        baseUrl: signUpUrl,
        method: 'POST',
        contentType: 'application/json',
        connectTimeout: const Duration(seconds: 60),
      );
      Response response;
      var dio = Dio(options);
      try {
        response = await dio.post('api/Users/register', data: {
          "email": emailController.text,
          "password": passwordController.text,
          "confirmPassword": confirmPasswordController.text,
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
              textInputAction: TextInputAction.next,
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
          TextFormField(
            controller: confirmPasswordController,
            // keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Confirm password",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
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
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
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
