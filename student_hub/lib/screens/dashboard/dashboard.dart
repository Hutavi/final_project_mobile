import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/dashboard/send_hired.dart';
import 'package:student_hub/screens/post/review_post.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/screens/dashboard/studentAllProject.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/data/student_user.dart';

class Dashboard extends StatefulWidget {
  // const Dashboard({super.key, this.companyUser, this.studentUser});
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

  List<dynamic> projects = [];
  List<dynamic> projectsWorking = [];
  List<dynamic> projectsArchieved = [];

  User? user = User();
  Future<void> getUserInfoFromToken() async {
    // Lấy token từ local storage
    String? token = await TokenManager.getTokenFromLocal();
    // print(token);
    if (token != null) {
      // Gọi API để lấy thông tin user
      User? userInfo = await ApiManager.getUserInfo(token);
      setState(() {
        print('getUserInfoFromToken UserInfor:');
        print(userInfo);
        // Cập nhật userCurr với thông tin user được trả về từ API
        user = userInfo;
        print('getUserInfoFromToken User:');
        print(user);
      });
    } else {
      print('Token is null');
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getDataDefault();
    // getUserInfoFromToken();
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
      projects = project;
      projectsWorking = project.where((item) => item['typeFlag'] == 0).toList();
      projectsArchieved =
          project.where((item) => item['typeFlag'] == 1).toList();
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
        if (user['company'] == null) {
          created = false;
        } else {
          created = true;
          final company = user['company'];
          idCompany = company['id'];
          getDataIdCompany();
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

  void getDataStudent() async {
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

  void _handleStartWorking(int idProject, int index) async {
    if (projects[index]['typeFlag'] == 0) return;
    final data = {
      "projectScopeFlag": projects[index]['projectScopeFlag'],
      "title": projects[index]['title'],
      "description": projects[index]['description'],
      "numberOfStudents": projects[index]['numberOfStudents'],
      "typeFlag": 0
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
    final id = projects[index]['id'];
    try {
      final dioPrivate = DioClient();

      final response = await dioPrivate.request(
        '/project/$id',
        options: Options(
          method: 'DELETE',
        ),
      );

      if (response.statusCode == 200) {
        getDataDefault();
        print('Delete project success');
      }
    } catch (e) {
      print('Error: $e');
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
      //Nếu người dùng là studentUser, hiển thị giao diện dành cho studentUser
      return const Scaffold(
        // appBar:
        appBar: AppBarCustom(title: "Student Hub"),
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
      );
    } else {
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
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AppRouterName.postScreen1);
                    },
                    child: const Text(
                      'Post a projects',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
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
    );
  }

  Widget _buildProjectListAllProject() {
    return Expanded(
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
    return Expanded(
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
    return Expanded(
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
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                        idProject: projects[index]['id'],
                        indexTab: 0,
                        projectDetail: {
                          "description": projects[index]['description'],
                          "projectScopeFlag": projects[index]
                              ['projectScopeFlag'],
                          "numberOfStudents": projects[index]
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
                          "description": projects[index]['description'],
                          "projectScopeFlag": projects[index]
                              ['projectScopeFlag'],
                          "numberOfStudents": projects[index]
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
                        idProject: projects[index]['id'],
                        indexTab: 3,
                        projectDetail: {
                          "description": projects[index]['description'],
                          "projectScopeFlag": projects[index]
                              ['projectScopeFlag'],
                          "numberOfStudents": projects[index]
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
                title: const Text('View job posting'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  FontAwesomeIcons.penToSquare,
                  size: 20,
                ),
                title: const Text('Edit posting'),
                onTap: () {
                  Navigator.pop(context);
                }
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
                  _handleStartWorking(projects[index]['id'], index);
                  _tabController.animateTo(1);
                },
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
