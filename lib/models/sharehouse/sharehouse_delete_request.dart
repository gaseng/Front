import 'package:get/get_connect/connect.dart';
import 'package:image_picker/image_picker.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sharehouse_delete_request.g.dart';

@JsonSerializable()
class SharehouseDeleteRequest {
  final int id;

  SharehouseDeleteRequest({
    required this.id,
  });

  factory SharehouseDeleteRequest.fromJson(Map<String, dynamic> json)
  => _$SharehouseDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SharehouseDeleteRequestToJson(this);
}