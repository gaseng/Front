// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharehouse_update_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharehouseUpdateRequest _$SharehouseUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    SharehouseUpdateRequest(
      id: json['id'] as int,
      shrTitle: json['shrTitle'] as String,
      shrDescription: json['shrDescription'] as String,
      shrAddress: json['shrAddress'] as String,
      shrAddressDetail: json['shrAddressDetail'] as String,
    );

Map<String, dynamic> _$SharehouseUpdateRequestToJson(
        SharehouseUpdateRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'shrTitle': instance.shrTitle,
      'shrDescription': instance.shrDescription,
      'shrAddress': instance.shrAddress,
      'shrAddressDetail': instance.shrAddressDetail,
    };
