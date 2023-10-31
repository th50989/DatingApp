import 'package:believeder_app/Models/models.dart';
import 'package:flutter/material.dart';

import 'package:believeder_app/Screens/Profile/Widgets/InfoTextBox.dart';

class PersonalProfilePage extends StatefulWidget {
  const PersonalProfilePage({super.key, required this.currentUser});
  final User currentUser;
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
        child: Stack(
          children: <Widget>[
            ListView(
              children: [
                const SizedBox(
                  height: 50.0,
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    widget.currentUser.imgUrl,
                    scale: 100.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "${widget.currentUser.lastName}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 25.0,
                  ),
                  child: Text(
                    'My Details',
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
                infoTextBox(
                    text: "${widget.currentUser.bio}", sectionName: 'Bio'),
                infoTextBox(
                    text: "${widget.currentUser.lastName}",
                    sectionName: 'Last Name'),
                infoTextBox(
                    text: "${widget.currentUser.firstName}",
                    sectionName: 'First Name'),
                infoTextBox(
                    text: "${widget.currentUser.birthDay}",
                    sectionName: 'Birthday'),
                infoTextBox(
                    text: "${widget.currentUser.gender}",
                    sectionName: 'Gender'),
                infoTextBox(
                    text: "${widget.currentUser.location}",
                    sectionName: 'Location'),
                infoTextBox(text: "21", sectionName: 'Age'),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                          style: TextStyle(color: Colors.white), 'go back')),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
