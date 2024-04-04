import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/data/project_list.dart';
import 'package:student_hub/models/project_models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/item_search.dart';

class BottomSheetSearch extends StatefulWidget {
  const BottomSheetSearch({super.key});

  @override
  State<BottomSheetSearch> createState() => _BottomSheetSearchState();
}

class _BottomSheetSearchState extends State<BottomSheetSearch> {
  TextEditingController projectSearchController = TextEditingController();
  List<ProjectModel> projectLists = allProject;

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

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: screenHeight * 0.9,
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
              child: const Icon(Icons.cancel)),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: projectSearchController,
                  cursorColor: kBlue700,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: "Search for project",
                    hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 0.0, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                    disabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 0, color: kBlue600),
                    ),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 0, color: kGrey1),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      borderSide: BorderSide(width: 1, color: kBlue600),
                    ),
                    focusedErrorBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(width: 1, color: kGrey1)),
                  ),
                  onChanged: searchProject,
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: projectLists.length,
              itemBuilder: (context, index) {
                final project = projectLists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRouterName.projectSearch,
                        arguments: project.title!);
                  },
                  child: ItemSearch(
                    titleSearch: project.title!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  
  }
}
