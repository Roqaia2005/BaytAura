import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? token;
  int? userId;
  String? username;
  String? email;
  String? role;
  String? expiresAt;

  SignupResponse({
    this.token,
    this.userId,
    this.username,
    this.email,
    this.role,
    this.expiresAt,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}
