import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_response.g.dart';

@JsonSerializable()
class SharehouseResponse {
  final int id;
  final String name;
  final String createdAt;
  final String title;
  final String description;
  final String address;
  final String addressDetail;
  final String poster;
  List<String> images;

  SharehouseResponse({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.address,
    required this.addressDetail,
    required this.poster,
    required this.images,
  });

  factory SharehouseResponse.fromJson(Map<String, dynamic> json)
  => _$SharehouseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseResponseToJson(this);
}