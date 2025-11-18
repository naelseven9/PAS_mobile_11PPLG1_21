class LoginModel {
  bool status;
  String message;
  String? token; // ubah jadi nullable

  LoginModel({
    required this.status,
    required this.message,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "token": token,
      };
}
