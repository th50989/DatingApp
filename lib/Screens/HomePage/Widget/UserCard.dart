import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/usercard.jpg"
                  ),
                  fit: BoxFit.cover
                ),
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: Offset(3, 3)
                  )
                ]
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                  ), // Khoảng cách từ đỉnh Container xuống dưới
                  Padding(
                    padding: EdgeInsets.only(left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                    child: Text(
                      'Duy Quân 20',
                      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Khoảng cách giữa các dòng
                  Padding(
                    padding: EdgeInsets.only(left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                    child: Text(
                      'Anh là dân IT, anh có một phần mềm em đụng vô thành phần cứng, em có muốn thử không ?',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}