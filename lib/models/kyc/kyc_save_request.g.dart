// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_save_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycSaveRequest _$KycSaveRequestFromJson(Map<String, dynamic> json) =>
    KycSaveRequest(
      status: json['status'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$KycSaveRequestToJson(KycSaveRequest instance) =>
    <String, dynamic>{
      'status': instance.status,
      'description': instance.description,
    };
