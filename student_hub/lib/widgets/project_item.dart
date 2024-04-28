import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/describe_item.dart';

class ProjectItem extends StatefulWidget {
  final ProjectForListModel projectForListModel;
  final bool? isEven;
  const ProjectItem(
      {super.key, required this.projectForListModel, this.isEven});

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  late bool isFavoriteUpdate = false;
  int? idStudent;
  @override
  void initState() {
    isFavoriteUpdate = widget.projectForListModel.isFavorite ?? false;
    super.initState();
    fecthMe();
  }

  @override
  void dispose() {
    isFavoriteUpdate = false;
    super.dispose();
  }

  void fecthMe() async {
    try {
      final dioClient = DioClient();
      final response =
          await dioClient.request('/auth/me', options: Options(method: 'GET'));
      if (response.statusCode == 200) {
        idStudent = response.data['result']['student']['id'];
        // print(response.data['result']['student']['id']);
      }
    } catch (e) {
      print(e);
    }
  }

  String calculateTimeAgo(String? createdAt) {
    if (createdAt == null) {
      return '';
    }

    DateTime createdDateTime = DateTime.parse(createdAt);
    DateTime now = DateTime.now();
    Duration difference = now.difference(createdDateTime);
    int daysAgo = difference.inDays;

    if (daysAgo == 0) {
      return 'Created today';
    } else if (daysAgo == 1) {
      return 'Created yesterday';
    } else {
      return 'Created $daysAgo days ago';
    }
  }

  void toggleTypeFlag() async {
    setState(() {
      isFavoriteUpdate = !isFavoriteUpdate;
    });

    var data = json.encode({
      "projectId": widget.projectForListModel.id,
      "disableFlag": !isFavoriteUpdate == true ? 1 : 0,
    });
    print(data);

    try {
      final dio = DioClient();
      final response = await dio.request(
        '/favoriteProject/$idStudent',
        data: data,
        options: Options(
          method: 'PATCH',
        ),
      );
      if (response.statusCode == 200) {
        print('Update project favourite success');
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print('Have Error 1: ${e.response!.data}');
      } else {
        print('Have Error 2: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String timeAgo = calculateTimeAgo(widget.projectForListModel.createdAt);
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: widget.isEven == true ? kWhiteColor : kBlueGray50,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: const [
            BoxShadow(
              color: kGrey2,
              blurRadius: 5.0,
            ),
          ]),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  timeAgo,
                  style: const TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
                Text(widget.projectForListModel.title ?? '',
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlue800)),
                Text(
                  widget.projectForListModel.projectScopeFlag == 0
                      ? 'Time: 1-3 months'
                      : 'Time: 3-6 months',
                  style: const TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                const Text('Students are looking for',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DescribeItem(
                      itemDescribe:
                          widget.projectForListModel.description ?? '',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Proposals: ${widget.projectForListModel.numberOfStudents} students',
                  style: const TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: toggleTypeFlag,
            child: isFavoriteUpdate == true
                ? const Icon(
                    Icons.favorite_rounded,
                    color: kRed,
                  )
                : const Icon(Icons.favorite_border_rounded),
          )
        ],
      ),
    );
  }
}
