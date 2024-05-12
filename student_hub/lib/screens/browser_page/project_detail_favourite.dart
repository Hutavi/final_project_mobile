import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_favourite.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/widgets/project_item_favourite.dart';

class ProjectDetailFavorite extends StatefulWidget {
  final ProjectFavourite projectItem;
  const ProjectDetailFavorite({super.key, required this.projectItem});

  @override
  State<ProjectDetailFavorite> createState() => _ProjectDetailFavouriteState();
}

class _ProjectDetailFavouriteState extends State<ProjectDetailFavorite> {
  String getProjectScopeText(BuildContext context, int flag) {
    switch (flag) {
      case 0:
        return LocaleData.lessThanOneMonth.getString(context);
      case 1:
        return LocaleData.oneToThreeMonth.getString(context);
      case 2:
        return LocaleData.threeToSixMonth.getString(context);
      case 3:
        return LocaleData.moreThanSixMonth.getString(context);
      default:
        return 'Unknown flag';
    }
  }

  ProjectForListModel projectID = ProjectForListModel();

  ProjectForListModel getProjectID(ProjectFavourite project) {
    ProjectForListModel rst = ProjectForListModel();
    rst.id = project.id;
    print('id của favorite: ${rst.id}');
    return rst;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                LocaleData.projectDetailTilte.getString(context),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                widget.projectItem.title,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: kBlue600),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey, width: 1.0),
                    bottom: BorderSide(color: Colors.grey, width: 1.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleData.studentLookingFor.getString(context),
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
                          itemDescribe: widget.projectItem.description,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.alarm),
                  const SizedBox(
                    width: 15,
                  ),
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
                        '• ${getProjectScopeText(context, widget.projectItem.projectScopeFlag)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Icon(Icons.people),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocaleData.studentNeeded.getString(context),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• '
                        '${widget.projectItem.numberOfStudents} ${LocaleData.student.getString(context)}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: const BoxDecoration(),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  projectID = getProjectID(widget.projectItem);
                  Navigator.pushNamed(context, AppRouterName.submitProposal, arguments: projectID);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: kWhiteColor,
                    foregroundColor: kBlue700),
                child: Text(LocaleData.applyNow.getString(context)),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: kWhiteColor,
                    foregroundColor: kBlueGray600),
                child: Text(LocaleData.save.getString(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
