import 'package:json_annotation/json_annotation.dart';

part 'chat_room_list_response.g.dart';

@JsonSerializable()
class ChatRoomListResponse {
  final int chatRoomId;
  final String partnerNickname;
  final String? message;
  final String updatedTime;

  ChatRoomListResponse({
    required this.chatRoomId,
    required this.partnerNickname,
    this.message = "아직 대화가 없습니다.",
    required this.updatedTime
  });

  factory ChatRoomListResponse.fromJson(Map<String, dynamic> json)
  => _$ChatRoomListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomListResponseToJson(this);
}