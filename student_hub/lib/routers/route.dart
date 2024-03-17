import 'package:flutter/material.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/auth_page/register_by_screen.dart';
import 'package:student_hub/screens/auth_page/register_role_screen.dart';
import 'package:student_hub/screens/browser_page/project_detail.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/browser_page/project_saved.dart';
import 'package:student_hub/screens/browser_page/project_search.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/screens/student_profile_s1/student_profile_s1.dart';
import 'package:student_hub/screens/student_profile_s2/student_profile_s2.dart';
import 'package:student_hub/screens/student_profile_s3/student_profile_s3.dart';
import 'package:student_hub/screens/switch_account_page/switch_account.dart';

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

      case AppRouterName.projectList:
        return MaterialPageRoute(builder: (_) => const ProjectListScreen());

      case AppRouterName.projectSaved:
        return MaterialPageRoute(builder: (_) => const SavedProject());

      case AppRouterName.projectSearch:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProjectSearch(
            query: args,
          ),
        );

      case AppRouterName.projectDetail:
        final args = settings.arguments as ProjectModel;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProjectDetail(
            projectItem: args,
          ),
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
