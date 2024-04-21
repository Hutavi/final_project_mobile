import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  List<dynamic> submittedProposal = [];
  List<dynamic> activeProposal = [];    //statusFlag = 1
  List<dynamic> projectsWorking = [];   //typeFlag = 0
  List<dynamic> projectsArchieved = []; //typeFlag = 1

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
      submittedProposal = 
                        project.where((item) => item['statusFlag'] == 0).toList();
      activeProposal = 
                        project.where((item) => item['statusFlag'] == 1).toList();
      projectsWorking = 
                        project.where((item) => item['project']['typeFlag'] == 0).toList();
      projectsArchieved = 
                        project.where((item) => item['project']['typeFlag'] == 1).toList();
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
                  _archieved(),
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
        Expanded(
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Active Proposal (${activeProposal.length})",
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
                itemCount: activeProposal.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildActivityProposalItem(index);
                },
              ),
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildActivityProposalItem(int index){
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
                      activeProposal[index]['project']['title'],
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Submitted ${formatTimeAgo(activeProposal[index]['createdAt'])}',
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
                      activeProposal[index]['project']['description'],
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
  Widget _submittedProposal() {
    return Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "Submitted Proposal (${submittedProposal.length})",
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
                  itemCount: submittedProposal.length,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _buildProjectItem(index);
                  },
                ),
              ),
            ],
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
                      submittedProposal[index]['project']['title'],
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      'Submitted ${formatTimeAgo(submittedProposal[index]['createdAt'])}',
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
                      submittedProposal[index]['project']['description'],
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
    return ListView.builder(
      itemCount: projectsWorking.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildWorkingProjectItem(index);
      },
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
  
  Widget _archieved() {
    return ListView.builder(
      itemCount: projectsArchieved.length,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildArchievedProjectItem(index);
      },
    );
  }

  Widget _buildArchievedProjectItem(int index){
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
                      projectsArchieved[index]['project']['title'],
                      style: const TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '${formatTimeProject(projectsArchieved[index]['project']['projectScopeFlag'])}, ${projectsArchieved[index]['project']['numberOfStudents']} students',
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
                      projectsArchieved[index]['project']['description'],
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
