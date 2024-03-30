import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/describe_item.dart';

class ProjectDetail extends StatefulWidget {
  final ProjectModel projectItem;
  const ProjectDetail({super.key, required this.projectItem});

  @override
  State<ProjectDetail> createState() => _ProjectDetailState();
}

class _ProjectDetailState extends State<ProjectDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              const Text(
                'Project detail',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kBlueGray900),
              ),
              const SizedBox(
                height: 5,
              ),
              // const Text(
              //   'Title of the job',
              //   style: TextStyle(
              //       fontSize: 16,
              //       fontWeight: FontWeight.w500,
              //       color: kBlueGray800),
              // ),
              Text(
                widget.projectItem.title as String,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: kBlackColor),
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
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Icon(Icons.alarm),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project scope',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '3 to 6 month',
                        style: TextStyle(
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
              const Row(
                children: [
                  Icon(Icons.people),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project scope',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '6 students',
                        style: TextStyle(
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
                  Navigator.pushNamed(context, AppRouterName.submitProposal);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    backgroundColor: kWhiteColor,
                    foregroundColor: kBlue700),
                child: const Text('Apply Now'),
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
                child: const Text('Saved'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}