import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final int memId;
  final String memName;
  final String nickname;
  final String email;
  final String role;
  final String status;
  final String accessToken;
  final String refreshToken;

  LoginResponse({
    required this.memId,
    required this.memName,
    required this.nickname,
    required this.email,
    required this.role,
    required this.status,
    required this.accessToken,
    required this.refreshToken,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json)
  => _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}