import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/services/message_queue.dart';

class SocketManager {
  static IO.Socket? socket;
  static String baseURL = 'https://api.studenthub.dev';

  static void initializeSocket() async {
    socket = IO.io(
      baseURL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('accessToken');

    // Add authorization to header
    socket!.io.options!['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    // socket!.io.options!['query'] = {
    //   'project_id': 560,
    // };

    // socket!.connect();

    // socket!.onConnect((data) {
    //   print('Connected');
    // });

    // socket!.onDisconnect((data) {
    //   print('Disconnected');
    // });

    // socket!.onConnectError((data) => print('$data'));
    // socket!.onError((data) => print(data));
  }

  static void connect() {
    if (socket != null) socket!.disconnect();

    socket!.connect();

    socket!.onConnect((data) {
      print('Connected');
    });

    socket!.onDisconnect((data) {
      print('Disconnected');
    });
  }

  static void addQueryParameter(int projectId) {
    if (socket != null) {
      socket!.io.options!['query'] = {
        'project_id': projectId,
      };
    }
  }

  static void recieveNotify() async {
    final prefs = await SharedPreferences.getInstance();
    final idUser = prefs.getInt('idUser');

    socket!.on('NOTI_$idUser', (data) {
      Fluttertoast.showToast(
        msg: 'Bạn có 1 thông báo mới',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }

  static void recieveMessage() async {
    socket!.on('RECEIVE_MESSAGE', (data) {
      MessageQueueService.addMessage(data);
    });
  }

  static void sendMessage(String message, int projectId, int senderId,
      int receiverId, int messageFlag) {
    addQueryParameter(projectId);

    // Send message
    socket!.emit("SEND_MESSAGE", {
      "content": message,
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId,
      "messageFlag": messageFlag,
    });
  }
}
