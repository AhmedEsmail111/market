class LoginModel {
  final bool status;
  final String message;
  final UserData? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"] ?? '',
        data: json["data"] != null ? UserData.fromJson(json['data']) : null,
      );

  LoginModel({required this.status, required this.message, required this.data});
}

class UserData {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final num? points;
  final num? credit;
  final String? token;

  UserData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.points,
    required this.credit,
    required this.token,
  });
  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        phone: json['phone'],
        image: json['image'],
        points: json['points'],
        credit: json['credit'],
        token: json['token'],
      );
}
