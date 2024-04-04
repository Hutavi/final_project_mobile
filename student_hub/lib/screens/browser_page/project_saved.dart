import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/project_item.dart';

class SavedProject extends StatefulWidget {
  const SavedProject({super.key});

  @override
  State<SavedProject> createState() => _SavedProjectState();
}

class _SavedProjectState extends State<SavedProject> {
  late List<ProjectForListModel> favoriteProjects = [];

  @override
  void initState() {
    fecthData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void fecthData() async {
    // Call API to get data
    try {
      final dioPulic = DioClientWithoutToken();

      final response =
          await dioPulic.request('/project', options: Options(method: 'GET'));
      if (response.statusCode == 200) {
        final List<dynamic> parsed = response.data!['result'];
        List<ProjectForListModel> projects =
            parsed.map<ProjectForListModel>((item) {
          return ProjectForListModel.fromJson(item);
        }).toList();

        setState(() {
          favoriteProjects = getFavoriteProjectsByTypeFlag(projects);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  List<ProjectForListModel> getFavoriteProjectsByTypeFlag(
      List<ProjectForListModel> projects) {
    return projects.where((project) => project.typeFlag == 1).toList();
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
                      id: project.id!,
                      title: project.title!,
                      describe: project.description,
                      projectScopeFlag: project.projectScopeFlag,
                      typeFlag: project.typeFlag,
                      numberOfStudents: project.numberOfStudents,
                      createdAt: project.createdAt,
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
