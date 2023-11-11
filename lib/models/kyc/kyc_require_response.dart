import 'package:json_annotation/json_annotation.dart';

part 'kyc_require_response.g.dart';

@JsonSerializable()
class KycRequireResponse {
  final int memId;
  final int kycrId;
  final String name;
  final DateTime birth;
  final String address;
  final String detail;
  final String job;
  final String cardImagePath;
  final String faceImagePath;

  KycRequireResponse({
    required this.memId,
    required this.kycrId,
    required this.name,
    required this.birth,
    required this.address,
    required this.detail,
    required this.job,
    required this.cardImagePath,
    required this.faceImagePath,
  });

  factory KycRequireResponse.fromJson(Map<String, dynamic> json)
  => _$KycRequireResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KycRequireResponseToJson(this);
}