import 'package:flutter/material.dart';
import 'package:student_hub/models/chat/message.dart';

class MessageChatBubble extends StatelessWidget {
  const MessageChatBubble({
    super.key,
    required this.message,
    required this.userId1,
    required this.userId2,
  });
  final int userId1;
  final int userId2;

  final Message message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final Brightness brightness = Theme.of(context).brightness;
    Color? color = (brightness == Brightness.light)
        ? (message.senderUserId == userId1
            ? Colors.blue[300]
            : Colors.grey[300])
        : (message.senderUserId == userId1
            ? Colors.blue[700]
            : Colors.grey[700]);

    final alignment = (message.senderUserId == userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: size.width * 0.6),
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
        ),
        child: Text(
          message.content ?? '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
        ),
      ),
    );
  }
}
