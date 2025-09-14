import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String phone;
  final String password;
final String?companyName;
final String?companyAddress;

  SignupRequestBody({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.password,
    this.companyName,
    this.companyAddress,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
