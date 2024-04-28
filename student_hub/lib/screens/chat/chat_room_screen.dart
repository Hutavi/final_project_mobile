import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/models/chat/chat_room.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/screens/schedule_interview/schedule_interview.dart';
import 'package:student_hub/widgets/message_chat_bubble.dart';
import 'package:student_hub/widgets/schedule_invite.dart';
import 'package:student_hub/widgets/avatar.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

List<Message> sampleMessages = [
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 5,
    receiverUserId: 6,
    content: 'Hello, how are you?',
    createdAt: DateTime.now(),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 6,
    receiverUserId: 5,
    content: 'Hi, I am doing fine. How about you?',
    createdAt: DateTime.now().add(const Duration(minutes: 5)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 5,
    receiverUserId: 6,
    content: 'I am good too. Thanks for asking.',
    createdAt: DateTime.now().add(const Duration(minutes: 10)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 6,
    receiverUserId: 5,
    content: 'What have you been up to lately?',
    createdAt: DateTime.now().add(const Duration(minutes: 15)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 5,
    receiverUserId: 6,
    content: 'I have been busy with work. How about you?',
    createdAt: DateTime.now().add(const Duration(minutes: 20)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 6,
    receiverUserId: 5,
    content: 'I have been studying for my exams.',
    createdAt: DateTime.now().add(const Duration(minutes: 25)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 5,
    receiverUserId: 6,
    content: 'Good luck with your exams!',
    createdAt: DateTime.now().add(const Duration(minutes: 30)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 6,
    receiverUserId: 5,
    content: 'Thank you!',
    createdAt: DateTime.now().add(const Duration(minutes: 35)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 5,
    receiverUserId: 6,
    content: 'You\'re welcome. Let me know if you need any help.',
    createdAt: DateTime.now().add(const Duration(minutes: 40)),
  ),
  Message(
    id: const Uuid().v4(),
    projectID: 560,
    senderUserId: 6,
    receiverUserId: 5,
    content: 'Sure, I will. Thanks again!',
    createdAt: DateTime.now().add(const Duration(minutes: 45)),
  ),
];
// Message(
//   id: const Uuid().v4(),
//   chatRoomId: 560,
//   senderUserId: 5,
//   receiverUserId: 6,
//   title: 'Catch up meeting',
//   createdAt: DateTime.now().add(const Duration(minutes: 70)),
//   startTime: DateTime.now(),
//   endTime: DateTime.now().add(const Duration(minutes: 15)),
//   meeting: true,
//   canceled: true,
// ),

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
  late IO.Socket socket;
  late ScrollController _scrollController;
  final FocusNode _messageFocusNode = FocusNode();

  @override
  void initState() {
    _scrollController = ScrollController();
    connect();
    _loadMessages();
    _scrollToBottom();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  void connect() async {
    final prefs = await SharedPreferences.getInstance();

    socket = IO.io(
        'https://api.studenthub.dev',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    final token = prefs.getString('accessToken');
    socket.io.options?['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    socket.io.options?['query'] = {'project_id': 560};

    socket.connect();

    socket.onConnect((data) => {print('Connected')});

    // socket.onConnectError((data) => print('$data'));
    // socket.onError((data) => print(data));
    socket.on('RECEIVE_MESSAGE', (data) {
      setState(() {
        messages.add(Message(
          projectID: 1,
          senderUserId: 5,
          receiverUserId: 6,
          content: data['content'],
          createdAt: DateTime.now(),
          meeting: 0,
        ));
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 100,
          duration: const Duration(milliseconds: 1),
          curve: Curves.easeOut,
        );
      });
    });
  }

  void _sendMessage() {
    if (messageController.text == '') return;

    final newMessage = Message(
      id: const Uuid().v4(),
      projectID: 560,
      senderUserId: 5,
      receiverUserId: 6,
      content: messageController.text.trim(),
      createdAt: DateTime.now(),
    );

    setState(() {
      messages.add(newMessage);
    });

    messageController.clear();

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeOut,
      );
    });
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];

                      final showImage = index + 1 == messages.length ||
                          (index + 1 < messages.length &&
                              messages[index + 1].senderUserId !=
                                  message.senderUserId);

                      return Column(
                        children: [
                          const Gap(12),
                          Row(
                            mainAxisAlignment: (message.senderUserId != 5)
                                ? MainAxisAlignment.center
                                : MainAxisAlignment.center,
                            children: [
                              Text(
                                '${DateFormat("MMM d").format(message.createdAt)}, ${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: (message.senderUserId != 5)
                                ? MainAxisAlignment.end
                                : MainAxisAlignment.start,
                            children: [
                              if (showImage && message.senderUserId == 5)
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Avatar(
                                      imageUrl: ImageManagent.imgAvatar,
                                      radius: 15,
                                    ),
                                  ],
                                ),
                              if (message.meeting == 1)
                                ScheduleInviteTicket(
                                  userId1: 5,
                                  userId2: 6,
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
                                  userId1: 5,
                                  userId2: 6,
                                  message: message,
                                ),
                              if (showImage && message.senderUserId != 5)
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
                        ],
                      );
                    }),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          builder: (BuildContext context) {
                            return ScheduleInterview(
                                onSendMessage: (newMessage) {
                              // Thêm tin nhắn mới vào List<Message> tại đây
                              setState(() {
                                sampleMessages.add(newMessage);
                              });
                            });
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextFormField(
                          focusNode: _messageFocusNode,
                          controller: messageController,
                          maxLines: null,
                          minLines: 1,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.lightBlue[50],
                            hintText: 'Message',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                _sendMessage();
                              },
                              hoverColor: Colors.transparent,
                              icon: const Icon(
                                Icons.send,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
