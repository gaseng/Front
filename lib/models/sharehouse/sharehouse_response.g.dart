// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sharehouse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharehouseResponse _$SharehouseResponseFromJson(Map<String, dynamic> json) =>
    SharehouseResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      createdAt: json['createdAt'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      address: json['address'] as String,
      addressDetail: json['addressDetail'] as String,
      poster: json['poster'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$SharehouseResponseToJson(SharehouseResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'title': instance.title,
      'description': instance.description,
      'address': instance.address,
      'addressDetail': instance.addressDetail,
      'poster': instance.poster,
      'images': instance.images,
    };
