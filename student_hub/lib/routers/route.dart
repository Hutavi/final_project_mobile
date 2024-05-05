import 'package:flutter/material.dart';
import 'package:student_hub/models/chat/user.dart';
import 'package:student_hub/models/company_user.dart';
import 'package:student_hub/models/project_models/project_model_favourite.dart';
import 'package:student_hub/models/user.dart' as USER;
import 'package:student_hub/models/project_models/project_model.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/auth_page/forgot_password_screen.dart';
import 'package:student_hub/screens/auth_page/login_screen.dart';
import 'package:student_hub/screens/auth_page/register_by_screen.dart';
import 'package:student_hub/screens/auth_page/register_role_screen.dart';
import 'package:student_hub/screens/browser_page/project_detail.dart';
import 'package:student_hub/screens/browser_page/project_detail_favourite.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/browser_page/project_saved.dart';
import 'package:student_hub/screens/browser_page/project_search.dart';
import 'package:student_hub/screens/browser_page/submit_proposal.dart';
import 'package:student_hub/screens/chat/chat.dart';
import 'package:student_hub/screens/home_page/home_page.dart';
import 'package:student_hub/screens/notification/notification.dart';
import 'package:student_hub/screens/post/edit_project.dart';
import 'package:student_hub/screens/profile_page/edit_profile.dart';
import 'package:student_hub/screens/profile_page/profile_input_company.dart';
import 'package:student_hub/screens/schedule_interview/video_conference_screen.dart';
import 'package:student_hub/screens/student_profile/student_profile_s1.dart';
import 'package:student_hub/screens/student_profile/student_profile_s2.dart';
import 'package:student_hub/screens/student_profile/student_profile_s3_resume.dart';
import 'package:student_hub/screens/student_profile/student_profile_s3_transcript.dart';
import 'package:student_hub/screens/switch_account_page/switch_account.dart';
import 'package:student_hub/screens/post/post_screen_1.dart';
import 'package:student_hub/screens/post/post_screen_2.dart';
import 'package:student_hub/screens/post/post_screen_3.dart';
import 'package:student_hub/screens/post/post_screen_4.dart';
import 'package:student_hub/screens/post/review_post.dart';
import 'package:student_hub/widgets/navigation_menu.dart';
import 'package:student_hub/screens/welcome_screen.dart';
// import 'package:todolist_app/main.dart';

class AppRoute {
  static Route onGenerateRoute(RouteSettings settings) {
    //Biến args cho biến Object
    final args = settings.arguments;

    switch (settings.name) {
      case AppRouterName.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());

      case AppRouterName.profileS1:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const StudentProfileS1(),
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

      case AppRouterName.profileS2:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const StundentProfileS2(),
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

      case AppRouterName.profileS3Resume:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const StundentProfileS3Resume(),
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

      case AppRouterName.profileS3Transcript:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const StundentProfileS3Transcript(),
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

      case AppRouterName.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case AppRouterName.forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

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
              RegisterByScreen(isStudent: args),
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
      case AppRouterName.reviewPost:
        final args = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => ReviewPost(
            projectID: args,
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

      case AppRouterName.editPoject:
        final args = settings.arguments as int;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EditProject(
            projectID: args,
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

      case AppRouterName.projectList:
        return MaterialPageRoute(builder: (_) => const ProjectListScreen());

      case AppRouterName.projectSaved:
        return MaterialPageRoute(builder: (_) => const SavedProject());
      case AppRouterName.navigation:
        return MaterialPageRoute(builder: (_) => const NavigationMenu());

      case AppRouterName.projectSearch:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => ProjectSearch(
            query: args,
          ),
        );

      case AppRouterName.projectDetail:
        final args = settings.arguments as ProjectForListModel;

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
      case AppRouterName.projectDetailFavorite:
        final args = settings.arguments as ProjectFavourite;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ProjectDetailFavorite(
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

      case AppRouterName.meetingRoom:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => VideoConferencePage(
            conferenceID: args,
          ),
        );

      case AppRouterName.chatScreen:
        final args = settings.arguments as Map<String, dynamic>;

        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              ChatRoomScreen(
                  idProject: args['idProject']!,
                  idThisUser: args['idThisUser']!,
                  idAnyUser: args['idAnyUser']!,
                  name: args['name']!),
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
      case AppRouterName.messageList:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MessageListScreen(),
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
      case AppRouterName.notification:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const NotificationPage(),
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

      case AppRouterName.submitProposal:
        final args = settings.arguments as ProjectForListModel;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              SubmitProposal(
            projectId: args,
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
      case AppRouterName.editProfileCompany:
        final args = settings.arguments as CompanyUser;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => EditProfile(
            companyInfo: args,
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
      case AppRouterName.welcomeScreen:
        // final args = settings.arguments as CompanyUser;
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const WelcomeScreen(
                  // companyInfo: args,
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
