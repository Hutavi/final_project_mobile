import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/widgets/loading.dart';

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

  @override
  void initState() {
    super.initState();
    getIDUser();
    connectSocket();
  }

  void connectSocket() async {
    if (socket != null && mounted) {
      socket!.on('RECEIVE_MESSAGE', (data) {
        setState(() {
          getIDUser();
        });
      });
    }
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

  String formatTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${LocaleData.dayAgo.getString(this.context)}';
    } else {
      if (difference.inHours < 1) {
        int minutesDifference = difference.inMinutes;
        return '$minutesDifference ${LocaleData.minutesAgo.getString(context)}';
      } else {
        int hoursDifference = difference.inHours;
        return '$hoursDifference ${LocaleData.hoursAgo.getString(context)}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isLoading
          ? const LoadingWidget()
          : Scaffold(
              appBar: null,
              body: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2.0,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(notifications[index]['content'] ==
                                      "New message created"
                                  ? Icons.message
                                  : Icons.event_available),
                              const SizedBox(width: 16.0),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    notifications[index]['content'] ==
                                            "New message created"
                                        ? "${LocaleData.notificationMessage.getString(context)} ${notifications[index]['sender']['fullname']}"
                                        : "${LocaleData.notificationEventStart.getString(context)} ${notifications[index]['sender']['fullname']}",
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    notifications[index]['content'] ==
                                            "New message created"
                                        ? "${notifications[index]['message']['content']}"
                                        : "${LocaleData.notificationEventStart.getString(context)} ${notifications[index]['sender']['fullname']}",
                                    style: const TextStyle(
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            formatTimeAgo(notifications[index]['updatedAt']),
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 13),
                          ),
                          if (notifications[index]['content'] !=
                              "New message created") ...[
                            const SizedBox(height: 16.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue),
                              onPressed: () {
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
                                    });
                              },
                              child: Text(
                                LocaleData.joinBtn.getString(context),
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
