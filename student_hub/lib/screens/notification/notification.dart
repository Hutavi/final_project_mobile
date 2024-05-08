import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/services/dio_client.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  static IO.Socket? socket;
  var idUser = -1;
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
      notifications = listNotify;
      print(notifications);
    });
  }

  // @override
  // Widget build(BuildContext context) {
  //   return SafeArea(
  //     child: Scaffold(
  //       appBar: null,
  //       body: ListView(
  //         padding: const EdgeInsets.all(10.0),
  //         children: const [
  //           NotificationCard(
  //             icon: Icons.notifications,
  //             text: 'You have a new message',
  //             time: '10:00 AM',
  //           ),
  //           SizedBox(height: 8.0),
  //           NotificationCard(
  //             icon: Icons.event_available,
  //             text: 'Your event starts soon',
  //             time: '12:00 PM',
  //             showButton: true,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: null,
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: notifications.length, // Số lượng thông báo trong danh sách
          itemBuilder: (context, index) {
            // Tạo widget NotificationCard từ mỗi thông báo trong danh sách
            return NotificationCard(
              icon: Icons.notifications,
              text: notifications[index]['content'],
              time: notifications[index]['updatedAt'],
              showButton: true,
            );
          },
        ),
      ),
    );
  }
}

class NotificationCard extends StatelessWidget {
  final IconData icon;
  final String text;
  final String time;
  final bool showButton;

  const NotificationCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.time,
    this.showButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                Icon(icon),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              time,
              style: const TextStyle(color: Colors.grey),
            ),
            if (showButton) ...[
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle button press
                },
                child: Text(LocaleData.joinBtn.getString(context)),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
