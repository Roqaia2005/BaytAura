import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';




@JsonSerializable()
class LoginResponse {
  String? token;
  int? userId;
  String? username;
  String? email;
  String? role;
  String? expiresAt;

  LoginResponse({
    this.token,
    this.userId,
    this.username,
    this.email,
    this.role,
    this.expiresAt,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}
