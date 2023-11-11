import 'package:json_annotation/json_annotation.dart';

part 'kyc_notification_response.g.dart';

@JsonSerializable()
class KycNotificationResponse {
  final String status;
  final String description;
  final String createdDate;

  KycNotificationResponse({
    required this.status,
    required this.description,
    required this.createdDate,
  });

  factory KycNotificationResponse.fromJson(Map<String, dynamic> json)
  => _$KycNotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KycNotificationResponseToJson(this);
}
