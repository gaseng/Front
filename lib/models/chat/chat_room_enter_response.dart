import 'package:json_annotation/json_annotation.dart';

part 'chat_room_enter_response.g.dart';

@JsonSerializable()
class ChatRoomEnterResponse {
  final String senderNickname;
  final String receiverNickname;
  final String chatRoomStatus;

  ChatRoomEnterResponse({
    required this.senderNickname,
    required this.receiverNickname,
    required this.chatRoomStatus,
  });

  factory ChatRoomEnterResponse.fromJson(Map<String, dynamic> json)
  => _$ChatRoomEnterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomEnterResponseToJson(this);
}