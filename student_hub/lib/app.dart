import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
// import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route.dart';
// import 'package:student_hub/screens/auth_page/login_screen.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/utils/theme/theme.dart';
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
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    configureLocalization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StudentHub',
      debugShowCheckedModeBanner: false,
      // theme: AppThemes.lightTheme,
      // home: const LoginScreen(),
      home: const HomePage(),
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.system,
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
      onGenerateRoute: AppRoute.onGenerateRoute,
    );
  }

  void configureLocalization() {
    localization.init(mapLocales: LOCALES, initLanguageCode: "vi");
    localization.onTranslatedLanguage = onTranslatedLanguage;
  }

  void onTranslatedLanguage(Locale? locale) {
    setState(() {});
  }
}
