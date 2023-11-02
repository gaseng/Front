import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_list_response.g.dart';

@JsonSerializable()
class SharehouseListResponse {
  final int shrId;
  final String shrTitle;
  final String shrDescription;
  final String shrAddress;
  final String shrPoster;

  SharehouseListResponse({
    required this.shrId,
    required this.shrTitle,
    required this.shrDescription,
    required this.shrAddress,
    required this.shrPoster,
  });

  factory SharehouseListResponse.fromJson(Map<String, dynamic> json)
  => _$SharehouseListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseListResponseToJson(this);
}