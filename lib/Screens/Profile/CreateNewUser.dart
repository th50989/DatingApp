import 'dart:io';

import 'package:believeder_app/Screens/HomePage/HomePage.dart';

import 'package:believeder_app/constant/url_constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key, required this.AccountId});
  final int AccountId;
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

  void _navigateToHomePage() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
  }

  Future<void> sendCreateUserRequest() async {
    Response response;
    var options = BaseOptions(
      baseUrl: base_url,
      method: 'POST',
      contentType: 'application/json',
      connectTimeout: 30000,
    );
    var dio = Dio(options);
    try {
      response = await dio.post('api/Users/create-user', data: {
        "accountId": widget.AccountId.toInt(),
        "lastName": lName.text,
        "firstName": fName.text,
        "gender": selectedGender,
        "birthday": "2023-10-17",
        "location": location.text
      });
    } catch (e) {
      throw (e.toString());
    }

    debugPrint(response.data.toString());
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Tao user thành công"),
      ));
      //tao user thanh cong thi navigate vao homepage
      _navigateToHomePage();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Có lỗi xảy ra trong quá trình tao user"),
      ));
    }
  }

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
                            title: Text("Male"),
                            value: "male",
                            groupValue: selectedGender,
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value as String;
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Female"),
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
                            backgroundColor: MaterialStatePropertyAll<Color>(
                                Colors.pinkAccent),
                          ),
                          onPressed: () {
                            sendCreateUserRequest();
                          },
                          child: const Text(
                            'Create User',
                            style: TextStyle(color: Colors.white),
                          ))
                      // infoTextBox(
                      //     text: "${widget.currentUser.bio}", sectionName: 'Bio'),
                      // infoTextBox(
                      //     text: "${widget.currentUser.lastName}",
                      //     sectionName: 'Last Name'),
                      // infoTextBox(
                      //     text: "${widget.currentUser.firstName}",
                      //     sectionName: 'First Name'),
                      // infoTextBox(
                      //     text: "${widget.currentUser.birthDay}",
                      //     sectionName: 'Birthday'),
                      // infoTextBox(
                      //     text: "${widget.currentUser.gender}",
                      //     sectionName: 'Gender'),
                      // infoTextBox(
                      //     text: "${widget.currentUser.location}",
                      //     sectionName: 'location'),
                      // infoTextBox(text: "21", sectionName: 'Age'),
                      // Padding(
                      //   padding: const EdgeInsets.all(10.0),
                      //   child: ElevatedButton(
                      //       onPressed: () {
                      //         Navigator.pop(context);
                      //       },
                      //       child: Text(
                      //           style: TextStyle(color: Colors.white), 'go back')),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
