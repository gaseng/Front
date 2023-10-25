// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharehouse_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharehouseRequest _$SharehouseRequestFromJson(Map<String, dynamic> json) =>
    SharehouseRequest(
      lists: json['lists'] as List<dynamic>,
      shrTitle: json['shrTitle'] as String,
      shrDescription: json['shrDescription'] as String,
      shrAddress: json['shrAddress'] as String,
      shrAddressDetail: json['shrAddressDetail'] as String,
    );

Map<String, dynamic> _$SharehouseRequestToJson(SharehouseRequest instance) =>
    <String, dynamic>{
      'lists': instance.lists,
      'shrTitle': instance.shrTitle,
      'shrDescription': instance.shrDescription,
      'shrAddress': instance.shrAddress,
      'shrAddressDetail': instance.shrAddressDetail,
    };
