import 'dart:convert';
import 'dart:io';

import 'package:believeder_app/Models/models.dart';
import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Profile/CreateNewUser.dart';
import 'package:believeder_app/Screens/Profile/PersonalProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
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
          body: Column(
            children: [
              BlocListener<LoginCubit, LoginState>(listener: (context, state) {
                if (state is LoginSuccessButNoUser) {
                  // User nhập đúng email và mật khẩu nhưng chưa tạo Usser
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đăng nhập thành công vui lòng tạo user"),
                  ));
                  Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const NewUserPage(AccountId: 4),
                  ));
                } else if (state is LoginSuccess) {
                  // User nhập đúng email,mật khẩu và đã tạo User rồi
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đăng nhập thành công"),
                  ));
                  Future.delayed(const Duration(seconds: 2));
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
                } else if (state is LoginFailed) {
                  // Handle a failed login, e.g., show an error message
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Đăng nhập khong thành công"),
                  ));
                }
              }, child: BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                if (state is LoginLoading) {
                  // Show a loading indicator or progress bar
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(),
                      ),
                    ],
                  );
                } else {
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
                          padding: const EdgeInsets.symmetric(
                              vertical: defaultPadding),
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
                              print(emailController.text);
                              print(passwordController.text);
                              context.read<LoginCubit>().login(
                                  emailController.text,
                                  passwordController.text);

                              print("da bam nut dang nhap");
                            },
                            child: Text(
                              style: const TextStyle(color: Colors.white),
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
              }))
            ],
          )),
    );
  }
}
