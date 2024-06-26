import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
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
  int? idCompany;
  @override
  void initState() {
    isFavoriteUpdate = widget.projectForListModel.isFavorite ?? false;
    fecthMe();
    super.initState();
  }

  @override
  void dispose() {
    // isFavoriteUpdate = false;
    super.dispose();
  }

  void fecthMe() async {
    try {
      final dioClient = DioClient();
      final response =
          await dioClient.request('/auth/me', options: Options(method: 'GET'));
      if (response.statusCode == 200) {
        final result = response.data['result'];
        final roles = result['roles'];
        final student = result['student'];
        final company = result['company'];

        if (roles.contains(0)) {
          idStudent = student != null ? student['id'] : null;
          idCompany = null;
        } else {
          idStudent = null;
          idCompany = company != null ? company['id'] : null;
        }
        setState(() {});
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

  String getProjectScopeText(BuildContext context, int flag) {
    switch (flag) {
      case 0:
        return '${LocaleData.time.getString(context)}: ${LocaleData.lessThanOneMonth.getString(context)}';
      case 1:
        // Replace with your actual string for flag == 1
        return '${LocaleData.time.getString(context)}: ${LocaleData.oneToThreeMonth.getString(context)}';
      case 2:
        return '${LocaleData.time.getString(context)}: ${LocaleData.threeToSixMonths.getString(context)}';
      case 3:
        // Replace with your actual string for flag == 3
        return '${LocaleData.time.getString(context)}: ${LocaleData.moreThanSixMonth.getString(context)}';
      default:
        return 'Unknown flag';
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => Navigator.pushNamed(context, AppRouterName.projectDetail,
          arguments: widget.projectForListModel),
      child: Container(
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
                  Text(widget.projectForListModel.title ?? '',
                      style: const TextStyle(
                        fontSize: 16,
                        color: kBlue600,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    getProjectScopeText(context,
                        widget.projectForListModel.projectScopeFlag ?? 0),
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
                        itemDescribe:
                            widget.projectForListModel.description ?? '',
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${LocaleData.proposals.getString(context)}: ${widget.projectForListModel.numberOfStudents} ${LocaleData.student.getString(context)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: idStudent != null ? toggleTypeFlag : null,
              child: isFavoriteUpdate == true
                  ? const Icon(
                      Icons.favorite_rounded,
                      color: kRed,
                    )
                  : const Icon(Icons.favorite_border_rounded),
            )
          ],
        ),
      ),
    );
  }
}
