import 'package:json_annotation/json_annotation.dart';

part 'chat_room_create_response.g.dart';

@JsonSerializable()
class ChatRoomCreateResponse {
  final int chatRoomId;
  final int senderId;
  final int receiverId;

  ChatRoomCreateResponse({
    required this.chatRoomId,
    required this.senderId,
    required this.receiverId,
  });

  factory ChatRoomCreateResponse.fromJson(Map<String, dynamic> json)
  => _$ChatRoomCreateResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomCreateResponseToJson(this);
}