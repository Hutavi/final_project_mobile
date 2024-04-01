import 'package:flutter/material.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/bottomNavigationBar.dart';
import 'package:student_hub/screens/home_page/main_page.dart';
import 'package:student_hub/screens/dashboard/studentAllProject.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/data/student_user.dart';

class Dashboard extends StatefulWidget {
  final StudentUser? studentUser;
  final CompanyUser? companyUser;
  const Dashboard(this.studentUser, this.companyUser, {super.key});

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.companyUser == null &&
    //     widget.studentUser == null) {
    //   // Nếu người dùng không phải là CompanyUser và không phải studentUser, chuyển hướng hoặc hiển thị thông báo
    //   return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Error'),
    //     ),
    //     body: const Center(
    //       child: Text('You are not authorized to access this screen.'),
    //     ),
    //   );
    // }
    if (widget.studentUser != null) {
      //Nếu người dùng là studentUser, hiển thị giao diện dành cho studentUser
      return Scaffold(
        // appBar:
        appBar: const AppBarCustom(title: "Student Hub"),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 16.0, bottom: 0, left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Your Project',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouterName.postScreen1);
                    },
                    child: const Text(
                      'Post a projects',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            //nội dung của student dashboard
            const studentAllProject(),
          ],
        ),
        // bottomNavigationBar: const studentBottomNavigationBar(),
      );
    }
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 0, left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Project',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.postScreen1);
                  },
                  child: const Text(
                    'Post a projects',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildTabBar(),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProjectList(),
                        // Center(child: _buildProjectList),
                        const Center(child: Text('Working')),
                        const Center(child: Text('Archieved')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const bottomNavigationBar(),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      controller: _tabController,
      tabs: const [
        Tab(text: 'All projects'),
        Tab(text: 'Working'),
        Tab(text: 'Archieved'),
      ],
    );
  }

  Widget _buildProjectList() {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildProjectItem(index);
        },
      ),
    );
  }

  void _showPopupMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ListTile(
                // leading: const Icon(Icons.pending_outlined),
                title: const Text('View proposals'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View messages'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View hired'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('View job posting'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Edit posting'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Remove posting'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Start working this project'),
                onTap: () {
                  Navigator.pop(context);
                  _tabController.animateTo(1);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectItem(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRouterName.sendHired);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Senior frontend developer (Fintech)',
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '3 days ago',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      _showPopupMenu(context);
                    },
                    icon: const Icon(Icons.pending_outlined,
                        size: 25, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Students are looking for',
                style: TextStyle(
                  fontSize: 13.0,
                ),
              ),
              const SizedBox(height: 8.0),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      '•',
                      style: TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Clear expectations about the project or deliverables',
                        style: TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('2'),
                  Text('8'),
                  Text('2'),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Proposals'),
                  Text('Message'),
                  Text('Hired'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
