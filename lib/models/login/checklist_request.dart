import 'package:json_annotation/json_annotation.dart';

part 'checklist_request.g.dart';

@JsonSerializable()
class ChecklistRequest {
  final String chkSleepingHabit;
  final String chkCigarette;
  final String chkSleepTime;
  final String chkMbti;
  final String chkCallPlace;
  final String chkType;

  ChecklistRequest({
    required this.chkSleepingHabit,
    required this.chkCigarette,
    required this.chkSleepTime,
    required this.chkMbti,
    required this.chkCallPlace,
    required this.chkType,
  });

  factory ChecklistRequest.fromJson(Map<String, dynamic> json)
  => _$ChecklistRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistRequestToJson(this);
}