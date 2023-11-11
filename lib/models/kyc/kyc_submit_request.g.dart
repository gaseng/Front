// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_submit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycSubmitRequest _$KycSubmitRequestFromJson(Map<String, dynamic> json) =>
    KycSubmitRequest(
      name: json['name'] as String,
      birth: DateTime.parse(json['birth'] as String),
      address: json['address'] as String,
      detail: json['detail'] as String,
      job: json['job'] as String,
      card: json['card'],
      face: json['face'],
    );

Map<String, dynamic> _$KycSubmitRequestToJson(KycSubmitRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'birth': instance.birth.toIso8601String(),
      'address': instance.address,
      'detail': instance.detail,
      'job': instance.job,
      'card': instance.card,
      'face': instance.face,
    };
