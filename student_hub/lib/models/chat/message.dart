import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Message extends Equatable {
  final String? id;
  final int projectID;
  final int senderUserId;
  final int receiverUserId;
  final String? content;
  final DateTime createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? title;
  final int meeting;
  final int? duration;
  final String? meetingRoomId;
  final String? meetingRoomCode;
  bool canceled;

  Message({
    this.id,
    required this.projectID,
    required this.senderUserId,
    required this.receiverUserId,
    this.content,
    required this.createdAt,
    this.startTime,
    this.endTime,
    this.title,
    this.meeting = -1,
    this.duration = 0,
    this.canceled = false,
    this.meetingRoomId,
    this.meetingRoomCode,
  });

  Message copyWith({
    String? id,
    int? projectID,
    int? senderUserId,
    int? receiverUserId,
    String? content,
    DateTime? createdAt,
    DateTime? startTime,
    DateTime? endTime,
    String? title,
    int? meeting,
    int? duration,
    bool? canceled,
    String? meetingRoomId,
    String? meetingRoomCode,
  }) {
    return Message(
      id: id ?? this.id,
      projectID: projectID ?? this.projectID,
      senderUserId: senderUserId ?? this.senderUserId,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      meeting: meeting ?? this.meeting,
      duration: duration ?? this.duration,
      canceled: canceled ?? this.canceled,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      meetingRoomCode: meetingRoomCode ?? this.meetingRoomCode,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'] ?? const Uuid().v4(),
      projectID: json['chat_room_id'] ?? -1,
      senderUserId: json['sender_user_id'] ?? -1,
      receiverUserId: json['receiver_user_id'] ?? '',
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      title: json['title'],
      meeting: json['meeting'] ?? -1,
      duration: json['duration'] ?? 0,
      canceled: json['canceled'] ?? false,
      meetingRoomId: json['meeting_room_id'],
      meetingRoomCode: json['meeting_room_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_room_id': projectID,
      'sender_user_id': senderUserId,
      'receiver_user_id': receiverUserId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'title': title,
      'meeting': meeting,
      'duration': duration,
      'canceled': canceled,
      'meeting_room_id': meetingRoomId,
      'meeting_room_code': meetingRoomCode,
    };
  }

  @override
  List<Object?> get props => [
        id,
        projectID,
        senderUserId,
        receiverUserId,
        content,
        createdAt,
        startTime,
        endTime,
        title,
        meeting,
        duration,
        canceled,
        meetingRoomId,
        meetingRoomCode,
      ];
}
