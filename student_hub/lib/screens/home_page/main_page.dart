import 'package:flutter/material.dart';
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
  final int index;
  // final index;
  const MainPage({
    super.key,
    this.companyUser,
    this.studentUser,
    required this.index,
  });

  @override
  State<MainPage> createState() => _BuildMainPage();
}

class _BuildMainPage extends State<MainPage> {
  late List<Widget> _pages;
  final MainBottomNavigationController _navController =
      MainBottomNavigationController();
  final CompanyBottomNavigationController _companyNavController =
      CompanyBottomNavigationController();
  @override
  void initState() {
    super.initState();
    _pages = [
      const ProjectListScreen(),
      Dashboard(widget.studentUser, widget.companyUser),
      const MessageListScreen(),
      const NotificationPage(),
    ];
    // _navController.selectedIndex = widget.index;
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
    if(widget.index == 0){
      return PageView(
        controller: _companyNavController.controller,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages);
        
    }
    return PageView(
      controller: _navController.controller,
      physics: const NeverScrollableScrollPhysics(),
      children: _pages,
      );
  }

  Widget _buildBottomNavigationBar() {
    if(widget.index == 0){
      return Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            backgroundColor: Colors.grey[200]!,
            color: Colors.grey[400],
            activeColor: Colors.black.withOpacity(0.7),
            tabBackgroundColor: Colors.grey[200]!,
            gap: 4,
            padding: const EdgeInsets.all(12),
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
            selectedIndex: _companyNavController.selectedIndex,
            onTabChange: (index) {
              setState(() {
                _companyNavController.selectedIndex = index;
              });
            },
          ),
        ),
      );
    }
    return Container(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            backgroundColor: Colors.grey[200]!,
            color: Colors.grey[400],
            activeColor: Colors.black.withOpacity(0.7),
            tabBackgroundColor: Colors.grey[200]!,
            gap: 4,
            padding: const EdgeInsets.all(12),
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

class CompanyBottomNavigationController {
  final PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

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

// void main() {
//   runApp(const MaterialApp(
//     home: MainPage(),
//   ));
// }
