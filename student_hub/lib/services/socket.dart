import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:student_hub/services/dio_client.dart';

class SocketManager {
  static IO.Socket? socket;
  static String baseURL = 'http://34.16.137.128/api';

  static void initializeSocket() {
    final dioPrivate = DioClient();

    String token = dioPrivate.accessToken;

    socket = IO.io(
      baseURL,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    socket!.io.options!['extraHeaders'] = {
      'Authorization': 'Bearer $token',
    };

    // socket!.io.options!['query'] = {
    //   'project_id': projectId,
    // };

    socket!.connect();

    socket!.onConnect((data) {
      print('Connected');
    });

    socket!.onDisconnect((data) {
      print('Disconnected');
    });

    socket!.onConnectError((data) => print('$data'));
    socket!.onError((data) => print(data));

    //Listen to channel receive message
    socket!.on('RECEIVE_MESSAGE', (data) {
      // Your code to update ui
    });

    //Listen for error from socket
    socket!.on("ERROR", (data) => print(data));
  }

  static void addQueryParameter(int projectId) {
    if (socket != null) {
      socket!.io.options!['query'] = {
        'project_id': projectId,
      };
    }
  }

  static void sendMessage(String message, int projectId, int senderId,
      int receiverId, int messageFlag) {
    addQueryParameter(projectId);

    // Gửi tin nhắn
    socket!.emit("SEND_MESSAGE", {
      "content": message,
      "projectId": projectId,
      "senderId": senderId,
      "receiverId": receiverId,
      "messageFlag": messageFlag,
    });
  }
}
