import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/dashboard/send_hired.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/screens/dashboard/studentAllProject.dart';
import 'package:student_hub/widgets/loading.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  var created = false;
  var idCompany = -1;
  var idStudent = -1;
  var isLoading = true;

  List<dynamic> projects = [];
  List<dynamic> projectsWorking = [];
  List<dynamic> projectsArchieved = [];

  User? user = User();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDataDefault();
    getDataStudent();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getDataIdCompany() async {
    final dioPrivate = DioClient();

    final responseProject = await dioPrivate.request(
      '/project/company/$idCompany',
      options: Options(
        method: 'GET',
      ),
    );

    final project = responseProject.data['result'];

    setState(() {
      projects = project
          .where((item) => item['typeFlag'] != 1 && item['typeFlag'] != 2)
          .toList()
          .reversed
          .toList();

      projectsWorking = project
          .where((item) => item['typeFlag'] == 1)
          .toList()
          .reversed
          .toList();

      projectsArchieved = project
          .where((item) => item['typeFlag'] == 2)
          .toList()
          .reversed
          .toList();

      isLoading = false;
    });
  }

  void getDataDefault() async {
    final dioPrivate = DioClient();

    final responseUser = await dioPrivate.request(
      '/auth/me',
      options: Options(
        method: 'GET',
      ),
    );

    final user = responseUser.data['result'];

    setState(() {
      if (user['company'] == null) {
        created = false;
      } else {
        created = true;
        final company = user['company'];
        idCompany = company['id'];
        getDataIdCompany();
      }
    });
  }

  void getDataStudent() async {
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
      }
    });
  }

  List<dynamic> handleAssignData() {
    if (_tabController.index == 0) {
      return projects;
    } else if (_tabController.index == 1) {
      return projectsWorking;
    }
    return projectsArchieved;
  }

  void _handleStartWorking(int idProject, int index) async {
    List<dynamic> dataList = handleAssignData();

    if (dataList[index]['typeFlag'] == 1) return;
    setState(() {
      isLoading = true;
    });
    final data = {
      "projectScopeFlag": dataList[index]['projectScopeFlag'],
      "title": dataList[index]['title'],
      "description": dataList[index]['description'],
      "numberOfStudents": dataList[index]['numberOfStudents'],
      "typeFlag": 1
    };

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/project/$idProject',
      data: data,
      options: Options(method: 'PATCH'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        getDataIdCompany();
      });
    } else {}
  }

  void _handleStartArchieved(int idProject, int index) async {
    List<dynamic> dataList = handleAssignData();

    if (projects[index]['typeFlag'] == 2) return;
    setState(() {
      isLoading = true;
    });

    final data = {
      "projectScopeFlag": dataList[index]['projectScopeFlag'],
      "title": dataList[index]['title'],
      "description": dataList[index]['description'],
      "numberOfStudents": dataList[index]['numberOfStudents'],
      "typeFlag": 2
    };

    final dioPrivate = DioClient();
    final responseLanguage = await dioPrivate.request(
      '/project/$idProject',
      data: data,
      options: Options(method: 'PATCH'),
    );

    if (responseLanguage.statusCode == 200) {
      setState(() {
        getDataIdCompany();
      });
    } else {}
  }

  void deleteProject(index) async {
    List<dynamic> data = handleAssignData();

    setState(() {
      isLoading = true;
    });

    final id = data[index]['id'];
    final dioPrivate = DioClient();

    final response = await dioPrivate.request(
      '/project/$id',
      options: Options(
        method: 'DELETE',
      ),
    );

    if (response.statusCode == 200) {
      getDataDefault();
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

  @override
  Widget build(BuildContext context) {
    if (idStudent != -1) {
      return const SafeArea(
        child: Scaffold(
          appBar: null,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 16.0, bottom: 0, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Your Project',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              StudentAllProject(),
            ],
          ),
        ),
      );
    } else {
      return SafeArea(
        child: Scaffold(
          appBar: null,
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
                      'YOUR PROJECT',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () {
                        Navigator.pushNamed(context, AppRouterName.postScreen1);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.blue,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.add,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16, bottom: 16, top: 10),
                  child: Column(
                    children: [
                      _buildTabBar(),
                      const SizedBox(height: 12),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            _buildProjectListAllProject(),
                            _buildProjectListProjectWorking(),
                            _buildProjectListProjectArchieved(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
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

  Widget _buildProjectListAllProject() {
    return isLoading
        ? const LoadingWidget()
        : Container(
            child: projects.isNotEmpty
                ? ListView.builder(
                    itemCount: projects.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildProjectItemAllProject(index);
                    },
                  )
                : const Center(
                    child: Text('Chưa có project'),
                  ),
          );
  }

  Widget _buildProjectListProjectWorking() {
    return isLoading
        ? const LoadingWidget()
        : Container(
            child: projectsWorking.isNotEmpty
                ? ListView.builder(
                    itemCount: projectsWorking.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildProjectItemProjectWorking(index);
                    },
                  )
                : const Center(
                    child: Text('Chưa có project nào đang Working'),
                  ),
          );
  }

  Widget _buildProjectListProjectArchieved() {
    return isLoading
        ? const LoadingWidget()
        : Container(
            child: projectsArchieved.isNotEmpty
                ? ListView.builder(
                    itemCount: projectsArchieved.length,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildProjectItemProjectArchieved(index);
                    },
                  )
                : const Center(
                    child: Text('Chưa có project nào đang Archieved'),
                  ),
          );
  }

  void _showPopupMenu(BuildContext context, int index) {
    List<dynamic> data = handleAssignData();

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.user,
                        size: 20,
                      ),
                      title: const Text('View proposals'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendHired(
                              idProject: data[index]['id'],
                              indexTab: 0,
                              projectDetail: {
                                "description": data[index]['description'],
                                "projectScopeFlag": data[index]
                                    ['projectScopeFlag'],
                                "numberOfStudents": data[index]
                                    ['numberOfStudents']
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.comments,
                        size: 20,
                      ),
                      title: const Text('View messages'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendHired(
                              idProject: projects[index]['id'],
                              indexTab: 2,
                              projectDetail: {
                                "description": data[index]['description'],
                                "projectScopeFlag": data[index]
                                    ['projectScopeFlag'],
                                "numberOfStudents": data[index]
                                    ['numberOfStudents']
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.clipboardCheck,
                        size: 20,
                      ),
                      title: const Text('View hired'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendHired(
                              idProject: data[index]['id'],
                              indexTab: 3,
                              projectDetail: {
                                "description": data[index]['description'],
                                "projectScopeFlag": data[index]
                                    ['projectScopeFlag'],
                                "numberOfStudents": data[index]
                                    ['numberOfStudents']
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.fileImport,
                        size: 20,
                      ),
                      title: const Text('Archieve this project'),
                      onTap: () {
                        Navigator.pop(context);
                        _handleStartArchieved(data[index]['id'], index);
                        _tabController.animateTo(2);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.penToSquare,
                        size: 20,
                      ),
                      title: const Text('Edit posting'),
                      onTap: () {
                        Navigator.pushNamed(context, AppRouterName.reviewPost,
                            arguments: data[index]['id']);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.trashCan,
                        size: 20,
                      ),
                      title: const Text('Remove posting'),
                      onTap: () {
                        deleteProject(index);
                        Navigator.pop(context);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        FontAwesomeIcons.briefcase,
                        size: 20,
                      ),
                      title: const Text('Start working this project'),
                      onTap: () {
                        Navigator.pop(context);
                        _handleStartWorking(data[index]['id'], index);
                        _tabController.animateTo(1);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProjectItemAllProject(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendHired(
              idProject: projects[index]['id'],
              indexTab: 0,
              projectDetail: {
                "description": projects[index]['description'],
                "projectScopeFlag": projects[index]['projectScopeFlag'],
                "numberOfStudents": projects[index]['numberOfStudents']
              },
            ),
          ),
        );
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projects[index]['title'],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatTimeAgo(projects[index]['createdAt']),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showPopupMenu(context, index);
                    },
                    icon: Icon(Icons.pending_outlined,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.black),
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
                        projects[index]['description'],
                        style: const TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(projects[index]['countProposals'].toString()),
                  Text(projects[index]['countMessages'].toString()),
                  Text(projects[index]['countHired'].toString()),
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

  Widget _buildProjectItemProjectWorking(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendHired(
              idProject: projectsWorking[index]['id'],
              indexTab: 0,
              projectDetail: {
                "description": projectsWorking[index]['description'],
                "projectScopeFlag": projectsWorking[index]['projectScopeFlag'],
                "numberOfStudents": projectsWorking[index]['numberOfStudents']
              },
            ),
          ),
        );
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectsWorking[index]['title'],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatTimeAgo(projectsWorking[index]['createdAt']),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showPopupMenu(context, index);
                    },
                    icon: Icon(Icons.pending_outlined,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.black),
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
                        projectsWorking[index]['description'],
                        style: const TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(projectsWorking[index]['countProposals'].toString()),
                  Text(projectsWorking[index]['countMessages'].toString()),
                  Text(projectsWorking[index]['countHired'].toString()),
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

  Widget _buildProjectItemProjectArchieved(int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SendHired(
              idProject: projectsArchieved[index]['id'],
              indexTab: 0,
              projectDetail: {
                "description": projectsArchieved[index]['description'],
                "projectScopeFlag": projectsArchieved[index]
                    ['projectScopeFlag'],
                "numberOfStudents": projectsArchieved[index]['numberOfStudents']
              },
            ),
          ),
        );
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          projectsArchieved[index]['title'],
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatTimeAgo(projectsArchieved[index]['createdAt']),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showPopupMenu(context, index);
                    },
                    icon: Icon(Icons.pending_outlined,
                        size: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.black),
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
                        projectsArchieved[index]['description'],
                        style: const TextStyle(fontSize: 13.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(projectsArchieved[index]['countProposals'].toString()),
                  Text(projectsArchieved[index]['countMessages'].toString()),
                  Text(projectsArchieved[index]['countHired'].toString()),
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
