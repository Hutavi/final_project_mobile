import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/screens/dashboard/detail_proposal.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/constants/colors.dart';

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
                        project.where((item) => item['project']['typeFlag'] == 1).toList();
      projectsArchieved = 
                        project.where((item) => item['project']['typeFlag'] == 2
                        // && item['project']['statusFlag'] == 3
                        ).toList();
    });
  }

  void readProposal(){

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
        // ignore: avoid_print
        print(e);
      } else {
        // ignore: avoid_print
        print('Have Error: $e');
      }
    }
  }

  String formatTimeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime now = DateTime.now();
    Duration difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${LocaleData.dayAgo.getString(context)}';
    } else {
      if (difference.inHours < 1) {
        int minutesDifference = difference.inMinutes;
        return '$minutesDifference ${LocaleData.minutesAgo.getString(context)}';
      } else {
        int hoursDifference = difference.inHours;
        return '$hoursDifference ${LocaleData.hoursAgo.getString(context)}';
      }
    }
  }

  String? formatTimeProject(int type) {
    if (type == 0) {
      return '• ${LocaleData.lessThanOneMonth.getString(context)}';
    } else if (type == 1) {
      return '• ${LocaleData.oneToThreeMonths.getString(context)}';
    } else if (type == 2) {
      return '• ${LocaleData.threeToSixMonths.getString(context)}';
    } else if (type == 3) {
      return '• ${LocaleData.moreThanSixMonths.getString(context)}';
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
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      controller: _tabController,
      tabs: [
        Tab(text: LocaleData.allProject.getString(context)),
        Tab(text: LocaleData.working.getString(context)),
        Tab(text: LocaleData.archieved.getString(context)),
      ],
      indicatorColor: Colors.blue,
      labelColor: Colors.blue,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused)) {
          return Colors.blue.withOpacity(0.1);
        }
        return null;
      }),
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
    if(activeProposal.isEmpty){
      return Card(
        // color: const Color.fromRGBO(247, 242, 249, 1),
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Row(
                  children: [
                    Text(
                      "${LocaleData.activeProposal.getString(context)} (${activeProposal.length})",
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  ),
              ),
              const SizedBox(height: 8.0),
              Text(
                LocaleData.noActiveProposal.getString(context),
                style: const TextStyle(
                  fontSize: 13.0,
                ),
              ),
            ]
          ),
        ),
      );
    }
    else {
      return Card(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(
                      "${LocaleData.activeProposal.getString(context)} (${activeProposal.length})",
                      style: const TextStyle(
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
  }

  Widget _buildActivityProposalItem(int index){
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => DetailProposal(
            idProposal: activeProposal[index]['id'],
            coverletter: activeProposal[index]['coverLetter'],
            statusFlag: activeProposal[index]['statusFlag'],
            project: {
              'title': activeProposal[index]['project']['title'],
              'description': activeProposal[index]['project']['description'],
              'projectScopeFlag': activeProposal[index]['project']['projectScopeFlag'],
              'numberOfStudents': activeProposal[index]['project']['numberOfStudents'],
            }
          )
        ));
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        '${LocaleData.submitted.getString(context)} ${formatTimeAgo(activeProposal[index]['createdAt'])}',
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
              Text(
                LocaleData.description.getString(context),
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
      ),
    );
  }
  Widget _submittedProposal() {
    return Card(
        color: Theme.of(context).colorScheme.background,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      "${LocaleData.submittedProposal.getString(context)} (${submittedProposal.length})",
                      style: const TextStyle(
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
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => DetailProposal(
            idProposal: submittedProposal[index]['id'],
            coverletter: submittedProposal[index]['coverLetter'],
            statusFlag: submittedProposal[index]['statusFlag'],
            project: {
              'title': submittedProposal[index]['project']['title'],
              'description': submittedProposal[index]['project']['description'],
              'projectScopeFlag': submittedProposal[index]['project']['projectScopeFlag'],
              'numberOfStudents': submittedProposal[index]['project']['numberOfStudents'],
            }
          )
        ));
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
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
                        '${LocaleData.submitted.getString(context)} ${formatTimeAgo(submittedProposal[index]['createdAt'])}',
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
              Text(
                LocaleData.description.getString(context),
                style: const TextStyle(
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
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => DetailProposal(
            idProposal: projectsWorking[index]['id'],
            coverletter: projectsWorking[index]['coverLetter'],
            statusFlag: projectsWorking[index]['statusFlag'],
            project: {
              'title': projectsWorking[index]['project']['title'],
              'description': projectsWorking[index]['project']['description'],
              'projectScopeFlag': projectsWorking[index]['project']['projectScopeFlag'],
              'numberOfStudents': projectsWorking[index]['project']['numberOfStudents'],
            }
          )
        ));
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
              Text(
                LocaleData.description.getString(context),
                style: const TextStyle(
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
    return GestureDetector(
      onTap:(){
        Navigator.push(context,
        MaterialPageRoute(
          builder: (context) => DetailProposal(
            idProposal: projectsArchieved[index]['id'],
            coverletter: projectsArchieved[index]['coverLetter'],
            statusFlag: projectsArchieved[index]['statusFlag'],
            project: {
              'title': projectsArchieved[index]['project']['title'],
              'description': projectsArchieved[index]['project']['description'],
              'projectScopeFlag': projectsArchieved[index]['project']['projectScopeFlag'],
              'numberOfStudents': projectsArchieved[index]['project']['numberOfStudents'],
            }
          )
        ));
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
              Text(
                LocaleData.description.getString(context),
                style: const TextStyle(
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
      ),
    );
  }
}
