import 'package:flutter/material.dart';
import 'package:student_hub/routers/route.dart';
import 'package:student_hub/screens/auth_page/login_screen.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/dashboard/dashboard.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/screens/switch_account_page/switch_account.dart';
import 'package:student_hub/screens/post/post_screen_1.dart';

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
      home: SwitchAccount(),
      // home: LoginScreen(),
      // home: ProjectListScreen(),
      // home: Dashboard(),
      // initialRoute: '/homePage',
      // darkTheme: AppThemes.darkTheme,
      // home: PostScreen1(),

      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
