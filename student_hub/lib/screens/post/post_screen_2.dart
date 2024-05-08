import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

enum ProjectDuration {
  oneToThreeMonths,
  threeToSixMonths,
}

class PostScreen2 extends ConsumerStatefulWidget {
  const PostScreen2({Key? key}) : super(key: key);

  @override
  ConsumerState<PostScreen2> createState() => _PostScreen2State();
}

class _PostScreen2State extends ConsumerState<PostScreen2> {
  ProjectDuration _projectDuration = ProjectDuration.oneToThreeMonths;
  final _numberStudentsController = TextEditingController();
  // bool _isDisabledNextButton = true;
  int _numberOfStudents = 0; // Biến để lưu giá trị số không âm

  @override
  void dispose() {
    _numberStudentsController.dispose();
    super.dispose();
  }

  // change value of project-duration when selecting another duration
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

  @override
  Widget build(BuildContext context) {
    print(ref.watch(postProjectProvider).title);
    if(ref.watch(postProjectProvider).numberOfStudents != null){
      _numberStudentsController.text = ref.watch(postProjectProvider).numberOfStudents.toString();
    }
    if(ref.watch(postProjectProvider).projectScopeFlag != null){
      if(ref.watch(postProjectProvider).projectScopeFlag == 0){
        _projectDuration = ProjectDuration.oneToThreeMonths;
      }
      else{
        _projectDuration = ProjectDuration.threeToSixMonths;
      }
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background, 
      appBar: const AppBarCustom(title: 'Student Hub'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleData.postingScopeTitle.getString(context),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              Text(
                LocaleData.postingScopeDescribeItem.getString(context),
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
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
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
                controller: _numberStudentsController,
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
                    ref.read(postProjectProvider.notifier).setNumberOfStudents(int.tryParse(value) ?? 0);
                    //onHandledButtonWithTextfield,
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
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.postScreen3);
                  },
                  child: Text(LocaleData.nextDescription.getString(context)),
                  style: ElevatedButton.styleFrom(
                    // Adjust minimum size based on screen size
                    minimumSize: MediaQuery.of(context).size.width < 300
                        ? const Size(200,
                            40) // Adjust width and height for smaller screens
                        : null,
                    // Adjust padding based on screen size (optional)
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width < 300
                          ? 10.0
                          : 16.0, // Adjust padding for smaller screens
                      vertical: 8.0,
                    ),
                    backgroundColor: kBlue400,
                    foregroundColor: _numberOfStudents > 0
                        ? null
                        : kWhiteColor, // Disable button if no value
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}