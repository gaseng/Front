import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request.g.dart';

@JsonSerializable()
class SignUpRequest {
  final String email;
  final String password;
  final String name;
  final String nickname;
  final int sex;
  final String phone;

  SignUpRequest({
    required this.email,
    required this.password,
    required this.name,
    required this.nickname,
    required this.sex,
    required this.phone,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json)
  => _$SignUpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestToJson(this);
}