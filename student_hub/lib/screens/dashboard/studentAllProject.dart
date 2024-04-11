import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/services/dio_client.dart';

class StudentAllProject extends StatefulWidget {
  const StudentAllProject({super.key});

  @override
  State<StudentAllProject> createState() => _StudentAllProjectState();
}

class _StudentAllProjectState extends State<StudentAllProject>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var created = false;
  var idStudent = -1;
  List<dynamic> projects = [];
  List<dynamic> projectsWorking = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDataDefault();
  }

  void getDataIdStudent() async {
    final dioPrivate = DioClient();

    final responseProject = await dioPrivate.request(
      '/proposal/project/$idStudent',
      options: Options(
        method: 'GET',
      ),
    );

    final project = responseProject.data['result'];

    setState(() {
      projects = project;
      projectsWorking =
          project.where((item) => item['project']['typeFlag'] == 0).toList();
    });
  }

  void getDataDefault() async {
    try {
      final dioPrivate = DioClient();

      final responseUser = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );

      final user = responseUser.data['result'];

      setState(() {
        if (user['student'] == null) {
          created = false;
        } else {
          created = true;
          final student = user['student'];
          idStudent = student['id'];
          getDataIdStudent();
        }
      });
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  String formatTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} days ago';
    } else {
      if (difference.inHours < 1) {
        int minutesDifference = difference.inMinutes;
        return '$minutesDifference minutes ago';
      } else {
        int hoursDifference = difference.inHours;
        return '$hoursDifference hours ago';
      }
    }
  }

  String? formatTimeProject(int type) {
    if (type == 0) {
      return '• Less than 1 month';
    } else if (type == 1) {
      return '• 1 to 3 months';
    } else if (type == 2) {
      return '• 3 to 6 months';
    } else if (type == 3) {
      return '• More than 6 months';
    }
    return null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                  _allProject(),
                  _working(),
                  const Center(child: Text('Archieved')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'All projects'),
        Tab(text: 'Working'),
        Tab(text: 'Archieved'),
      ],
    );
  }

  //allProject
  Widget _allProject() {
    return Column(
      children: [
        Container(
          child: _activeProposal(),
        ),
        Expanded(
          child: _submittedProposal(),
        ),
      ],
    );
  }

  Widget _activeProposal() {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: double.infinity,
          child: const Text(
            "Active Proposal (0)",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _submittedProposal() {
    return Expanded(
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Submitted Proposal (0)",
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: projects.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildProjectItem(index);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectItem(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projects[index]['project']['title'],
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Submitted ${formatTimeAgo(projects[index]['createdAt'])}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '•',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      projects[index]['project']['description'],
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //working
  Widget _working() {
    return Expanded(
      child: ListView.builder(
        itemCount: projectsWorking.length,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _buildWorkingProjectItem(index);
        },
      ),
    );
  }

  Widget _buildWorkingProjectItem(int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      projectsWorking[index]['project']['title'],
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${formatTimeProject(projectsWorking[index]['project']['projectScopeFlag'])}, ${projectsWorking[index]['project']['numberOfStudents']} students',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13.0,
                      ),
                    ),
                  ],
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
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    '•',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      projectsWorking[index]['project']['description'],
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
