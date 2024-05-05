import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/models/project_models/project_model_new.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
enum ProjectDuration {
  oneToThreeMonths,
  threeToSixMonths,
}

class EditProject extends ConsumerStatefulWidget {
  final int? projectID;
  // const EditProject({super.key});
  const EditProject({Key? key, this.projectID}) : super(key: key);
  @override
  ConsumerState<EditProject> createState() => _EditProjectState();
}

class _EditProjectState extends ConsumerState<EditProject> {
  ProjectModelNew project = ProjectModelNew();
  final titleController = TextEditingController();
  bool _titlePost = false;
  
  ProjectDuration _projectDuration = ProjectDuration.oneToThreeMonths;
  final descriptionController = TextEditingController();
  int _numberOfStudents = 0; // Biến để lưu giá trị số không âm
  bool _descriptionPost = false;
  
  void onSelectedDuration(ProjectDuration? duration) {
    if(duration?.index == 0){
      project.projectScopeFlag = 0;
    }
    else{
      project.projectScopeFlag = 1;
    }
    setState(() {
      _projectDuration = duration!;
    });
  }

  void editPoject() async {
    try{
      var requestData = json.encode({
          'projectScopeFlag': project.projectScopeFlag,
          'title': project.title,
          'numberOfStudents': project.numberOfStudents,
          'description': project.description,
          'typeFlag': project.typeFlag,
        });
      print('Request data1: $requestData');

      final dioPrivate = DioClient();
      final response = await dioPrivate.request(
        '/project/${widget.projectID}',
        data: requestData,
        options: Options(
          method: 'PATCH',
        ),
      );
      print('Request data2: $response');
      if(response.statusCode == 200){
        print('Post project success');
      }
      if(response.statusCode == 400){
        // if(requestData get companyId){
          if(response.data['projectScopeFlag'] == null){
            print('projectScopeFlag should not be empty, projectScopeFlag must be one of the following values: 0, 1, 2, 3');
          }
          if(response.data['numberOfStudents'] == null){
            print('numberOfStudents must be a number conforming to the specified constraints, numberOfStudents should not be empty');
          }
          if(response.data['numberOfStudents'] == 0){
            print('numberOfStudents should not be one of the following values: 0');
          }
          if(response.data['description'] == null){
            print('description should not be empty, description must be a string');
          }
          if(response.data['typeFlag'] == ""){
            print('description should not be empty');
          }
      }
    }catch(e){
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Text(
                  LocaleData.projectDetail.getString(context),
                  style: TextStyle(fontWeight: FontWeight.bold,
                  fontSize: 20,),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text(
                LocaleData.projectTitle.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              TextField(
                controller: titleController,
                style: TextStyle(
                  color: kGrey0,
                ),
                decoration: InputDecoration(
                    fillColor: kWhiteColor,
                    filled: true,
                    hintText: LocaleData.postingPlaceholder.getString(context),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kGrey0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                            bottom: Radius.circular(10.0)))),
                onChanged: (value) {
                  setState(() {
                    project.title = value;
                    _titlePost = value.isNotEmpty;
                  });
                },
              ),
              const Divider(),
              Text(
                LocaleData.projectDescription.getString(context),
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  style: TextStyle(
                    color: kGrey0,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: kWhiteColor,
                      hintText: LocaleData.projectDescription.getString(context),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: kGrey0,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(10.0),
                              bottom:Radius.circular(10.0)
                          )
                      )
                  ),
                  onChanged: (value) {
                  project.description = value;
                  setState(() {
                    _descriptionPost = value.isNotEmpty;
                  });
                },
                ),
              const Divider(),
              Text(
                LocaleData.postingScopeHowManyStudents.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              TextFormField(
                // controller: _numberStudentsController,
                decoration: InputDecoration(
                    fillColor: kWhiteColor,
                    filled: true,
                    hintText: LocaleData.numberOfStudents.getString(context),
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: kGrey0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      // borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10.0),
                        bottom: Radius.circular(10.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10.0),
                            bottom: Radius.circular(10.0)))),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^[0-9]*$')), // Chỉ cho phép nhập số
                ],
                onChanged: (value){
                  setState(() {
                    project.numberOfStudents = int.tryParse(value) ?? 1;
                    _numberOfStudents = int.tryParse(value) ?? 0;
                    // _isDisabledNextButton = value != null? true : false;
                  });
                },
                style: TextStyle(
                  color: kGrey0,
                  fontSize: MediaQuery.of(context).size.width < 300
                      ? 14 // Điều chỉnh kích thước chữ cho màn hình nhỏ hơn
                      : 16,
                ),
              ),
              
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text(
                LocaleData.postingScopeHowLong.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: Text(LocaleData.oneToThreeMonths.getString(context)),
                leading: Radio<ProjectDuration>(
                  value: ProjectDuration.oneToThreeMonths,
                  groupValue: _projectDuration,
                  onChanged: onSelectedDuration,
                ),
              ),
              ListTile(
                title: Text(LocaleData.threeToSixMonths.getString(context)),
                leading: Radio<ProjectDuration>(
                  value: ProjectDuration.threeToSixMonths,
                  groupValue: _projectDuration,
                  onChanged: onSelectedDuration,
                ),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: (){
                  setState(() async {
                    editPoject();
                    Navigator.pushNamed(context, AppRouterName.navigation);
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue400,
                  foregroundColor: _titlePost ? null : kWhiteColor, 
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 10.0,
                  ),
                ),
                child: Text(LocaleData.editProject.getString(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}