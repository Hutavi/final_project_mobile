import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Message extends Equatable {
  final String? id;
  final String chatRoomId;
  final String senderUserId;
  final String receiverUserId;
  final String? content;
  final DateTime createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? title;
  final bool meeting;
  bool canceled;

  Message({
    this.id,
    required this.chatRoomId,
    required this.senderUserId,
    required this.receiverUserId,
    this.content,
    required this.createdAt,
    this.startTime,
    this.endTime,
    this.title,
    this.meeting = false,
    this.canceled = false,
  });

  Message copyWith({
    String? id,
    String? chatRoomId,
    String? senderUserId,
    String? receiverUserId,
    String? content,
    DateTime? createdAt,
    DateTime? startTime,
    DateTime? endTime,
    String? title,
    bool? meeting,
    bool? canceled,
  }) {
    return Message(
      id: id ?? this.id,
      chatRoomId: chatRoomId ?? this.chatRoomId,
      senderUserId: senderUserId ?? this.senderUserId,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      meeting: meeting ?? this.meeting,
      canceled: canceled ?? this.canceled,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? const Uuid().v4(),
      chatRoomId: json['chat_room_id'] ?? '',
      senderUserId: json['sender_user_id'] ?? '',
      receiverUserId: json['receiver_user_id'] ?? '',
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      title: json['title'],
      meeting: json['meeting'] ?? false,
      canceled: json['canceled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': chatRoomId,
      'sender_user_id': senderUserId,
      'receiver_user_id': receiverUserId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'title': title,
      'meeting': meeting,
      'canceled': canceled,
    };
  }

  @override
  List<Object?> get props => [
        id,
        chatRoomId,
        senderUserId,
        receiverUserId,
        content,
        createdAt,
        startTime,
        endTime,
        title,
        meeting,
        canceled,
      ];
}
