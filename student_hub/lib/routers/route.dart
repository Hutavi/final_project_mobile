import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/auth_page/register_by_screen.dart';
import 'package:student_hub/screens/auth_page/register_role_screen.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/screens/profile_page/profile_input_company.dart';
import 'package:student_hub/screens/student_profile_s1/student_profile_s1.dart';
import 'package:student_hub/screens/student_profile_s2/student_profile_s2.dart';
import 'package:student_hub/screens/student_profile_s3/student_profile_s3.dart';
import 'package:student_hub/screens/switch_account_page/switch_account.dart';
import 'package:student_hub/screens/post/post_screen_1.dart';
import 'package:student_hub/screens/post/post_screen_2.dart';
import 'package:student_hub/screens/post/post_screen_3.dart';
import 'package:student_hub/screens/post/post_screen_4.dart';

// import 'package:todolist_app/main.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    //Biến args cho biến Object
    final args = settings.arguments;

    switch (settings.name) {
      case AppRouterName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRouterName.profileS1:
        return MaterialPageRoute(
            builder: (_) => const StundentProfileS1(
                  selectedValue: 'Fullstack Engineer',
                ));

      case AppRouterName.profileS2:
        return MaterialPageRoute(builder: (_) => const StundentProfileS2());

      case AppRouterName.profileS3:
        return MaterialPageRoute(builder: (_) => const StundentProfileS3());

      case AppRouterName.register:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const RegisterChoiceRoleScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      //Mẫu hiệu ứng chuyển trang có sử dụng tham số
      case AppRouterName.registerBy:
        final args = settings.arguments as bool;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              RegisterByScreen(radioValue: args),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

      case AppRouterName.switchAccount:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const SwitchAccount(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
      
      case AppRouterName.profileInput:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfileInput(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

        case AppRouterName.postScreen1:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PostScreen1(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

        case AppRouterName.postScreen2:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PostScreen2(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
        
        case AppRouterName.postScreen3:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PostScreen3(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

        case AppRouterName.postScreen4:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const PostScreen4(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
            const curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );

    }
    return _errPage();
  }

  static Route _errPage() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('No Router! Please check your configuration'),
        ),
      );
    });
  }
}
