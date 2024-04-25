import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:dio/dio.dart';
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
  final titleController = TextEditingController();
  bool _titlePost = false;
  final _numberStudentsController = TextEditingController();
  ProjectDuration _projectDuration = ProjectDuration.oneToThreeMonths;
  int _numberOfStudents = 0; // Biến để lưu giá trị số không âm
  final descriptionController = TextEditingController();
  bool _descriptionPost = false;
  
  void onSelectedDuration(ProjectDuration? duration) {
    if(duration?.index == 0){
      ref.read(postProjectProvider.notifier).setProjectScopeFlag(0);
    }
    else{
      ref.read(postProjectProvider.notifier).setProjectScopeFlag(1);
    }
    setState(() {
      _projectDuration = duration!;
    });
  }

  void editPoject() async {
    try{
      var requestData = json.encode({
          'projectScopeFlag': ref.watch(postProjectProvider).projectScopeFlag,
          'title': ref.watch(postProjectProvider).title,
          'numberOfStudents': ref.watch(postProjectProvider).numberOfStudents,
          'description': ref.watch(postProjectProvider).description,
          'typeFlag': ref.watch(postProjectProvider).typeFlag,
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
      appBar: const _AppBar(),
      body: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, top: 10.0, bottom: 0.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Project details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                    hintText: "Write a title for your post",
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
                  ref.read(postProjectProvider).projectScopeFlag=null;
                  ref.read(postProjectProvider.notifier).setProjectTitle(value);
                  setState(() {
                    _titlePost = value.isNotEmpty;
                  });
                },
              ),
              const Divider(),
              const Text(
                'Project description',
                style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 14,
                )
              ),
              const SizedBox(height: 5),
              TextField(
                  controller: descriptionController,
                  maxLines: 6,
                  decoration: const InputDecoration(
                      hintText: 'Project Description',
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
                  ref.read(postProjectProvider).description = null;
                  ref.read(postProjectProvider.notifier).setProjectDescription(value);
                  setState(() {
                    _descriptionPost = value.isNotEmpty;
                  });
                },
                ),
              const Divider(),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              const Text(
                'How many students do you want for this project?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              TextFormField(
                controller: _numberStudentsController,
                decoration: const InputDecoration(
                    hintText: 'Number of students',
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
                    ref.read(postProjectProvider.notifier).setNumberOfStudents(int.tryParse(value) ?? 0);
                    //onHandledButtonWithTextfield,
                    _numberOfStudents = int.tryParse(value) ?? 0;
                    // _isDisabledNextButton = value != null? true : false;
                  });
                },
                style: TextStyle(
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
              const Text(
                'How long will your project take?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ListTile(
                title: const Text('1 to 3 months'),
                leading: Radio<ProjectDuration>(
                  value: ProjectDuration.oneToThreeMonths,
                  groupValue: _projectDuration,
                  onChanged: onSelectedDuration,
                ),
              ),
              ListTile(
                title: const Text('3 to 6 months'),
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
                    print(ref.watch(postProjectProvider).projectScopeFlag);
                    print(ref.watch(postProjectProvider).title);
                    editPoject();
                    // Navigator.pushNamed(context, AppRouterName.navigation);
                    ref.read(postProjectProvider).projectScopeFlag = null;
                    ref.read(postProjectProvider).title = null;
                    ref.read(postProjectProvider).numberOfStudents = null;
                    ref.read(postProjectProvider).description = null;
                    ref.read(postProjectProvider).typeFlag = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kBlue400,
                  foregroundColor: _titlePost ? null : kWhiteColor,

                ),
                child: const Text('Edit project'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey[200],
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('lib/assets/images/avatar.png'),
          ),
          onPressed: () {
            // tới profile);
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
