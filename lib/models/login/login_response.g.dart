// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      memId: json['memId'] as int,
      email: json['email'] as String,
      role: json['role'] as String,
      status: json['status'] as String,
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'memId': instance.memId,
      'email': instance.email,
      'role': instance.role,
      'status': instance.status,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
