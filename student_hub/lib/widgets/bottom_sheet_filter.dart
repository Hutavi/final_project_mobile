import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/data/project_list.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class BottomSheetFilter extends StatefulWidget {
  const BottomSheetFilter({super.key});

  @override
  State<BottomSheetFilter> createState() => _BottomSheetFilterState();
}

class _BottomSheetFilterState extends State<BottomSheetFilter> {
  TextEditingController projectSearchController = TextEditingController();
  TextEditingController amountStudentNeedController = TextEditingController();
  TextEditingController proposalsController = TextEditingController();
  List<ProjectModel> projectLists = allProject;
  String? _selectedLength;

  void searchProject(String query) {
    final suggestions = allProject.where((project) {
      final projectTitle = project.title!.toLowerCase();
      final input = query.toLowerCase();

      return projectTitle.contains(input);
    }).toList();
    setState(() => projectLists = suggestions);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        height: screenHeight * 0.8,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: kWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(Icons.cancel),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(width: 1, color: kGrey0))),
              child: const Text(
                "Filter By",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Project lenght",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                RadioListTile<String>(
                  title: const Text(
                    "Less than one month",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: "Less than one month",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: const Text(
                    "1 to 3 months",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: "1 to 3 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: const Text(
                    "3 to 6 months",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: "3 to 6 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                  },
                  activeColor: kBlue800,
                ),
                RadioListTile<String>(
                  title: const Text(
                    "More than 6 months",
                    style: TextStyle(fontSize: 16),
                  ),
                  value: "More than 6 months",
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                  groupValue: _selectedLength,
                  onChanged: (value) {
                    setState(() {
                      _selectedLength = value;
                    });
                  },
                  activeColor: kBlue800,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Students needed",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: amountStudentNeedController,
                  inputType: TextInputType.text,
                  onChange: () {},
                  fillColor: kWhiteColor,
                  labelText: 'Enter students needed',
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Proposals less than",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: proposalsController,
                  inputType: TextInputType.text,
                  onChange: () {},
                  fillColor: kWhiteColor,
                  labelText: 'Enter proposals less than',
                )
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _selectedLength = null;
                              amountStudentNeedController.clear();
                              proposalsController.clear();
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kWhiteColor,
                              foregroundColor: kBlueGray600),
                          child: const Text('Clear filters'),
                        ),
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              backgroundColor: kBlue50,
                              foregroundColor: kBlueGray600),
                          child: const Text('Apply'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
