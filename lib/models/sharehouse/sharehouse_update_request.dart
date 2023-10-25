import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_update_request.g.dart';

@JsonSerializable()
class SharehouseUpdateRequest {
  final int id;
  final String shrTitle;
  final String shrDescription;
  final String shrAddress;
  final String shrAddressDetail;

  SharehouseUpdateRequest({
    required this.id,
    required this.shrTitle,
    required this.shrDescription,
    required this.shrAddress,
    required this.shrAddressDetail,
  });

  factory SharehouseUpdateRequest.fromJson(Map<String, dynamic> json)
  => _$SharehouseUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseUpdateRequestToJson(this);
}