import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/describe_item.dart';

class ProjectItem extends StatefulWidget {
  final int? id;
  final String title;
  final String? describe;
  final String? createdAt;
  final int? projectScopeFlag;
  final int? typeFlag;
  final int? numberOfStudents;
  const ProjectItem(
      {super.key,
      required this.title,
      this.id,
      this.describe,
      this.createdAt,
      this.projectScopeFlag,
      this.numberOfStudents,
      required this.typeFlag});

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  late int isTypeFlag;

  @override
  void initState() {
    isTypeFlag = widget.typeFlag!;
    super.initState();
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
      isTypeFlag = isTypeFlag == 1 ? 0 : 1;
    });

    int updatedNumberOfStudents = widget.numberOfStudents ?? 1;

    var data = json.encode({
      "typeFlag": isTypeFlag,
      "numberOfStudents": updatedNumberOfStudents,
      "projectScopeFlag": widget.projectScopeFlag
    });
    print(data);

    try {
      final dio = DioClientWithoutToken();
      final response = await dio.request(
        '/project/${widget.id}',
        data: data,
        options: Options(
          method: 'PATCH',
        ),
      );
      if (response.statusCode == 200) {
        print('Update typeFlag success');
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        print('Have Error: ${e.response!.data}');
      } else {
        print('Have Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.numberOfStudents);
    String timeAgo = calculateTimeAgo(widget.createdAt);
    return Container(
      padding: const EdgeInsets.only(top: 10),
      margin: const EdgeInsets.only(top: 20),
      decoration: const BoxDecoration(
        color: kWhiteColor,
        border: Border(
          top: BorderSide(
            color: kBlueGray200,
            width: 1.0,
          ),
        ),
      ),
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
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlue800)),
                Text(
                  widget.projectScopeFlag == 0
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
                      itemDescribe: widget.describe,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Proposals: ${widget.numberOfStudents} students',
                  style: const TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: toggleTypeFlag,
            child: isTypeFlag == 1
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
