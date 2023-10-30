class User {
  String Age = '';
  String gender = '';
  String imgUrl = '';
  String bio = '';
  String birthDay = '';
  String lastName = '';
  String firstName = '';
  String location = '';
  //TAO DDEOS BIET CAN CAI NAY K NEN T CU GHI DAI
  String accessToken = '';

  User(this.Age, this.firstName, this.lastName, this.birthDay, this.gender,
      this.location, this.accessToken, this.bio, this.imgUrl);
  User.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        bio = json['bio'],
        birthDay = json['birthday'],
        gender = json['gender'],
        location = json['location'],
        imgUrl = json['ImageURL'],
        accessToken = json['accessToken'];
}
