import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/widgets/describe_item.dart';

class ProjectItem extends StatefulWidget {
  final String title;
  final String? describe;
  final String? proposals;
  final bool isFavorite;
  const ProjectItem(
      {super.key,
      required this.title,
      this.describe,
      this.proposals,
      required this.isFavorite});

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  @override
  Widget build(BuildContext context) {
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
                const Text(
                  'Created 3 days ago',
                  style: TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
                Text(widget.title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: kBlue800)),
                const Text('Time: 1-3 months, 6 students needed',
                    style: TextStyle(
                        color: kBlueGray800, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                const Text('Students are looking for',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Proposals: Less than 5',
                  style: TextStyle(
                      color: kBlueGray800, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          widget.isFavorite
              ? const Icon(
                  Icons.favorite_rounded,
                  color: kRed,
                )
              : const Icon(Icons.favorite_border_rounded)
        ],
      ),
    );
  }
}
