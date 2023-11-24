class UserInfoModel {
  int userId;
  String username;
  String age;
  String bio;
  String imageUrl;

  UserInfoModel({
    this.userId = 0,
    this.username = '',
    this.age = '18',
    this.bio = '',
    this.imageUrl = '',
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userId: json['userId'] ?? 0,
      username: json['firstName'] + ' ' + json['lastName'] ?? '',
      age: json['age'] ?? '18',
      bio: json['bio'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'age': age,
      'bio': bio,
      'imageUrl': imageUrl,
    };
  }
}

// final List<UserInfoModel> userInfo = [
//   UserInfoModel(
//       username: 'User 1',
//       age: 21,
//       bio: 'Test 1',
//       imageUrl: "assets/images/usercard.jpg"),
//   UserInfoModel(
//       username: 'Thanh Huyền',
//       age: 21,
//       bio: 'Đm chúng m',
//       imageUrl: "assets/images/usercard1.jpg"),
//   UserInfoModel(
//       username: 'Deadly Nọng',
//       age: 21,
//       bio: 'Mắt tao đang nhắm không có nghĩa là nó đang mở.',
//       imageUrl: "assets/images/usercard2.jpg"),
//   UserInfoModel(
//       username: 'Lil Thènh',
//       age: 21,
//       bio: 'Đéo ngán bố con thằng lào',
//       imageUrl: "assets/images/usercard3.jpg"),
//   UserInfoModel(
//       username: 'nh0kThènhvippr0',
//       age: 21,
//       bio: 'Bố m đẹp zai vãi l',
//       imageUrl: "assets/images/usercard4.jpg"),
// ];
