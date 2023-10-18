import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SvgPicture.asset(
                  "assets/icons/applogo.svg",
                  height: 70,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                "BELIEVEDER",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message,
                color: Theme.of(context).primaryColor,
              )),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Theme.of(context).primaryColor,
              ))
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
