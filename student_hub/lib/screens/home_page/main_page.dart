import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/data/student_user.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/dashboard/dashboard.dart';
import 'package:student_hub/screens/notification/notification.dart';
import 'package:student_hub/screens/chat/message_list.screen.dart';

class MainPage extends StatefulWidget {
  final CompanyUser? companyUser;
  final StudentUser? studentUser;
  const MainPage({
    super.key,
    this.companyUser,
    this.studentUser,
  });

  @override
  State<MainPage> createState() => _BuildMainPage();
}

class _BuildMainPage extends State<MainPage> {
  late List<Widget> _pages;
  final MainBottomNavigationController _navController =
      MainBottomNavigationController();
  @override
  void initState() {
    super.initState();
    _pages = [
      ProjectListScreen(),
      Dashboard(widget.studentUser, widget.companyUser),
      MessageListScreen(),
      NotificationPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, //this is to extend the body behind the appbar
      appBar: null,
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return PageView(
      controller: _navController.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: _pages,
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      color: kWhiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
        child: GNav(
          backgroundColor: kWhiteColor,
          color: Colors.black.withOpacity(0.7),
          activeColor: kWhiteColor,
          // tabBackgroundGradient: LinearGradient(
          //             begin: Alignment.,
          //             end: Alignment.,
          //             colors: [Colors.lightBlue[100]!, Colors.cyan],
          //           ),
          tabBackgroundGradient: const LinearGradient(
            begin: Alignment.bottomLeft, // Equivalent to 90 degrees
            end: Alignment.centerRight,
            colors: [
              Color(0xFF020024), // rgba(2, 0, 36, 1)
              Color(0xFF090979), // rgba(9, 9, 121, 1)
              Color(0xFF00D4FF), // rgba(0, 212, 255, 1)
            ],
            stops: [0.0, 0.35, 1.0], // Color stops at 0%, 35%, and 100%
          ),
          gap: 5,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          tabs: const [
            GButton(
              icon: Icons.edit_document,
              text: 'Projects',
            ),
            GButton(
              icon: Icons.space_dashboard,
              text: 'Dashboard',
            ),
            GButton(
              icon: Icons.messenger,
              text: 'Message',
            ),
            GButton(
              icon: Icons.notifications,
              text: 'Alerts',
            ),
          ],
          selectedIndex: _navController.selectedIndex,
          onTabChange: (index) {
            setState(() {
              _navController.selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class MainBottomNavigationController {
  final PageController _pageController = PageController(initialPage: 1);
  int _selectedIndex = 1;

  void navigateTo(int index) {
    _pageController.jumpToPage(index);
    _selectedIndex = index;
  }

  int get currentIndex => _pageController.page?.round() ?? 0;

  PageController get controller => _pageController;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    navigateTo(index);
  }
}

void main() {
  runApp(const MaterialApp(
    home: MainPage(),
  ));
}
