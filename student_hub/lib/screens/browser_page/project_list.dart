import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/data/project_list.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/bottom_sheet_search.dart';
import 'package:student_hub/widgets/project_item.dart';

class ProjectListScreen extends StatefulWidget {
  const ProjectListScreen({super.key});

  @override
  State<ProjectListScreen> createState() => _ProjectListScreenState();
}

class _ProjectListScreenState extends State<ProjectListScreen> {
  TextEditingController projectSearchController = TextEditingController();
  List<ProjectModel> projectLists = allProject;

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
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: projectSearchController,
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.search),
                        hintText: "Search for project",
                        hintStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
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
                      // onChanged: searchProject,
                      onTap: () {
                        _showSearchBottomSheet(
                            context); // Call function to show BottomSheet
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouterName.projectSaved);
                    },
                    child: const Icon(
                      Icons.favorite,
                      color: kRed,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: projectLists.length,
                  itemBuilder: (context, index) {
                    final project = projectLists[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, AppRouterName.projectDetail,
                            arguments: project);
                      },
                      child: ProjectItem(
                        title: project.title!,
                        describe: project.describe,
                        proposals: project.proposals,
                        isFavorite: project.favorite,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void searchProject(String query) {
    final suggestions = allProject.where((project) {
      final projectTitle = project.title!.toLowerCase();
      final input = query.toLowerCase();

      return projectTitle.contains(input);
    }).toList();
    setState(() => projectLists = suggestions);
  }

  void _showSearchBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const BottomSheetSearch();
      },
    );
  }
}