import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';

import 'package:believeder_app/constant/url_constant.dart';
import 'package:believeder_app/main.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});
  @override
  State<NewUserPage> createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController bDay = TextEditingController();
  TextEditingController Gender = TextEditingController();
  //User chua co truong bio
  //TextEditingController Bio = TextEditingController();
  TextEditingController location = TextEditingController();

  String selectedGender = "Male"; // Default selection

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        if (state is NewUser) {
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
              child: Stack(
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ListView(
                          children: [
                            const CircleAvatar(
                              radius: 50,
                              backgroundImage: NetworkImage(
                                '',
                                scale: 100.0,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: lName,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Last Name',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: fName,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'First Name',
                                ),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: TextField(
                            //     controller: Gender,
                            //     decoration: const InputDecoration(
                            //       border: OutlineInputBorder(),
                            //       labelText: 'Gender',
                            //     ),
                            //   ),
                            // ),
                            Column(
                              children: <Widget>[
                                RadioListTile(
                                  title: const Text("Male"),
                                  value: "male",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value as String;
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: const Text("Female"),
                                  value: "female",
                                  groupValue: selectedGender,
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value as String;
                                    });
                                  },
                                ),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.all(8.0),
                            //   child: TextField(
                            //     controller: Bio,
                            //     decoration: const InputDecoration(
                            //       border: OutlineInputBorder(),
                            //       labelText: 'Bio',
                            //     ),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: bDay,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Birthday',
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextField(
                                controller: location,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'location',
                                ),
                              ),
                            ),
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          Colors.pinkAccent),
                                ),
                                onPressed: () {
                                  var body = {
                                    "accountId": state.AccountId,
                                    "lastName": lName.text,
                                    "firstName": fName.text,
                                    "gender": selectedGender,
                                    "birthday": "2023-11-06T08:35:15.615Z",
                                    "location": location.text
                                  };
                                  context.read<LoginCubit>().createUser(body);
                                },
                                child: const Text(
                                  'Create User',
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else if (state is LoginSuccess) {
          return const HomePage();
        }
        return const MyApp();
      },
    );
  }
}
