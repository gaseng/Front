import 'package:json_annotation/json_annotation.dart';

part 'chat_room_response.g.dart';

@JsonSerializable()
class ChatRoomResponse {
  final int chatRoomId;
  final int senderId;
  final int receiverId;

  ChatRoomResponse({
    required this.chatRoomId,
    required this.senderId,
    required this.receiverId,
  });

  factory ChatRoomResponse.fromJson(Map<String, dynamic> json)
  => _$ChatRoomResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomResponseToJson(this);
}