class LoginModel {
  final bool success;
  final String message;
  final LoginData data;

  LoginModel({required this.success, required this.message, required this.data});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: LoginData.fromJson(json["data"] ?? {}),
      );
}

class LoginData {
  final String accessToken;

  LoginData({required this.accessToken});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        accessToken: json["access_token"] ?? "",
      );
}
