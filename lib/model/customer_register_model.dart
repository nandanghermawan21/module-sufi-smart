class CustomerRegisterModel {
  int? id;
  String? nik;
  String? imageUrl;
  String? imageId;
  String? fullName;
  String? genderId;
  String? genderName;
  String? cityId;
  String? cityName;
  String? phoneNumber;
  String? username;
  String? password;
  int? level;
  String? deviceId;
  String? token;

  CustomerRegisterModel({
    this.id,
    this.nik,
    this.imageUrl,
    this.imageId,
    this.fullName,
    this.genderId,
    this.genderName,
    this.cityId,
    this.cityName,
    this.phoneNumber,
    this.username,
    this.password,
    this.level,
    this.deviceId,
    this.token,
  });

  factory CustomerRegisterModel.fromJson(Map<String, dynamic> json) {
    return CustomerRegisterModel(
      id: json["id"] as int,
      nik: json["nik"] as String,
      imageUrl: json["imageUrl"] as String,
      imageId: json["imageId"] as String,
      fullName: json["fullName"] as String,
      genderId: json["genderId"] as String,
      genderName: json["genderName"] as String,
      cityId: json["cityId"] as String,
      cityName: json["cityName"] as String,
      phoneNumber: json["phoneNumber"] as String,
      username: json["username"] as String,
      password: json["password"] as String,
      level: json["level"] as int,
      deviceId: json["deviceId"] as String,
      token: json["token"] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nik": nik,
      "imageUrl": imageUrl,
      "imageId": imageId,
      "fullName": fullName,
      "genderId": genderId,
      "genderName": genderName,
      "cityId": cityId,
      "cityName": cityName,
      "phoneNumber": phoneNumber,
      "username": username,
      "password": password,
      "level": level,
      "deviceId": deviceId,
      "token": token,
    };
  }
}
