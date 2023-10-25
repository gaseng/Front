// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountResponse _$AccountResponseFromJson(Map<String, dynamic> json) =>
    AccountResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      nickname: json['nickname'] as String,
      phone: json['phone'] as String,
      createdDate: json['createdDate'] as String,
      sex: json['sex'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$AccountResponseToJson(AccountResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'nickname': instance.nickname,
      'phone': instance.phone,
      'createdDate': instance.createdDate,
      'sex': instance.sex,
      'status': instance.status,
    };
