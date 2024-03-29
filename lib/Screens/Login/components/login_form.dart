import 'package:flutter/material.dart';
import '../../Signup/signup_screen.dart';
import '../cubit/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:believeder_app/constant/font_constant.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:elegant_notification/elegant_notification.dart';
import '../../../components/already_have_an_account_acheck.dart';

//Import url form Values/value.dart

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: SingleChildScrollView(
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
                if (state is LoginFailed) {
                  Future.delayed(Duration.zero, () async {
                    ElegantNotification.error(
                            background: kPrimaryLightColor,
                            height: 70,
                            notificationPosition:
                                NotificationPosition.topCenter,
                            animation: AnimationType.fromTop,
                            title: const Text('Login Failed!'),
                            toastDuration: const Duration(milliseconds: 2000),
                            description: Text(state.error))
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
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      ),
    );
  }
}
