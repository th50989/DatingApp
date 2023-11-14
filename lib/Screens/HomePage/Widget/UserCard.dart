import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
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
                  image: const DecorationImage(
                      image: AssetImage("assets/images/usercard.jpg"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(
                    width: 0.5,
                    color: Colors.grey
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white, // Màu của bóng
                      offset: Offset(0, 1), // Độ dịch chuyển ngang và dọc của bóng
                      blurRadius: 8, // Độ mờ của bóng
                      spreadRadius: 5, // Phạm vi của bóng
                    ),
                  ]
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
                              fontWeight: FontWeight.bold
                            ),
                            
                      ),
                    ),
                    const SizedBox(height: 10), // Khoảng cách giữa các dòng
                    const Padding(
                      padding: EdgeInsets.only(
                          bottom: 20,
                          left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Text(
                        'Những thằng khác ngại tán em, tại ngán anh!',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w200
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Icon(
                              Icons.info,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    )
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
