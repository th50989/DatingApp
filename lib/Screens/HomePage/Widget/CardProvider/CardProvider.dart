import 'package:flutter/cupertino.dart';

class UserInfoModel {
  String username;
  String age;
  String description;
  String imageUrl;

  UserInfoModel({
    required this.username,
    required this.age,
    required this.description,
    required this.imageUrl,
  });
}

final List<UserInfoModel> userInfo = [
  UserInfoModel(
    username: 'User 1',
    age: '21',
    description: 'Test 1',
    imageUrl: "assets/images/usercard.jpg"
  ),
  UserInfoModel(
    username: 'Thanh Huyền',
    age: '20',
    description: 'Đm chúng m',
    imageUrl: "assets/images/usercard1.jpg"
  ),
  UserInfoModel(
    username: 'Deadly Nọng',
    age: '21',
    description: 'Mắt tao đang nhắm không có nghĩa là nó đang mở.',
    imageUrl: "assets/images/usercard2.jpg"
  ),
  UserInfoModel(
    username: 'Lil Thènh',
    age: '8',
    description: 'Đéo ngán bố con thằng lào',
    imageUrl: "assets/images/usercard3.jpg"
  ),
  UserInfoModel(
    username: 'nh0kThènhvippr0',
    age: '20',
    description: 'Bố m đẹp zai vãi l',
    imageUrl: "assets/images/usercard4.jpg"
  ),
];