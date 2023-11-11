// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_require_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycRequireResponse _$KycRequireResponseFromJson(Map<String, dynamic> json) =>
    KycRequireResponse(
      memId: json['memId'] as int,
      kycrId: json['kycrId'] as int,
      name: json['name'] as String,
      birth: DateTime.parse(json['birth'] as String),
      address: json['address'] as String,
      detail: json['detail'] as String,
      job: json['job'] as String,
      cardImagePath: json['cardImagePath'] as String,
      faceImagePath: json['faceImagePath'] as String,
    );

Map<String, dynamic> _$KycRequireResponseToJson(KycRequireResponse instance) =>
    <String, dynamic>{
      'memId': instance.memId,
      'kycrId': instance.kycrId,
      'name': instance.name,
      'birth': instance.birth.toIso8601String(),
      'address': instance.address,
      'detail': instance.detail,
      'job': instance.job,
      'cardImagePath': instance.cardImagePath,
      'faceImagePath': instance.faceImagePath,
    };
