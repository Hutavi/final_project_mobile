import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/services/dio_client_not_api.dart';
import 'package:student_hub/utils/utils.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/widgets/custom_dialog.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static IO.Socket? socket;
  var idUser = -1;
  var isLoading = true;
  List<dynamic> notifications = [];
  static String baseURL = 'https://api.studenthub.dev';

  final ScrollController _scrollController = ScrollController();
  final TextEditingController codeRoom = TextEditingController();

  @override
  void initState() {
    super.initState();
    getIDUser();
  }

  void initSocket() async {
    socket = IO.io(
      baseURL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    socket!.io.options!['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    socket!.connect();

    socket!.onConnect((data) {
      print('Connected 2');
    });

    socket!.on('NOTI_$idUser', (data) {
      if (mounted) {
        setState(() {
          notifications.insert(0, data['notification']);
          scrollToTop();
        });
      }
    });
  }

  void getIDUser() async {
    final dioPrivate = DioClient();

    final responseIdUser = await dioPrivate.request(
      '/auth/me',
      options: Options(
        method: 'GET',
      ),
    );

    final user = responseIdUser.data['result'];

    setState(() {
      if (user['roles'][0] == 0) {
        idUser = user['student']['userId'];
      } else {
        idUser = user['company']['userId'];
      }
      initSocket();
      getListNotify();
    });
  }

  void getListNotify() async {
    final dioPrivate = DioClient();

    final responseListNotify = await dioPrivate.request(
      '/notification/getByReceiverId/$idUser',
      options: Options(
        method: 'GET',
      ),
    );

    final listNotify = responseListNotify.data['result'];

    setState(() {
      listNotify.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));

      notifications = listNotify;

      isLoading = false;
    });
  }

  void updateNotifi(int id, int index) async {
    final dioPrivate = DioClient();

    final responseListNotify = await dioPrivate.request(
      '/notification/readNoti/$id',
      options: Options(
        method: 'PATCH',
      ),
    );

    if (responseListNotify.statusCode == 200) {
      setState(() {
        notifications[index]['notifyFlag'] = "1";
      });
    }
  }

  void checkValidateRoom(String meetingRoomId, String meetingRoomCode) async {
    try {
      final dio = DioClientNotAPI();
      final response = await dio.request(
        '/meeting-room/check-availability',
        queryParameters: {
          "meeting_room_code": codeRoom.text,
          "meeting_room_id": meetingRoomId,
        },
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        if (response.data['result'] == true) {
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, AppRouterName.meetingRoom,
              arguments: meetingRoomCode);
        } else {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => DialogCustom(
              title: "Warning",
              description: "Code room not exits.",
              buttonText: 'OK',
              statusDialog: 4,
              onConfirmPressed: () {
                Navigator.pop(context);
              },
            ),
          );
        }
      }
    } catch (e) {
      // Nếu có lỗi xảy ra trong quá trình gọi API, in ra lỗi để debug
      print('Error checking room availability: $e');
    }
  }

  void _showEnterCodeRoomModal(
      BuildContext context, String meetingRoomId, String meetingRoomCode) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            dialogTheme: DialogTheme(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              // backgroundColor: Colors.white,
            ),
          ),
          child: AlertDialog(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                BuildTextField(
                  controller: codeRoom,
                  inputType: TextInputType.text,
                  onChange: () {},
                  fillColor: Theme.of(context).canvasColor,
                  hint: "Enter code room",
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    checkValidateRoom(meetingRoomId, meetingRoomCode);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: kWhiteColor,
                      minimumSize: Size.zero,
                      foregroundColor: kBlue700),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Text(LocaleData.confirm.getString(context)),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  String formatTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      if (difference.inDays == 1) {
        return '1 ${LocaleData.dayAgo.getString(context)}';
      } else {
        return '${difference.inDays} ${LocaleData.dayAgo.getString(context)}';
      }
    } else if (difference.inHours > 0) {
      if (difference.inHours == 1) {
        return '1 ${LocaleData.hoursAgo.getString(context)}';
      } else {
        return '${difference.inHours} ${LocaleData.hoursAgo.getString(context)}';
      }
    } else if (difference.inMinutes > 0) {
      if (difference.inMinutes == 1) {
        return '1 ${LocaleData.minutesAgo.getString(context)}';
      } else {
        return '${difference.inMinutes} ${LocaleData.minutesAgo.getString(context)}';
      }
    } else {
      if (difference.inSeconds == 1) {
        return '1 ${LocaleData.secondsAgo.getString(context)}';
      } else {
        return '${difference.inSeconds} ${LocaleData.secondsAgo.getString(context)}';
      }
    }
  }

  String formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    final dateFormat = DateFormat('EEEE, d/M/yyyy HH:mm');

    return dateFormat.format(dateTime);
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = context.deviceSize;
    final Brightness brightness = Theme.of(context).brightness;
    Color? color = (brightness == Brightness.light)
        ? Colors.grey[300]
        : const Color.fromARGB(255, 243, 231, 231);

    return SafeArea(
      child: isLoading
          ? const LoadingWidget()
          : Scaffold(
              appBar: null,
              body: notifications.isNotEmpty
                  ? ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(10.0),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => {
                            if (notifications[index]['notifyFlag'] == "0")
                              {
                                if (notifications[index]['content']
                                    .contains("proposal"))
                                  {
                                    updateNotifi(
                                        notifications[index]['id'], index),
                                  }
                                else
                                  {
                                    updateNotifi(
                                        notifications[index]['id'], index),
                                    Navigator.of(context).pushNamed(
                                        AppRouterName.chatScreen,
                                        arguments: {
                                          'idProject': notifications[index]
                                              ['message']['projectId'] as int,
                                          'idThisUser': notifications[index]
                                              ['message']['receiverId'] as int,
                                          'idAnyUser': notifications[index]
                                              ['message']['senderId'] as int,
                                          'name': notifications[index]['sender']
                                              ['fullname'] as String,
                                        })
                                  }
                              }
                          },
                          child: Card(
                            color: notifications[index]['notifyFlag'] == "0"
                                ? Theme.of(context).cardColor
                                : color,
                            elevation: 2.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(notifications[index]['content'] ==
                                              "New message created"
                                          ? Icons.message
                                          : notifications[index]['content']
                                                  .contains('Interview')
                                              ? Icons.event_available
                                              : Icons.settings),
                                      const SizedBox(width: 16.0),
                                      if (notifications[index]['content'] ==
                                          "New message created")
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${LocaleData.notificationMessage.getString(context)} • ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  formatTimeAgo(
                                                      notifications[index]
                                                          ['createdAt']),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  "${notifications[index]['sender']['fullname']}: ",
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: deviceSize.width * 0.4,
                                                  child: Text(
                                                    "${notifications[index]['message']['content']}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      else if (notifications[index]['content']
                                          .contains('Interview'))
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${LocaleData.notificationEventStart.getString(context)} • ',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  formatTimeAgo(
                                                      notifications[index]
                                                          ['updatedAt']),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${notifications[index]['sender']['fullname']}: ",
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: deviceSize.width * 0.4,
                                                  child: Text(
                                                    "${notifications[index]['message']['interview']['title']}",
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 13.0,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Start Time: ",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  formatDateTime(
                                                      notifications[index]
                                                                  ['message']
                                                              ['interview']
                                                          ['endTime']),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "End Time: ",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  formatDateTime(
                                                      notifications[index]
                                                                  ['message']
                                                              ['interview']
                                                          ['startTime']),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Code Room: ",
                                                  style: TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  "${notifications[index]['message']['interview']['meetingRoom']['meeting_room_code']}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      else
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Proposal mới • ',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  formatTimeAgo(
                                                      notifications[index]
                                                          ['updatedAt']),
                                                  style: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 13),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: deviceSize.width * 0.7,
                                                  child: Text(
                                                    "${notifications[index]['content']}",
                                                    style: const TextStyle(
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                    ],
                                  ),
                                  if (notifications[index]['content']
                                      .contains("Interview")) ...[
                                    const SizedBox(height: 10.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  notifications[index]
                                                              ['notifyFlag'] ==
                                                          "0"
                                                      ? Colors.blue
                                                      : Colors.grey),
                                          onPressed: () {
                                            if (notifications[index]
                                                    ['notifyFlag'] ==
                                                "0") {
                                              _showEnterCodeRoomModal(
                                                  context,
                                                  notifications[index]
                                                                  ['message']
                                                              ['interview']
                                                          ['meetingRoom']
                                                      ['meeting_room_id'],
                                                  notifications[index]
                                                                  ['message']
                                                              ['interview']
                                                          ['meetingRoom']
                                                      ['meeting_room_code']);
                                            }
                                          },
                                          child: Text(
                                            LocaleData.joinBtn
                                                .getString(context),
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(LocaleData.emptyNoti.getString(context)),
                    ),
            ),
    );
  }
}
