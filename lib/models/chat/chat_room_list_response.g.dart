// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomListResponse _$ChatRoomListResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomListResponse(
      chatRoomId: json['chatRoomId'] as int,
      partnerNickname: json['partnerNickname'] as String,
      message: json['message'] as String? ?? "아직 대화가 없습니다.",
      updatedTime: json['updatedTime'] as String,
    );

Map<String, dynamic> _$ChatRoomListResponseToJson(
        ChatRoomListResponse instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'partnerNickname': instance.partnerNickname,
      'message': instance.message,
      'updatedTime': instance.updatedTime,
    };
