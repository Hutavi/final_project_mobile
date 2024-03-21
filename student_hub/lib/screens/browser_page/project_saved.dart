import 'package:flutter/material.dart';
import 'package:student_hub/data/project_list.dart';
import 'package:student_hub/models/project_model.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/project_item.dart';

class SavedProject extends StatefulWidget {
  const SavedProject({super.key});

  @override
  State<SavedProject> createState() => _SavedProjectState();
}

class _SavedProjectState extends State<SavedProject> {
  List<ProjectModel> projectLists = allProject;
  late List<ProjectModel> favoriteProjects;

  @override
  void initState() {
    super.initState();
    favoriteProjects =
        allProject.where((project) => project.favorite == true).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Saved projects',
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: favoriteProjects.length,
                itemBuilder: (context, index) {
                  final project = favoriteProjects[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRouterName.projectDetail,
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
    );
  }
}
