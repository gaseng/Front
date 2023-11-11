// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_room_create_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoomCreateResponse _$ChatRoomCreateResponseFromJson(
        Map<String, dynamic> json) =>
    ChatRoomCreateResponse(
      chatRoomId: json['chatRoomId'] as int,
      senderId: json['senderId'] as int,
      receiverId: json['receiverId'] as int,
    );

Map<String, dynamic> _$ChatRoomCreateResponseToJson(
        ChatRoomCreateResponse instance) =>
    <String, dynamic>{
      'chatRoomId': instance.chatRoomId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
    };
