class User {
  int userId;
  int age;
  String gender;
  String imgUrl;
  String bio;
  String birthDay;
  String lastName;
  String firstName;
  String location;
  String accessToken;

  User({
    this.userId = 0,
    this.age = 18,
    this.gender = '',
    this.imgUrl = '',
    this.bio = '',
    this.birthDay = '',
    this.lastName = '',
    this.firstName = '',
    this.location = '',
    this.accessToken = '',
  });

  factory User.unknown() {
    return User();
  }

  // Factory constructor để tạo một User từ dữ liệu JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'] ?? 0,
      age: json['age'] ?? 18,
      gender: json['gender'] ?? '',
      imgUrl: json['imageURL'] ?? '',
      bio: json['bio'] ?? '',
      birthDay: json['birthDay'] ?? '',
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? '',
      location: json['location'] ?? '',
      accessToken: json['accessToken'] ?? '',
    );
  }

  // Method để chuyển đổi User thành dữ liệu JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'age': age,
      'gender': gender,
      'imgUrl': imgUrl,
      'bio': bio,
      'birthDay': birthDay,
      'lastName': lastName,
      'firstName': firstName,
      'location': location,
      'accessToken': accessToken,
    };
  }
}

//t xai cai nay de handle viec nhan tin va tin nhan ngu liz
class User2 {
  int userId;
  int age;
  String gender;
  String imgUrl;
  String bio;
  String birthDay;
  String lastName;
  String firstName;
  String location;
  String accessToken;
  String latestMessageContent;
  String latestMessageTimeSent;
  int latestMessageUserIdFrom;

  User2({
    this.userId = 0,
    this.age = 18,
    this.gender = '',
    this.imgUrl = '',
    this.bio = '',
    this.birthDay = '',
    this.lastName = '',
    this.firstName = '',
    this.location = '',
    this.accessToken = '',
    this.latestMessageContent = '',
    this.latestMessageTimeSent = '',
    this.latestMessageUserIdFrom = 0,
  });

  factory User2.fromJson(Map<String, dynamic> json) {
    return User2(
      userId: json['userId'] ?? 0,
      age: json['age'] ?? 18,
      gender: json['gender'] ?? '',
      imgUrl: json['imageURL'] ?? '',
      bio: json['bio'] ?? '',
      birthDay: json['birthDay'] ?? '',
      lastName: json['lastName'] ?? '',
      firstName: json['firstName'] ?? '',
      location: json['location'] ?? '',
      accessToken: json['accessToken'] ?? '',
      latestMessageContent: json['latestMessageContent'] ?? '',
      latestMessageTimeSent: json['latestMessageTimeSent'] ?? '',
      latestMessageUserIdFrom: json['latestMessageUserIdFrom'] ?? 0,
    );
  }
}

class Chat {
  int? messageId;
  String? content;
  String? timeSent;
  String? status;
  int? userIdTo;
  int? userIdFrom;
//model to handle chat session
  Chat(
      {this.messageId,
      this.content,
      this.timeSent,
      this.status,
      this.userIdTo,
      this.userIdFrom});

  Chat.fromJson(Map<String, dynamic> json) {
    messageId = json['messageId'];
    content = json['content'];
    timeSent = json['timeSent'];
    status = json['status'];
    userIdTo = json['UserIdTo'];
    userIdFrom = json['UserIdFrom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['messageId'] = messageId;
    data['content'] = content;
    data['timeSent'] = timeSent;
    data['status'] = status;
    data['UserIdTo'] = userIdTo;
    data['UserIdFrom'] = userIdFrom;
    return data;
  }
}
