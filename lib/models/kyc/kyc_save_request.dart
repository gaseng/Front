import 'package:json_annotation/json_annotation.dart';

part 'kyc_save_request.g.dart';

@JsonSerializable()
class KycSaveRequest {
  final String status;
  final String description;

  KycSaveRequest({
    required this.status,
    required this.description,
  });

  factory KycSaveRequest.fromJson(Map<String, dynamic> json)
  => _$KycSaveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$KycSaveRequestToJson(this);
}
