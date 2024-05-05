import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';
import 'package:student_hub/widgets/loading.dart';

class SendHired extends StatefulWidget {
  final int idProject;
  final int indexTab;
  final Map projectDetail;
  const SendHired({
    Key? key,
    required this.idProject,
    required this.indexTab,
    required this.projectDetail,
  }) : super(key: key);

  @override
  SendHiredState createState() => SendHiredState();
}

class SendHiredState extends State<SendHired>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String titleIcon = 'Hired';
  int? _idProject;
  List<dynamic> proposals = [];
  List<dynamic> listMessage = [];
  Map? _projectDetaild;
  var isLoading = true;
  var idUser = -1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(widget.indexTab);
    _idProject = widget.idProject;
    _projectDetaild = widget.projectDetail;
    getDataProposalIdProject();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void getDataProposalIdProject() async {
    final dioPrivate = DioClient();

    final responseProppsal = await dioPrivate.request(
      '/proposal/getByProjectId/$_idProject',
      options: Options(
        method: 'GET',
      ),
    );

    final responseMessageProppsal = await dioPrivate.request(
      '/message/$_idProject',
      options: Options(
        method: 'GET',
      ),
    );

    final responseIdUser = await dioPrivate.request(
      '/auth/me',
      options: Options(
        method: 'GET',
      ),
    );

    final proposal = responseProppsal.data['result']['items'];
    final message = responseMessageProppsal.data['result'];
    final user = responseIdUser.data['result'];

    setState(() {
      if (user['roles'][0] == 0) {
        idUser = user['student']['userId'];
      } else {
        idUser = user['company']['userId'];
      }
      proposals = proposal;
      listMessage = message;
      isLoading = false;
    });
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

  String findMaxYearAndCalculate(List<dynamic> data) {
    int maxYear = 0;
    dynamic maxYearElement;

    for (var element in data) {
      int currentMaxYear = element['startYear'] > element['endYear']
          ? element['startYear']
          : element['endYear'];

      if (currentMaxYear > maxYear) {
        maxYear = currentMaxYear;
        maxYearElement = element;
      }
    }

    int currentYear = DateTime.now().year;
    int difference = currentYear - maxYear;

    if (maxYearElement != null) {
      String result;

      if (difference == 0) {
        result = LocaleData.fourthYearStudent.getString(context);
      } else if (difference == 1) {
        result = LocaleData.thirdYearStudent.getString(context);
      } else if (difference == 2) {
        result = LocaleData.secondYearStudent.getString(context);
      } else {
        result = LocaleData.firstYearStudent.getString(context);
      }
      return result;
    } else {
      return LocaleData.noDataToProcess.getString(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Text(
              'Senior frontend developer (Fintech)',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  _buildTabBar(),
                  const SizedBox(height: 12),
                  Expanded(
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _buildProjectList(),
                        _buildProjectDetails(),
                        _buildProjectMessage(),
                        Center(child: Text(LocaleData.hired.getString(context))),
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

  Widget _buildTabBar() {
    return TabBar(
      labelStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      controller: _tabController,
      indicatorColor: kBlue600,
      labelColor: kBlue600,
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused)) {
          return Colors.blue.withOpacity(0.1);
        }
        return null;
      }),
      tabs: [
        Tab(text: LocaleData.proposals.getString(context)),
        Tab(text: LocaleData.detail.getString(context)),
        Tab(text: LocaleData.message.getString(context)),
        Tab(text: LocaleData.hired.getString(context)),
      ],
    );
  }

  Widget _buildProjectList() {
    return isLoading
        ? const LoadingWidget()
        : proposals.isNotEmpty
            ? ListView.builder(
                itemCount: proposals.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildProjectItem(context, index);
                },
              )
            : Center(
                child: Text(LocaleData.noHaveProposal.getString(context)),
              );
  }

  Widget _buildProjectMessage() {
    return isLoading
        ? const LoadingWidget()
        : listMessage.isNotEmpty
            ? ListView.builder(
                itemCount: proposals.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildProjectMessageItem(context, index);
                },
              )
            : Center(
                child: Text(LocaleData.noHaveMessage.getString(context)),
              );
  }

  void _showHiredConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleData.hiredOffer.getString(context),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleData.confirmSendOffer.getString(context),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng dialog
                      },
                      child: Text(
                        LocaleData.cancel.getString(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kBlue600,
                        ),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,
                        ),
                      ),
                      onPressed: () {
                        // Xử lý khi nhấn nút Send
                        setState(() {
                          titleIcon = "Sent hired offer";
                        });
                        Navigator.of(context).pop(); // Đóng dialog
                      },
                      child: Text(
                        LocaleData.send.getString(context),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildProjectDetails() {
    return isLoading
        ? const LoadingWidget()
        : Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.studentsAreLookingFor.getString(context),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: kBlackColor,
                        ),
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          DescribeItem(
                            itemDescribe: _projectDetaild!['description'],
                          ),
                          // DescribeItem(
                          //   itemDescribe: 'The skills required for your project',
                          // ),
                          // DescribeItem(
                          //   itemDescribe: 'Detail about your project',
                          // ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.alarm),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleData.projectScope.getString(context),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            formatTimeProject(
                                    _projectDetaild!['projectScopeFlag'])
                                .toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                            overflow: TextOverflow.clip,
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.people),
                      const SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocaleData.teamSize.getString(context),
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 14),
                            overflow: TextOverflow.clip,
                          ),
                          Text(
                            '• ${_projectDetaild!['numberOfStudents'].toString()} ${LocaleData.student.getString(context)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                            ),
                            overflow: TextOverflow.clip,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Widget _buildProjectItem(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImageManagent.imgAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      proposals[index]['student']['user']['fullname'],
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      findMaxYearAndCalculate(
                          proposals[index]['student']['educations']),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  proposals[index]['student']['techStack']['name'],
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  LocaleData.excellent.getString(context),
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              proposals[index]['coverLetter'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(AppRouterName.chatScreen, arguments: {
                        'idProject': widget.idProject,
                        'idThisUser': idUser,
                        'idAnyUser': proposals[index]['student']['userId'],
                        'name': proposals[index]['student']['user']['fullname'],
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kBlue600,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child:Text(
                      LocaleData.message.getString(context),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa 2 nút
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.red,
                      ),
                    ),
                    onPressed: () {
                      _showHiredConfirmationDialog(context);
                    },
                    child: Text(
                      titleIcon,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
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

  Widget _buildProjectMessageItem(BuildContext context, int index) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(ImageManagent.imgAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '1',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'cc',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'hii',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  'Excellent',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'haha',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Xử lý khi nhấn nút Message
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kBlue600,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: const Text(
                      'Message',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa 2 nút
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.red,
                      ),
                    ),
                    onPressed: () {
                      _showHiredConfirmationDialog(context);
                    },
                    child: Text(
                      titleIcon,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
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
