import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/models/chat/chat_room.dart';
import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/screens/schedule_interview/schedule_interview.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/services/dio_client_not_api.dart';
import 'package:student_hub/services/message_queue.dart';
import 'package:student_hub/services/socket.dart';
import 'package:student_hub/widgets/custom_dialog.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/widgets/message_chat_bubble.dart';
import 'package:student_hub/widgets/schedule_invite.dart';
import 'package:student_hub/widgets/avatar.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatRoomScreen extends StatefulWidget {
  final int idProject;
  final int idThisUser;
  final int idAnyUser;
  final String name;
  const ChatRoomScreen(
      {super.key,
      this.chatRoom,
      required this.idProject,
      required this.idThisUser,
      required this.idAnyUser,
      required this.name});

  final ChatRoom? chatRoom;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final messageController = TextEditingController();
  List<Message> messages = [];
  static IO.Socket? socket;
  late ScrollController _scrollController;
  final FocusNode _messageFocusNode = FocusNode();
  late bool isLoading;

  @override
  void initState() {
    setState(() {
      isLoading = true;
    });
    MessageQueueService.removeMessage();
    _scrollController = ScrollController();
    _loadMessages();
    SocketManager.addQueryParameter(widget.idProject);
    SocketManager.connect();
    socket = SocketManager.socket;
    connectSocket();
    super.initState();
  }

  // @override
  // void dispose() {
  //   messageController.dispose();
  //   super.dispose();
  // }

  void connectSocket() async {
    socket!.on('RECEIVE_INTERVIEW', (data) {
      print(data);
      if (data['notification'] != null &&
          data['notification']['content'] != null &&
          data['notification']['content'] == 'Interview created' &&
          mounted) {
        setState(() {
          messages.add(Message(
              id: data['notification']['messageId'],
              projectID: data['notification']['message']['projectId'],
              senderUserId: data['notification']['senderId'],
              receiverUserId: data['notification']['receiverId'],
              interviewID: data['notification']['message']['interviewId'],
              title: data['notification']['message']['interview']['title'],
              content: data['notification']['message']['interview']['title'],
              createdAt: DateTime.parse(
                  data['notification']['message']['interview']['createdAt']),
              startTime: DateTime.parse(
                  data['notification']['message']['interview']['startTime']),
              endTime: DateTime.parse(
                  data['notification']['message']['interview']['endTime']),
              meeting: data['notification']['message']['messageFlag'],
              meetingRoomId: data['notification']['message']['interview']
                      ['meetingRoom']['meeting_room_id'] ??
                  '',
              meetingRoomCode: data['notification']['message']['interview']
                      ['meetingRoom']['meeting_room_code'] ??
                  '',
              duration: calculateDurationInMinutes(
                  data['notification']['message']['interview']['startTime'],
                  data['notification']['message']['interview']['endTime'])));
          _scrollToBottom();
        });
      } else if (data['notification'] != null &&
          data['notification']['content'] == 'Interview cancelled' &&
          mounted) {
        bool canceled =
            data['notification']['message']['interview']['disableFlag'] == 0
                ? false
                : true;
        int index = messages.indexWhere(
            (message) => message.id == data['notification']['message']['id']);
        setState(() {
          messages[index] = messages[index].copyWith(canceled: canceled);
        });
      } else if (data['notification'] != null &&
          data['notification']['content'] != null &&
          data['notification']['content'] == 'Interview updated') {
        DateTime startTime = DateTime.parse(
            data['notification']['message']['interview']['startTime']);
        DateTime endTime = DateTime.parse(
            data['notification']['message']['interview']['endTime']);
        String title = data['notification']['message']['interview']['title'];
        bool canceled =
            data['notification']['message']['interview']['disableFlag'] == 0
                ? false
                : true;
        int duration = calculateDurationInMinutes(
            data['notification']['message']['interview']['startTime'],
            data['notification']['message']['interview']['endTime']);
        int index = messages.indexWhere(
            (element) => element.id == data['notification']['message']['id']);
        setState(() {
          messages[index] = messages[index].copyWith(
              startTime: startTime,
              endTime: endTime,
              title: title,
              canceled: canceled,
              duration: duration);
        });
      }
    });

    socket!.on('RECEIVE_MESSAGE', (data) {
      if (mounted) {
        setState(() {
          messages.add(Message(
            projectID: data['notification']['message']['projectId'],
            senderUserId: data['notification']['senderId'],
            receiverUserId: data['notification']['receiverId'],
            content: data['notification']['message']['content'],
            createdAt: DateTime.parse(data['notification']['createdAt']),
            meeting: data['notification']['message']['messageFlag'],
          ));

          _scrollToBottom();
        });
      }
    });
  }

  void _sendMessage() async {
    if (messageController.text == '') return;

    final data = {
      'content': messageController.text.trim(),
      'projectId': widget.idProject,
      'senderId': widget.idThisUser,
      'receiverId': widget.idAnyUser,
      'messageFlag': 0,
    };

    final dioPrivate = DioClient();

    await dioPrivate.request(
      '/message/sendMessage',
      data: data,
      options: Options(
        method: 'POST',
      ),
    );

    messageController.clear();

    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 10000,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _loadMessages() async {
    final dioPrivate = DioClient();

    final responseListMessage = await dioPrivate.request(
      '/message/${widget.idProject}/user/${widget.idAnyUser}',
      options: Options(
        method: 'GET',
      ),
    );

    final message = responseListMessage.data['result'];

    final List<Message> fetchMessages =
        message.cast<Map<String, dynamic>>().map<Message>((msg) {
      if (msg['interview'] == null) {
        return Message(
          id: msg['id'] as int,
          projectID: widget.idProject,
          senderUserId: msg['sender']['id'],
          receiverUserId: msg['receiver']['id'],
          content: msg['content'],
          createdAt: DateTime.parse(msg['createdAt']),
          startTime: null,
          endTime: null,
          title: '',
          meeting: 0,
          canceled: msg['canceled'] ?? false,
        );
      } else {
        return Message(
          id: msg['id'] as int,
          projectID: widget.idProject,
          senderUserId: msg['sender']['id'],
          receiverUserId: msg['receiver']['id'],
          interviewID: msg['interview']['id'],
          createdAt: DateTime.parse(msg['createdAt']),
          startTime: DateTime.parse(msg['interview']['startTime']),
          endTime: DateTime.parse(msg['interview']['endTime']),
          title: msg['interview']['title'],
          meeting: 1,
          duration: calculateDurationInMinutes(
              msg['interview']['startTime'], msg['interview']['endTime']),
          canceled: msg['interview']['disableFlag'] == 0 ? false : true,
          meetingRoomId:
              msg['interview']['meetingRoom']['meeting_room_id'] ?? '',
          meetingRoomCode:
              msg['interview']['meetingRoom']['meeting_room_code'] ?? '',
        );
      }
    }).toList();

    setState(() {
      _scrollToBottom();
      messages.addAll(fetchMessages);
      isLoading = false;
    });
  }

  int calculateDurationInMinutes(String? startDateTime, String? endDateTime) {
    if (startDateTime != null && endDateTime != null) {
      DateTime startTime = DateTime.parse(startDateTime);
      DateTime endTime = DateTime.parse(endDateTime);
      Duration duration = endTime.difference(startTime);

      return duration.inMinutes;
    }

    return 0;
  }

  Future<int?> createRoom(
      String conferencesID, String meetingRoomId, String? endDateTime) async {
    // Đặt kiểu trả về là Future<int?>
    // Chuyển đổi thời gian thành chuỗi định dạng ISO 8601
    String endTimeISO =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(parseDateTime(endDateTime!));

    var createRoomData = json.encode({
      "meeting_room_code": conferencesID,
      "meeting_room_id": conferencesID,
      "expired_at": endTimeISO
    });

    try {
      final dio = DioClientNotAPI();
      final response = await dio.request(
        '/meeting-room/create-room',
        data: createRoomData,
        options: Options(
          method: 'POST',
        ),
      );
      if (response.statusCode == 201) {
        print("OK");
        // Trích xuất ID từ phản hồi và trả về
        final id = response.data['result']['id'];
        return id;
      }
    } catch (e) {
      print('Error creating room: $e');
    }
    return null;
  }

  DateTime parseDateTime(String dateTimeString) {
    String sanitizedDateTimeString = dateTimeString.trim();
    sanitizedDateTimeString = sanitizedDateTimeString.replaceAll(" ", " ");
    return DateFormat("M/d/yyyy h:mm a").parse(sanitizedDateTimeString);
  }

  Future<void> createInvite(String? startDateTime, String? endDateTime,
      String titleSchedule, String conferencesID, String meetingRoomId) async {
    // Chuyển đổi thời gian thành chuỗi định dạng ISO 8601
    String startTimeISO = DateFormat("yyyy-MM-dd'T'HH:mm:ss")
        .format(parseDateTime(startDateTime!));
    String endTimeISO =
        DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(parseDateTime(endDateTime!));

    try {
      // Tạo phòng họp trước khi mời và lấy ID của phòng họp
      // final roomId = await createRoom(conferencesID, endDateTime);

      var data = json.encode({
        "title": titleSchedule,
        "content": titleSchedule,
        "startTime": startTimeISO,
        "endTime": endTimeISO,
        "projectId": widget.idProject,
        "senderId": widget.idThisUser,
        "receiverId": widget.idAnyUser,
        "meeting_room_code": conferencesID,
        "meeting_room_id": meetingRoomId,
        "expired_at": endTimeISO
      });

      final dio = DioClient();
      final response = await dio.request(
        '/interview',
        data: data,
        options: Options(
          method: 'POST',
        ),
      );
      if (response.statusCode == 201) {
        await createRoom(conferencesID, meetingRoomId, endDateTime);
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => DialogCustom(
            title: "Success",
            description: "Create a successful interview schedule.",
            buttonText: 'OK',
            statusDialog: 1,
            onConfirmPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print('Have Error 1: ${e.response!.data}');
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (context) => DialogCustom(
            title: "Error",
            description: "Create a failed interview schedule.",
            buttonText: 'OK',
            statusDialog: 2,
            onConfirmPressed: () {
              Navigator.pop(context);
            },
          ),
        );
      } else {
        print('Have Error 2: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;

    Color? color = (brightness == Brightness.light)
        ? Colors.grey[200]
        : Theme.of(context).cardColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
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
              radius: 20,
            ),
            const Gap(16),
            Text(
              widget.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    child: isLoading
                        ? const LoadingWidget()
                        : ListView.builder(
                            controller: _scrollController,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              Message message = messages[index];

                              final showImage = index + 1 == messages.length ||
                                  (index + 1 < messages.length &&
                                      messages[index + 1].senderUserId !=
                                          message.senderUserId);

                              return Column(
                                key: ValueKey(message.id),
                                children: [
                                  const Gap(12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '${DateFormat("MMM d").format(message.createdAt)}, ${message.createdAt.hour}:${message.createdAt.minute.toString().padLeft(2, '0')}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: (message.senderUserId !=
                                            widget.idThisUser)
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                    children: [
                                      if (showImage &&
                                          message.senderUserId !=
                                              widget.idThisUser)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Avatar(
                                              imageUrl: ImageManagent.imgAvatar,
                                              radius: 16,
                                            ),
                                          ],
                                        ),
                                      if (message.meeting == 1)
                                        ScheduleInviteTicket(
                                            userId1: widget.idThisUser,
                                            userId2: widget.idAnyUser,
                                            message: message,
                                            onCancelMeeting: () {
                                              // setState(() {
                                              //   message.canceled = true;
                                              // });
                                            },
                                            onUpdateInterview: (data) {
                                              setState(() {
                                                print(data);
                                                message.title = data['title'];
                                                message.startTime =
                                                    DateTime.parse(
                                                        data['startTime']!);
                                                message.endTime =
                                                    DateTime.parse(
                                                        data['endTime']!);
                                                message.duration =
                                                    calculateDurationInMinutes(
                                                        data['startTime']!,
                                                        data['endTime']!);
                                              });
                                            })
                                      else
                                        MessageChatBubble(
                                          userId1: widget.idThisUser,
                                          userId2: widget.idAnyUser,
                                          message: message,
                                        ),
                                      if (showImage &&
                                          message.senderUserId ==
                                              widget.idThisUser)
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Avatar(
                                              imageUrl: ImageManagent.imgAvatar,
                                              radius: 16,
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
                if (!isLoading)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
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
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (BuildContext context) {
                                  return ScheduleInterview(
                                    onSendMessage: (newMessage) {
                                      setState(
                                        () {
                                          createInvite(
                                              newMessage['startDateTime'],
                                              newMessage['endDateTime'],
                                              newMessage['titleSchedule']!,
                                              newMessage['conferencesID']!,
                                              newMessage['meetingRoomId']!);
                                        },
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: TextFormField(
                                focusNode: _messageFocusNode,
                                controller: messageController,
                                maxLines: null,
                                minLines: 1,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: color,
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
                                      FocusScope.of(context).unfocus();
                                    },
                                    hoverColor: Colors.transparent,
                                    icon: const Icon(
                                      Icons.send,
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
            )),
      ),
    );
  }
}
