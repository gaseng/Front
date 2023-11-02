// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomResponse _$ChatRoomResponseFromJson(Map<String, dynamic> json) =>
    ChatRoomResponse(
      chatRoomId: json['chatRoomId'] as int,
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
    );

Map<String, dynamic> _$ChatRoomResponseToJson(ChatRoomResponse instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
    };
