import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_request.g.dart';

@JsonSerializable()
class SharehouseRequest {
  final List<dynamic> lists;
  final String shrTitle;
  final String shrDescription;
  final String shrAddress;
  final String shrAddressDetail;

  SharehouseRequest({
    required this.lists,
    required this.shrTitle,
    required this.shrDescription,
    required this.shrAddress,
    required this.shrAddressDetail,
  });

  factory SharehouseRequest.fromJson(Map<String, dynamic> json)
  => _$SharehouseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseRequestToJson(this);
}