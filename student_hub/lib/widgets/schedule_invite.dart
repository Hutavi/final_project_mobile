import 'package:flutter/material.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/widgets/schedule_message.dart';

class ScheduleInviteTicket extends StatelessWidget {
  const ScheduleInviteTicket({
    super.key,
    required this.message,
    required this.userId1,
    required this.userId2,
    this.onCancelMeeting,
  });
  final String userId1;
  final String userId2;

  final Message message;

  final VoidCallback? onCancelMeeting;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final alignment = (message.senderUserId != userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (message.senderUserId == userId1) ? Colors.blue : Colors.grey;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.75),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: const ScheduleMessageItem(),
      ),
    );
  }
}
