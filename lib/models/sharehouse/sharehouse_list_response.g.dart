// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharehouse_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharehouseListResponse _$SharehouseListResponseFromJson(
        Map<String, dynamic> json) =>
    SharehouseListResponse(
      shrId: json['shrId'] as int,
      shrTitle: json['shrTitle'] as String,
      shrDescription: json['shrDescription'] as String,
      shrAddress: json['shrAddress'] as String,
      shrPoster: json['shrPoster'] as String,
    );

Map<String, dynamic> _$SharehouseListResponseToJson(
        SharehouseListResponse instance) =>
    <String, dynamic>{
      'shrId': instance.shrId,
      'shrTitle': instance.shrTitle,
      'shrDescription': instance.shrDescription,
      'shrAddress': instance.shrAddress,
      'shrPoster': instance.shrPoster,
    };
