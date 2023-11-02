import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';
import 'package:believeder_app/Screens/Welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:believeder_app/Screens/Profile/Widgets/InfoTextBox.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key});

  @override
  State<PersonalProfilePage> createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.pinkAccent,
                Colors.white70,
              ]),
        ),
        height: 1000.0,
        child: BlocBuilder<LoginCubit, LoginState>(
          builder: (context, state) {
            if (state is LoginSuccess) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: [
                      const SizedBox(
                        height: 50.0,
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          state.user.imgUrl,
                          scale: 100.0,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        state.user.lastName,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w300),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 25.0,
                        ),
                        child: Text(
                          'My Details',
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                        ),
                      ),
                      infoTextBox(text: state.user.bio, sectionName: 'Bio'),
                      infoTextBox(
                          text: state.user.lastName, sectionName: 'Last Name'),
                      infoTextBox(
                          text: state.user.firstName,
                          sectionName: 'First Name'),
                      infoTextBox(
                          text: state.user.birthDay, sectionName: 'Birthday'),
                      infoTextBox(
                          text: state.user.gender, sectionName: 'Gender'),
                      infoTextBox(
                          text: state.user.location, sectionName: 'Location'),
                      infoTextBox(
                          text: state.user.age.toString(), sectionName: 'Age'),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                                style: TextStyle(color: Colors.white),
                                'go back')),
                      )
                    ],
                  ),
                ],
              );
            } else {
              return const WelcomeScreen();
            }
          },
        ),
      ),
    );
  }
}
