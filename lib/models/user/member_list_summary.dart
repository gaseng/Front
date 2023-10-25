import 'package:json_annotation/json_annotation.dart';

part 'member_list_summary.g.dart';

@JsonSerializable()
class MemberListSummary {
  final int memId;
  final String memName;

  MemberListSummary({
    required this.memId,
    required this.memName,
  });

  factory MemberListSummary.fromJson(Map<String, dynamic> json)
  => _$MemberListSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$MemberListSummaryToJson(this);
}