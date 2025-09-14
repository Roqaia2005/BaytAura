// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      token: json['token'] as String?,
      userId: (json['userId'] as num?)?.toInt(),
      username: json['username'] as String?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      expiresAt: json['expiresAt'] as String?,
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'userId': instance.userId,
      'username': instance.username,
      'email': instance.email,
      'role': instance.role,
      'expiresAt': instance.expiresAt,
    };
