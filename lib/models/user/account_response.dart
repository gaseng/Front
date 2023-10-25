import 'package:json_annotation/json_annotation.dart';

part 'account_response.g.dart';

@JsonSerializable()
class AccountResponse {
  final int id;
  final String name;
  final String email;
  final String nickname;
  final String phone;
  final String createdDate;
  final String sex;
  final String status;

  AccountResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.nickname,
    required this.phone,
    required this.createdDate,
    required this.sex,
    required this.status,
  });

  factory AccountResponse.fromJson(Map<String, dynamic> json)
  => _$AccountResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AccountResponseToJson(this);
}