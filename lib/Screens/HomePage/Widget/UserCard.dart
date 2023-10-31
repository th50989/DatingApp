import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.pinkAccent.withOpacity(0.5), // Màu hồng nhạt
            Colors.white, // Màu trắng
          ],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.5,
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
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
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
                      height: MediaQuery.of(context).size.height / 2.0,
                    ), // Khoảng cách từ đỉnh Container xuống dưới
                    Padding(
                      padding: EdgeInsets.only(left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Text(
                        'Duy Quân, 20',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 10), // Khoảng cách giữa các dòng
                    Padding(
                      padding: EdgeInsets.only(left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Text(
                        'Những thằng khác ngại tán em, tại ngán anh.',
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
      ),
    );
  }
}