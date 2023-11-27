import 'package:flutter/material.dart';
import 'package:believeder_app/Screens/HomePage/Widget/CardProvider/CardProvider.dart';

class UserCard extends StatelessWidget {
  final UserInfoModel userInfo;

  const UserCard(
    this.userInfo, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height / 1.42,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(userInfo.imageUrl)
                        
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    // border: Border.all(width: 0.5, color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white, // Màu của bóng
                        offset: Offset(
                            0, 1), // Độ dịch chuyển ngang và dọc của bóng
                        blurRadius: 8, // Độ mờ của bóng
                        spreadRadius: 5, // Phạm vi của bóng
                      ),
                    ]),
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
                      height: MediaQuery.of(context).size.height / 2.3,
                    ), // Khoảng cách từ đỉnh Container xuống dưới
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Text(
                        userInfo.username + ' ,' + userInfo.age.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10), // Khoảng cách giữa các dòng
                    Padding(
                      padding: EdgeInsets.only(
                          bottom: 9,
                          left: 20
                        ), // Tạo khoảng cách lề trái 20 đơn vị
                      child: Container(
                        height: 40, // Đặt chiều cao cố định cho Container
                        child: Text(
                          userInfo.bio,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 0.1,
                          right: 5.0,
                          // top: 10.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            IconButton(
                              icon: Icon(Icons.info),
                              color: Colors.white,
                              onPressed: () {
                                print("Bạn bấm vào trang cá nhân của người dùng này");
                              },
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
