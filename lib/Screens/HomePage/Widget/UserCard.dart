import 'package:flutter/material.dart';

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
                  image: const DecorationImage(
                      image: AssetImage("assets/images/usercard.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  gradient: const LinearGradient(
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
                      padding: const EdgeInsets.only(
                          left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Text(
                        'Thắng Nguyễn, 21',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Colors.white,
                            ),
                      ),
                    ),
                    const SizedBox(height: 10), // Khoảng cách giữa các dòng
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 20), // Tạo khoảng cách lề trái 20 đơn vị
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
