// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChecklistResponse _$ChecklistResponseFromJson(Map<String, dynamic> json) =>
    ChecklistResponse(
      chkSleepingHabit: json['chkSleepingHabit'] as String,
      chkCigarette: json['chkCigarette'] as String,
      chkSleepTime: json['chkSleepTime'] as String,
      chkMbti: json['chkMbti'] as String,
      chkCallPlace: json['chkCallPlace'] as String,
      chkType: json['chkType'] as String,
    );

Map<String, dynamic> _$ChecklistResponseToJson(ChecklistResponse instance) =>
    <String, dynamic>{
      'chkSleepingHabit': instance.chkSleepingHabit,
      'chkCigarette': instance.chkCigarette,
      'chkSleepTime': instance.chkSleepTime,
      'chkMbti': instance.chkMbti,
      'chkCallPlace': instance.chkCallPlace,
      'chkType': instance.chkType,
    };
