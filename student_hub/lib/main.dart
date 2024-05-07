import 'package:flutter/material.dart';
import 'package:student_hub/app.dart';
// import 'package:student_hub/screens/switch_account_page/switch_account.dart';
// import 'package:student_hub/screens/profile_page/profile_input_company.dart';
// import 'package:student_hub/screens/dashboard/dashboard.dart';
// import 'package:student_hub/screens/profile_page/edit_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/services/socket.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SocketManager.initializeSocket();
  SocketManager.recieveMessage();

  runApp(const ProviderScope(child: MyApp()));
}
