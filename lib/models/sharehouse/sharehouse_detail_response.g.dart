// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharehouse_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharehouseDetailResponse _$SharehouseDetailResponseFromJson(
        Map<String, dynamic> json) =>
    SharehouseDetailResponse(
      id: json['id'] as int,
      memId: json['memId'] as int,
      name: json['name'] as String,
      cigarette: json['cigarette'] as String,
      habit: json['habit'] as String,
      type: json['type'] as String,
      mbti: json['mbti'] as String,
      place: json['place'] as String,
      sleepTime: json['sleepTime'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      addressDetail: json['addressDetail'] as String,
      poster: json['poster'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SharehouseDetailResponseToJson(
        SharehouseDetailResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'memId': instance.memId,
      'name': instance.name,
      'cigarette': instance.cigarette,
      'habit': instance.habit,
      'type': instance.type,
      'mbti': instance.mbti,
      'place': instance.place,
      'sleepTime': instance.sleepTime,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'poster': instance.poster,
      'images': instance.images,
    };
