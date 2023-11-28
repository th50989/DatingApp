import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Profile/CreateNewUser.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../components/background.dart';
import '../../responsive.dart';
import 'components/login_signup_btn.dart';
import 'components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
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
                return const NewUserPage(); // Widget của màn hình mới bạn muốn hiển thị.
              }),
              // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
            );
          });
        } else if (state is LogoutSuccess) {
          Future.delayed(const Duration(seconds: 1), () {
            //delay de hien thong bao dang nhap thanh cong
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return const WelcomeScreen(); // Widget của màn hình mới bạn muốn hiển thị.
              }),
              // Điều kiện để loại bỏ màn hình hiện tại khỏi ngăn xếp.
            );
          });
        }
      },
      child: Background(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Responsive(
              desktop: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: WelcomeImage(),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 450,
                          child: LoginAndSignupBtn(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              mobile: MobileWelcomeScreen(),
            ),
          ),
        ),
      ),
    );
  }
}

class MobileWelcomeScreen extends StatelessWidget {
  const MobileWelcomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        WelcomeImage(),
        Row(
          children: [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginAndSignupBtn(),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
