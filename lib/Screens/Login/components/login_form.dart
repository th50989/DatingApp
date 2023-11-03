
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:believeder_app/constant/font_constant.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../Signup/signup_screen.dart';

//Import url form Values/value.dart
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
                          description: const Text("Login success !"))
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
                    style: const TextStyle(color: Colors.white),
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
