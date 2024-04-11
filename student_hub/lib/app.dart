import 'package:flutter/material.dart';
import 'package:student_hub/routers/route.dart';
import 'package:student_hub/screens/auth_page/login_screen.dart';
// import 'package:student_hub/screens/browser_page/project_list.dart';
// import 'package:student_hub/screens/chat/chat.dart';
// import 'package:student_hub/screens/dashboard/dashboard.dart';
// import 'package:student_hub/screens/home_page/home_page.dart';
// import 'package:student_hub/widgets/navigation_menu.dart';
// import 'package:student_hub/screens/notification/notification.dart';
// import 'package:student_hub/screens/switch_account_page/switch_account.dart';
// import 'package:student_hub/screens/post/post_screen_1.dart';
// import 'package:student_hub/screens/welcome_screen.dart';
// import 'package:student_hub/widgets/schedule_invite.dart';
// import 'package:student_hub/widgets/schedule_message.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Management App',
      debugShowCheckedModeBanner: false,
      // theme: AppThemes.lightTheme,
      // initialRoute: '/navigation',
      // home: SwitchAccount(),
      home: LoginScreen(),
      // home: ProjectListScreen(),
      // home: NotificationPage(),
      // home: Dashboard(),
      // initialRoute: '/homePage',
      // darkTheme: AppThemes.darkTheme,
      // home: PostScreen1(),
      // home: ScheduleInviteTicket(),
      // home: ProjectListScreen(),
      // home: ChatRoomScreen(),
      // home: HomePage(),
      // home: MainPage(),
      // home: WelcomeScreen(),
      // home: HomePage(),

      // home: NavigationMenu(),
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
