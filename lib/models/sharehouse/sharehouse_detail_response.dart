import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_detail_response.g.dart';

@JsonSerializable()
class SharehouseDetailResponse {
  final int id;
  final int memId;
  final String name;
  final String cigarette;
  final String habit;
  final String type;
  final String mbti;
  final String place;
  final String sleepTime;
  final String title;
  final String description;
  final String address;
  final String addressDetail;
  final String poster;
  final List<String> images;

  SharehouseDetailResponse({
    required this.id,
    required this.memId,
    required this.name,
    required this.cigarette,
    required this.habit,
    required this.type,
    required this.mbti,
    required this.place,
    required this.sleepTime,
    required this.title,
    required this.description,
    required this.address,
    required this.addressDetail,
    required this.poster,
    required this.images,
  });

  factory SharehouseDetailResponse.fromJson(Map<String, dynamic> json)
  => _$SharehouseDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseDetailResponseToJson(this);
}