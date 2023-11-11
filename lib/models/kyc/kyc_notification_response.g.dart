// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycNotificationResponse _$KycNotificationResponseFromJson(
        Map<String, dynamic> json) =>
    KycNotificationResponse(
      status: json['status'] as String,
      description: json['description'] as String,
      createdDate: json['createdDate'] as String,
    );

Map<String, dynamic> _$KycNotificationResponseToJson(
        KycNotificationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'description': instance.description,
      'createdDate': instance.createdDate,
    };
