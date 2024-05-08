import 'dart:convert'; 
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/models/project_models/project_model_new.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class ReviewPost extends ConsumerStatefulWidget {
  final int? projectID;
  const ReviewPost({Key? key, this.projectID}) : super(key: key);
  @override
  ConsumerState<ReviewPost> createState() => _ReviewPostState();
}

class _ReviewPostState extends ConsumerState<ReviewPost> {
  ProjectModelNew project = ProjectModelNew();
  Future<void> getProject()async{
    try{
      final dioPrivate = DioClient();
      final response = await dioPrivate.request(
        '/project/${widget.projectID}',
        options: Options(
          method: 'GET',
        ),
      );
      project.projectScopeFlag = response.data['result']['projectScopeFlag'];
      project.title = response.data['result']['title'];
      project.numberOfStudents = response.data['result']['numberOfStudents'];
      project.description = response.data['result']['description'];
      project.typeFlag = response.data['result']['typeFlag'];
    }
    catch(e){
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    getProject();
    final scopeProject = project.projectScopeFlag == 0
        ? '1 to 3 months'
        : '3 to 6 months';
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBarCustom(
        title: 'Student Hub',
      ),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleData.projectDetail.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text("${project.title}",
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kBlue600)),
              const Divider(),
              Text(
                LocaleData.projectDescription.getString(context),
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              Text("${project.description}",
                  style: const TextStyle(
                      fontSize: 14,
                      // fontWeight: FontWeight.w300,
                      color: kBlue600)),
              
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
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
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '$scopeProject',
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                        overflow: TextOverflow.clip,
                      )
                    ],
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
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
                        LocaleData.studentRequired.getString(context),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14),
                        overflow: TextOverflow.clip,
                      ),
                      Text(
                        '• ' '${project.numberOfStudents}',
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
      bottomNavigationBar: BottomAppBar(
        height: 100,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() async {
                      Navigator.pushNamed(context, AppRouterName.editPoject,
                      arguments: widget.projectID);
                    });
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kBlue400,
                    foregroundColor: kWhiteColor,
                    padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                  ),
                  child: Text(LocaleData.editProject.getString(context)),
                ),
              ),
              // SizedBox(width: 10,),
              Container(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: (){
                    setState(() async {
                      Navigator.pop(context);
                    });
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kRed,
                    foregroundColor: kWhiteColor,
                    padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                  ),
                  child: Text(LocaleData.cancel.getString(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}