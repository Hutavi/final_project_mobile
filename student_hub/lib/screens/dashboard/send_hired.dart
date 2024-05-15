import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:gap/gap.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/dashboard/widget/proposal_detail_student_s1.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/utils/extensions.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';
import 'package:student_hub/widgets/display_text.dart';
import 'package:student_hub/widgets/loading.dart';

class SendHired extends StatefulWidget {
  final int idProject;
  final int indexTab;
  final Map projectDetail;
  final String? companyName;
  const SendHired({
    Key? key,
    required this.idProject,
    required this.indexTab,
    required this.projectDetail,
    this.companyName,
  }) : super(key: key);

  @override
  SendHiredState createState() => SendHiredState();
}

class SendHiredState extends State<SendHired>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String titleIcon = 'Send offer';
  int? _idProject;
  List<dynamic> proposals = [];
  List<dynamic> proposalsHired = [];
  List<dynamic> listMessage = [];
  Map? _projectDetaild;
  var isLoading = true;
  var idUser = -1;
  bool isHired = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.animateTo(widget.indexTab);
    _idProject = widget.idProject;
    _projectDetaild = widget.projectDetail;
    getDataProposalIdProject();
  }

  // @override
  // void dispose() {
  //   _tabController.dispose();
  //   super.dispose();
  // }

  void setActivityStatus(int idProposal) async {
    try {
      final response = await DioClient().request(
        '/proposal/$idProposal',
        data: jsonEncode({
          'statusFlag': 1,
        }),
        options: Options(
          method: 'PATCH',
        ),
      );
      if (response.statusCode == 200) {
        print('Chuyển vào active proposal thành công');
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void checkStatus(int idProposal) async {
    try {
      final response = await DioClient().request(
        '/proposal/$idProposal',
        options: Options(
          method: 'GET',
        ),
      );
      if (response.statusCode == 200) {
        if (response.data['result']['statusFlag'] != 3) {
          setState(() {
            titleIcon = '${LocaleData.send.getString(context)} offer';
            isHired = false;
          });
        }
        if (response.data['result']['statusFlag'] == 3) {
          setState(() {
            titleIcon = LocaleData.hired.getString(context);
            isHired = true;
          });
        }
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  void setHiredStatus(int idProposal) async {
    try {
      final response = await DioClient().request(
        '/proposal/$idProposal',
        data: jsonEncode({
          // 'statusFlag': 2,
          'disableFlag':
              1, //gởi giá trị 1 cho student, nếu student đồng ý thì gởi statusFlag = 3
        }),
        options: Options(
          method: 'PATCH',
        ),
      );
      if (response.statusCode == 200) {
        print('Gửi offer thành công thành công');
        isHired = true;
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
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
      proposal.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));
      message.sort((a, b) => DateTime.parse(b['createdAt'])
          .compareTo(DateTime.parse(a['createdAt'])));
      proposals = proposal.where((item) => item['statusFlag'] != 3).toList();
      proposalsHired =
          proposal.where((item) => item['statusFlag'] == 3).toList();
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
                        _buildProjectHired(),
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
                itemCount: listMessage.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildProjectMessageItem(context, index);
                },
              )
            : Center(
                child: Text(LocaleData.noHaveMessage.getString(context)),
              );
  }

  Widget _buildProjectHired() {
    return isLoading
        ? const LoadingWidget()
        : proposalsHired.isNotEmpty
            ? ListView.builder(
                itemCount: proposalsHired.length,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _buildProjectHiredItem(context, index);
                },
              )
            : Center(
                child: Text('No ${LocaleData.hired.getString(context)}'),
              );
  }

  void _showHiredConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 0,
          // backgroundColor: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
            decoration: BoxDecoration(
              // color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  LocaleData.hiredOffer.getString(context),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  LocaleData.confirmSendOffer.getString(context),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
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
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
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
                          setHiredStatus(index);
                          setState(() {
                            titleIcon = "Hired";
                          });
                          Navigator.of(context).pop(); // Đóng dialog
                        },
                        child: Text(
                          LocaleData.send.getString(context),
                          textAlign: TextAlign.center,
                        ),
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
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
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
    // checkStatus(proposals[index]['id']);
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
                  style: const TextStyle(
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
                    child: Text(
                      LocaleData.message.getString(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa 2 nút
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setActivityStatus(proposals[index]['id']);
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kBlue600,
                      ),
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                    ),
                    child: Text(
                      LocaleData.activeNo.getString(context),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Colors.red,
                      ),
                    ),
                    onPressed: () {
                      if (isHired == false) {
                        final idx = proposals[index]['id'];
                        _showHiredConfirmationDialog(context, idx);
                      }
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
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final deviceSize = context.deviceSize;

    String formatTimeAgo(String dateTimeString) {
      DateTime dateTime = DateTime.parse(dateTimeString);
      DateTime now = DateTime.now();
      Duration difference = now.difference(dateTime);

      if (difference.inDays > 0) {
        if (difference.inDays == 1) {
          return '1 ${LocaleData.dayAgo.getString(context)}';
        } else {
          return '${difference.inDays} ${LocaleData.dayAgo.getString(context)}';
        }
      } else if (difference.inHours > 0) {
        if (difference.inHours == 1) {
          return '1 ${LocaleData.hoursAgo.getString(context)}';
        } else {
          return '${difference.inHours} ${LocaleData.hoursAgo.getString(context)}';
        }
      } else if (difference.inMinutes > 0) {
        if (difference.inMinutes == 1) {
          return '1 ${LocaleData.minutesAgo.getString(context)}';
        } else {
          return '${difference.inMinutes} ${LocaleData.minutesAgo.getString(context)}';
        }
      } else {
        if (difference.inSeconds == 1) {
          return '1 ${LocaleData.secondsAgo.getString(context)}';
        } else {
          return '${difference.inSeconds} ${LocaleData.secondsAgo.getString(context)}';
        }
      }
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.background, // Màu của đường kẻ
            width: 1.0, // Độ dày của đường kẻ
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRouterName.chatScreen, arguments: {
            'idProject': widget.idProject,
            'idThisUser': idUser,
            'idAnyUser': idUser != listMessage[index]['receiver']['id']
                ? listMessage[index]['receiver']['id'] as int
                : listMessage[index]['sender']['id'] as int,
            'name': idUser != listMessage[index]['receiver']['id']
                ? listMessage[index]['receiver']['fullname'] as String
                : listMessage[index]['sender']['fullname'] as String,
          });
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(ImageManagent.imgAvatar),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(1000),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DisplayText(
                          text: idUser != listMessage[index]['receiver']['id']
                              ? listMessage[index]['receiver']['fullname']
                              : listMessage[index]['sender']['fullname'],
                          style: textTheme.labelMedium!.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                        DisplayText(
                            text: 'Senior frontend developer (Fintech)',
                            style: textTheme.labelSmall!.copyWith(
                              fontSize: 10,
                              color: Colors.green,
                            )),
                        const Gap(5),
                        Row(
                          children: [
                            SizedBox(
                              width: deviceSize.width * 0.5,
                              child: DisplayText(
                                text: '${listMessage[index]['content']}',
                                style: textTheme.labelSmall!.copyWith(
                                    color: colorScheme.onSurface,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                DisplayText(
                  text: formatTimeAgo(listMessage[index]['createdAt']),
                  style: textTheme.labelSmall!
                      .copyWith(color: colorScheme.onSurface),
                ),
              ],
            )),
      ),
    );
  }

  Widget _buildProjectHiredItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProposalDetailStudentS1(
                  data: proposalsHired[index]['student']),
            )),
      },
      child: Card(
        color: Theme.of(context).cardColor,
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
                        proposalsHired[index]['student']['user']['fullname'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        findMaxYearAndCalculate(
                            proposalsHired[index]['student']['educations']),
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
                    proposalsHired[index]['student']['techStack']['name'],
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Text(
                    LocaleData.excellent.getString(context),
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                proposalsHired[index]['coverLetter'],
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
                          'idAnyUser': proposalsHired[index]['student']
                              ['userId'],
                          'name': proposalsHired[index]['student']['user']
                              ['fullname'],
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
                      child: Text(
                        LocaleData.message.getString(context),
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10), // Khoảng cách giữa 2 nút
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).colorScheme.background),
                        foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.red,
                        ),
                      ),
                      onPressed: () {
                        // _showHiredConfirmationDialog(context, index);
                      },
                      child: Text(
                        LocaleData.hired.getString(context),
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
      ),
    );
  }
}
