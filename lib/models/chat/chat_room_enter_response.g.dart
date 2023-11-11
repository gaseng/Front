// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_enter_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomEnterResponse _$ChatRoomEnterResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomEnterResponse(
      senderNickname: json['senderNickname'] as String,
      receiverNickname: json['receiverNickname'] as String,
      chatRoomStatus: json['chatRoomStatus'] as String,
    );

Map<String, dynamic> _$ChatRoomEnterResponseToJson(
        ChatRoomEnterResponse instance) =>
    <String, dynamic>{
      'senderNickname': instance.senderNickname,
      'receiverNickname': instance.receiverNickname,
      'chatRoomStatus': instance.chatRoomStatus,
    };
