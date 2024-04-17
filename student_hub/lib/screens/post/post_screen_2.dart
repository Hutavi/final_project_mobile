import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/providers/post_project_provider.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: _AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '2/4 - Next, estimate the scope of your job',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height < 600
                    ? 8 // Giảm khoảng trống cho màn hình nhỏ hơn
                    : 16,
              ),
              const Text(
                'Consider the size of your project and the timeline',
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
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRouterName.postScreen3);
                  },
                  child: const Text('Next: Description'),
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
