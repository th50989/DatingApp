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
      imgUrl: json['imgUrl'] ?? '',
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
