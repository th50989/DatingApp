import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:believeder_app/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:believeder_app/constant/url_constant.dart';
import 'package:believeder_app/constant/colors_constant.dart';
import 'package:believeder_app/Screens/HomePage/HomePage.dart';
import 'package:believeder_app/Screens/Login/cubit/cubit/login_cubit.dart';


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

  String _selectedGender = "None"; // Default selection
  List<String> _genderOptions = ['Male', 'Female', 'Email']; // Gender Picker
  DateTime dateTime = DateTime.now();

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
                      kPrimaryColor,
                      kPrimaryLightColor,
                    ]),
              ),
              height: MediaQuery.sizeOf(context).height,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 25.0,
                      right: 25.0,
                    ),
                    child: Center(
                      child: Container(
                        height: MediaQuery.sizeOf(context).height / 1.22,                      
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: ListView(
                                padding: EdgeInsets.only(
                                  top: 15.0
                                ),
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
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kPrimaryColor
                                          )
                                        ),
                                        filled: true,
                                        labelText: 'Last Name',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextField(
                                      controller: fName,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kPrimaryColor
                                          )
                                        ),
                                        filled: true,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 7.0,
                                          right: 5.0,
                                        ),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width / 2.5,
                                          height: MediaQuery.sizeOf(context).width / 6.5,
                                          child: CupertinoButton.filled(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  'Gender : $_selectedGender',
                                                ),
                                              ),
                                            ),
                                            onPressed: () => showCupertinoModalPopup(
                                              context: context, 
                                              builder: (_) => SizedBox(
                                                width: double.infinity,
                                                height: 250,
                                                child: CupertinoPicker(
                                                  backgroundColor: Colors.white,
                                                  itemExtent: 30,
                                                  scrollController: FixedExtentScrollController(
                                                    initialItem: _genderOptions.indexOf(_selectedGender),
                                                  ),
                                                  children: _genderOptions.map((gender) => Text(gender)).toList(),
                                                  onSelectedItemChanged: (int index) {
                                                    setState(() {
                                                      _selectedGender = _genderOptions[index];
                                                      Gender.text = _selectedGender;
                                                    });
                                                  },
                                                ),
                                              )),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          right: 7.0,
                                        ),
                                        child: Container(
                                          width: MediaQuery.sizeOf(context).width / 2.5,
                                          height: MediaQuery.sizeOf(context).width / 6.5,
                                          child: CupertinoButton.filled(
                                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 5.0,
                                                ),
                                                child: Text(
                                                  'Birthday : ${dateTime.day}-${dateTime.month}-${dateTime.year}',
                                                ),
                                              ),
                                            ),
                                            onPressed: () => showCupertinoModalPopup(
                                              context: context, 
                                              builder: (BuildContext context) => SizedBox(
                                                width: double.infinity,
                                                height: 250,
                                                child: CupertinoDatePicker(
                                                  backgroundColor: Colors.white,
                                                  initialDateTime: dateTime,
                                                  onDateTimeChanged: (DateTime newTime) {
                                                    setState(() 
                                                      {
                                                        dateTime = newTime;
                                                        bDay.text =
                                                            '${dateTime.day}-${dateTime.month}-${dateTime.year}';
                                                      }     
                                                    );
                                                  },
                                                  use24hFormat: true,
                                                  mode: CupertinoDatePickerMode.date,
                                                ),
                                              )),
                                          ),
                                        ),
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
                                      controller: location,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'location',
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 10.0,
                                    ),
                                    child: ElevatedButton(
                                      style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll<Color>(
                                                kPrimaryColor
                                        ),
                                      ),
                                      onPressed: () {
                                        var body = {
                                          "accountId": state.AccountId,
                                          "lastName": lName.text,
                                          "firstName": fName.text,
                                          "gender": Gender.text,
                                          "birthday": "2023-11-06T08:35:15.615Z",
                                          "location": location.text
                                        };
                                        context.read<LoginCubit>().createUser(body);
                                      },
                                      child: const Text(
                                        'Create User',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
