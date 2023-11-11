import 'package:json_annotation/json_annotation.dart';

part 'kyc_submit_request.g.dart';

@JsonSerializable()
class KycSubmitRequest {
  final String name;
  final DateTime birth;
  final String address;
  final String detail;
  final String job;
  final dynamic card;
  final dynamic face;

  KycSubmitRequest({
    required this.name,
    required this.birth,
    required this.address,
    required this.detail,
    required this.job,
    required this.card,
    required this.face,
  });

  factory KycSubmitRequest.fromJson(Map<String, dynamic> json)
  => _$KycSubmitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KycSubmitRequestToJson(this);
}
