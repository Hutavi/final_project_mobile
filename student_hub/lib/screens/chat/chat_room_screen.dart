import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/models/chat/chat_room.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/widgets/message_chat_bubble.dart';
import 'package:student_hub/widgets/message_meeting_bubble.dart';
import 'package:student_hub/widgets/avatar.dart';
import 'package:student_hub/widgets/create_meeting.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

List<Message> sampleMessages = [
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    content: 'Hello, how are you?',
    createdAt: DateTime.now(),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    content: 'Hi, I am doing fine. How about you?',
    createdAt: DateTime.now().add(const Duration(minutes: 5)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    content: 'I am good too. Thanks for asking.',
    createdAt: DateTime.now().add(const Duration(minutes: 10)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    content: 'What have you been up to lately?',
    createdAt: DateTime.now().add(const Duration(minutes: 15)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    content: 'I have been busy with work. How about you?',
    createdAt: DateTime.now().add(const Duration(minutes: 20)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    content: 'I have been studying for my exams.',
    createdAt: DateTime.now().add(const Duration(minutes: 25)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    content: 'Good luck with your exams!',
    createdAt: DateTime.now().add(const Duration(minutes: 30)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    content: 'Thank you!',
    createdAt: DateTime.now().add(const Duration(minutes: 35)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    content: 'You\'re welcome. Let me know if you need any help.',
    createdAt: DateTime.now().add(const Duration(minutes: 40)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    content: 'Sure, I will. Thanks again!',
    createdAt: DateTime.now().add(const Duration(minutes: 45)),
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId2',
    receiverUserId: 'userId1',
    title: 'Catch up meeting',
    createdAt: DateTime.now().add(const Duration(minutes: 60)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(minutes: 15)),
    meeting: true,
  ),
  Message(
    id: const Uuid().v4(),
    chatRoomId: 'chatRoomId1',
    senderUserId: 'userId1',
    receiverUserId: 'userId2',
    title: 'Catch up meeting',
    createdAt: DateTime.now().add(const Duration(minutes: 70)),
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(minutes: 15)),
    meeting: true,
    canceled: true,
  ),
];

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, this.chatRoom});

  final ChatRoom? chatRoom;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  final List<Message> messages =
      sampleMessages.isNotEmpty ? sampleMessages : [];

  @override
  void initState() {
    _loadMessages();

    // messageRepository.subscribeToMessageUpdates((messageData) {
    //   final message = Message.fromJson(messageData);
    //   if (message.chatRoomId == widget.chatRoom.id) {
    //     messages.add(message);
    //     messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    //     setState(() {});
    //   }
    // });
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final message = Message(
      chatRoomId: 'chatRoomId1',
      senderUserId: 'userId1',
      receiverUserId: 'userId2',
      content: messageController.text,
      createdAt: DateTime.now(),
    );

    // await messageRepository.createMessage(message);
    messageController.clear();
  }

  _loadMessages() async {
    // final _messages = await messageRepository.fetchMessages(widget.chatRoom.id);

    // _messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    // setState(() {
    //   messages.addAll(_messages);
    // });
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.viewInsetsOf(context);
    final currentParticipant = widget.chatRoom?.participants.firstWhere(
      (user) => user.id == 'userId1',
    );

    final otherParticipant = widget.chatRoom?.participants.firstWhere(
      (user) => user.id != currentParticipant?.id,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            Avatar(
              imageUrl: ImageManagent.imgAvatar,
              radius: 18,
            ),
            const Gap(16),
            Text(
              'User 2',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            offset: const Offset(0, 45),
            color: Theme.of(context).colorScheme.secondaryContainer,
            onSelected: (String value) {
              setState(() {
                // _selectedMenu = value;
              });
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Schedule an interview',
                height: 60,
                onTap: () async {
                  await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      builder: (ctx) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const CreateMeeting(),
                        );
                      });
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                          Theme.of(context).brightness == Brightness.dark
                              ? 1
                              : .7),
                    ),
                    const Gap(16),
                    Text(
                      'Schedule an interview',
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Cancel', // Giá trị cho mục "Cancel"
                height: 60,
                onTap: () {
                  // Xử lý khi chọn "Cancel"
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Theme.of(context).colorScheme.primary.withOpacity(
                          Theme.of(context).brightness == Brightness.dark
                              ? 1
                              : .7),
                    ),
                    const Gap(16),
                    Text(
                      'Cancel',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            top: 8.0,
            bottom: (viewInsets.bottom > 0) ? 8.0 : 0.0,
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    final showImage = index + 1 == messages.length ||
                        messages[index + 1].senderUserId !=
                            message.senderUserId;

                    return Column(
                      children: [
                        const Gap(6),
                        Row(
                          mainAxisAlignment: (message.senderUserId != 'userId1')
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            if (showImage && message.senderUserId == 'userId1')
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Avatar(
                                    imageUrl: ImageManagent.imgAvatar,
                                    radius: 15,
                                  ),
                                ],
                              ),
                            if (message.meeting)
                              MessageMeetingBubble(
                                userId1: 'userId1',
                                userId2: 'userId2',
                                message: message,
                                onCancelMeeting: () {
                                  setState(() {
                                    // Cập nhật trạng thái của cuộc họp
                                    message.canceled = true;
                                  });
                                },
                              )
                            else
                              MessageChatBubble(
                                userId1: 'userId1',
                                userId2: 'userId2',
                                message: message,
                              ),
                            if (showImage && message.senderUserId != 'userId1')
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Avatar(
                                    imageUrl: ImageManagent.imgAvatar,
                                    radius: 15,
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: (message.senderUserId != 'userId1')
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          children: [
                            Text(
                              '${DateFormat("MMM d").format(message.createdAt)}, ${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        await showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isScrollControlled: true,
                            builder: (ctx) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: const CreateMeeting(),
                              );
                            });
                      },
                      icon: const Icon(Icons.calendar_month),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: messageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(100),
                          hintText: 'Type a message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              _sendMessage();
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
