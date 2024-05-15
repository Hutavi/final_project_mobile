import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_favourite.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/describe_item.dart';

class ProjectItemFavourite extends StatefulWidget {
  final ProjectFavourite projectForListModel;
  final bool? isEven;

  const ProjectItemFavourite(
      {super.key, required this.projectForListModel, this.isEven});

  @override
  State<ProjectItemFavourite> createState() => _ProjectItemFavouriteState();
}

class _ProjectItemFavouriteState extends State<ProjectItemFavourite> {
  bool disableFlag = false;
  int? idStudent;

  @override
  void initState() {
    super.initState();
    fecthMe();
  }

  @override
  void dispose() {
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
      return LocaleData.createdToday.getString(context);
    } else if (daysAgo == 1) {
      return LocaleData.createdYesterday.getString(context);
    } else {
      return LocaleData.createdDayAgo
          .getString(context)
          .replaceFirst('%a', daysAgo.toString());
    }
  }

  void toggleTypeFlag() async {
    setState(() {
      disableFlag = !disableFlag;
    });

    var data = json.encode({
      "projectId": widget.projectForListModel.id,
      "disableFlag": disableFlag == true ? 1 : 0,
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
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Brightness brightness = Theme.of(context).brightness;
    Color backgroundColor;

    if (brightness == Brightness.light) {
      backgroundColor = widget.isEven! ? kWhiteColor : kBlueGray50;
    } else {
      backgroundColor =
          widget.isEven! ? colorScheme.surface : colorScheme.background;
    }
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.2),
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
                      fontWeight: FontWeight.w400, fontSize: 13),
                ),
                Text(
                  widget.projectForListModel.title,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kBlue600),
                ),
                Text(
                  widget.projectForListModel.projectScopeFlag == 0
                      ? '${LocaleData.time.getString(context)}: ${LocaleData.oneToThreeMonths.getString(context)}'
                      : '${LocaleData.time.getString(context)}: ${LocaleData.threeToSixMonths.getString(context)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(LocaleData.studentsAreLookingFor.getString(context),
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold)),
                ListView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DescribeItem(
                      itemDescribe: widget.projectForListModel.description,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  '${LocaleData.proposals.getString(context)}: ${widget.projectForListModel.numberOfStudents} '
                  '${LocaleData.student.getString(context)}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: toggleTypeFlag,
            child: disableFlag == false
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
