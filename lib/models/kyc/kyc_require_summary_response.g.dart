// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kyc_require_summary_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KycRequireSummaryResponse _$KycRequireSummaryResponseFromJson(
        Map<String, dynamic> json) =>
    KycRequireSummaryResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$KycRequireSummaryResponseToJson(
        KycRequireSummaryResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt.toIso8601String(),
    };
