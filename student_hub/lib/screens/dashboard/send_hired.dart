import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/constants/image_assets.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';

class SendHired extends StatefulWidget {
  const SendHired({Key? key}) : super(key: key);

  @override
  SendHiredState createState() => SendHiredState();
}

class SendHiredState extends State<SendHired>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String titleIcon = 'Hired';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                        _buildProjectDetails(),
                        const Center(child: Text('Message')),
                        const Center(child: Text('Hired')),
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
      labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      controller: _tabController,
      tabs: const [
        Tab(text: 'Proposals'),
        Tab(text: 'Detail'),
        Tab(text: 'Message'),
        Tab(text: 'Hired'),
      ],
    );
  }

  Widget _buildProjectList() {
    return ListView.builder(
      itemCount: 4,
      physics: const AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildProjectItem(context, index);
      },
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
                const Text(
                  'Hired offer',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Do you really want to send hired offer for student to do this project?',
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
                      onPressed: () {
                        Navigator.of(context).pop(); // Đóng dialog
                      },
                      child: const Text(
                        'Cancel',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Xử lý khi nhấn nút Send
                        setState(() {
                          titleIcon = "Sent hired offer";
                        });
                        Navigator.of(context).pop(); // Đóng dialog
                      },
                      child: const Text(
                        'Send',
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Students are looking for',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: kBlackColor,
              ),
            ),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: const [
                DescribeItem(
                  itemDescribe:
                      'Clear expectation about your project or deliverables',
                ),
                DescribeItem(
                  itemDescribe: 'The skills required for your project',
                ),
                DescribeItem(
                  itemDescribe: 'Detail about your project',
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.alarm),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project scope',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  '• 3 to 6 months',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  overflow: TextOverflow.clip,
                )
              ],
            )
          ],
        ),
        const SizedBox(height: 10),
        const Row(
          children: [
            Icon(Icons.people),
            SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Team size',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                  overflow: TextOverflow.clip,
                ),
                Text(
                  '• 6 students',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                  overflow: TextOverflow.clip,
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget _buildListText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
              width: 40, child: Icon(Icons.fiber_manual_record, size: 6)),
          Expanded(
              child: Text(
            text,
            style: const TextStyle(fontSize: 13),
          )),
        ],
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tên sinh viên',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      'Năm học',
                      style: TextStyle(),
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
                  'Fullstack Engineer',
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
              'Đoạn text dài, nếu quá 2 dòng sẽ hiển thị dấu Đoạn text dài, nếu quá 2 dòng sẽ hiển thị dấu Đoạn text dài, nếu quá 2 dòng sẽ hiển thị dấu ',
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
                    child: const Text(
                      'Message',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Khoảng cách giữa 2 nút
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showHiredConfirmationDialog(context);
                    },
                    child: Text(
                      titleIcon,
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
  }
}

void main() {
  runApp(const MaterialApp(
    home: SendHired(),
  ));
}
