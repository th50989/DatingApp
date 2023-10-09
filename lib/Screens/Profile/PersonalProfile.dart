import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:believeder_app/Screens/Profile/Widgets/InfoTextBox.dart';

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.pinkAccent,
              Colors.white70,
            ]
          ),
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
                    "/assets/images/usercard.jpg",
                    scale: 100.0,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Nguyeenx Cao Thangws",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 25.0,
                  ),
                  child: Text(
                    'My Details',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0
                    ),
                  ),
                ),
                infoTextBox(
                  text: "Nguyeenx Cao Thangws", 
                  sectionName: 'Username'
                ),
                infoTextBox(
                  text: "21", 
                  sectionName: 'Age'
                ),
                infoTextBox(
                  text: "Oi dan ba, Woman bu yi yang", 
                  sectionName: 'Description'
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}