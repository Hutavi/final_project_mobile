import 'package:flutter/material.dart';
import 'package:student_hub/models/chat/message.dart';

class MessageChatBubble extends StatelessWidget {
  const MessageChatBubble({
    super.key,
    required this.message,
    required this.userId1,
    required this.userId2,
  });
  final String userId1;
  final String userId2;

  final Message message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    final alignment = (message.senderUserId != userId1)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    final color = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.secondary;

    final textColor = (message.senderUserId == userId1)
        ? Theme.of(context).colorScheme.onPrimary
        : Theme.of(context).colorScheme.onSecondary;

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
                color: textColor,
                fontSize: MediaQuery.of(context).size.width * 0.04, //
              ),
        ),
      ),
    );
  }
}
