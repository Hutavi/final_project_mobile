import 'package:flutter/material.dart';
import 'package:student_hub/routers/route.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/screens/switch_account_page/switch_account.dart';

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
      // home: ProjectListPage(),
      // home: CreateProjectTask(),
      // home: CalendarPage(),
      // home: DetailProjectPage(),
      // home: CreateReportPage(),
      home: SwitchAccount(),
      // initialRoute: '/homePage',
      // home: DetailProjectPage(),
      // darkTheme: AppThemes.darkTheme,
      
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }
}
