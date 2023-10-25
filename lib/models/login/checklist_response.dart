import 'package:json_annotation/json_annotation.dart';

part 'checklist_response.g.dart';

@JsonSerializable()
class ChecklistResponse {
  final String chkSleepingHabit;
  final String chkCigarette;
  final String chkSleepTime;
  final String chkMbti;
  final String chkCallPlace;
  final String chkType;

  ChecklistResponse({
    required this.chkSleepingHabit,
    required this.chkCigarette,
    required this.chkSleepTime,
    required this.chkMbti,
    required this.chkCallPlace,
    required this.chkType,
  });

  factory ChecklistResponse.fromJson(Map<String, dynamic> json)
  => _$ChecklistResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChecklistResponseToJson(this);
}