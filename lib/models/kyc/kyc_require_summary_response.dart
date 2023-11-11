import 'package:json_annotation/json_annotation.dart';

part 'kyc_require_summary_response.g.dart';

@JsonSerializable()
class KycRequireSummaryResponse {
  final int id;
  final String name;
  final DateTime createdAt;

  KycRequireSummaryResponse({
    required this.id,
    required this.name,
    required this.createdAt
  });

  factory KycRequireSummaryResponse.fromJson(Map<String, dynamic> json)
  => _$KycRequireSummaryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KycRequireSummaryResponseToJson(this);
}