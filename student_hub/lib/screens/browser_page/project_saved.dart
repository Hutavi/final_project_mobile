import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/models/project_models/project_model_favourite.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/project_item_favourite.dart';

class SavedProject extends StatefulWidget {
  const SavedProject({super.key});

  @override
  State<SavedProject> createState() => _SavedProjectState();
}

class _SavedProjectState extends State<SavedProject> {
  late List<ProjectFavourite> favoriteProjects = [];
  int? idStudent;

  @override
  void initState() {
    fecthMe();
    // fecthData();
    super.initState();
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
        fecthData();
      }
    } catch (e) {
      print(e);
    }
  }

  void fecthData() async {
    // Call API to get data
    try {
      final dioPulic = DioClient();
      print(idStudent);

      final response = await dioPulic.request('/favoriteProject/$idStudent',
          options: Options(method: 'GET'));
      if (response.statusCode == 200) {
        final List<dynamic> result = response.data!['result'];
        List<ProjectFavourite> projects = result.map<ProjectFavourite>((item) {
          // Truy cập vào trường "project" của mỗi phần tử trong danh sách result
          final projectData = item['project']
              as Map<String, dynamic>; // Cast sang Map<String, dynamic>
          return ProjectFavourite.fromJson(projectData);
        }).toList();

        setState(() {
          favoriteProjects = projects;
        });
      }
    } catch (e) {
      print(e);
    }
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
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: favoriteProjects.length,
                itemBuilder: (context, index) {
                  final project = favoriteProjects[index];
                  final backgroundColor = index % 2 == 0 ? true : false;
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, AppRouterName.projectDetailFavorite,
                          arguments: project);
                    },
                    child: Column(
                      children: [
                        ProjectItemFavourite(
                          isEven: backgroundColor,
                          projectForListModel: project,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
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
