import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class RegisterChoiceRoleScreen extends StatefulWidget {
  const RegisterChoiceRoleScreen({Key? key}) : super(key: key);

  @override
  State<RegisterChoiceRoleScreen> createState() =>
      _RegisterChoiceRoleScreenState();
}

class _RegisterChoiceRoleScreenState extends State<RegisterChoiceRoleScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isAllFieldsValid = false;
  bool? isStudent;

  void validateFields() {
    setState(() {
      isAllFieldsValid = _formKey.currentState!.validate();
    });
  }

  // Hàm callback để xử lý khi Radio được chọn
  void handleRadioValueChanged(bool? value) {
    setState(() {
      isStudent = value;
    });
    // Hiển thị thông báo hoặc thực hiện các hành động tương ứng với giá trị được chọn
    if (isStudent == true) {
      print('Option 1 is selected');
    } else if (isStudent == false) {
      print('Option 2 is selected');
    }
  }

  @override
  void initState() {
    super.initState();
    isStudent = true; // Đặt giá trị mặc định cho Radio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
                height: 30,
              ),
              const Center(
                child: Text(
                  'Join as Company or Student',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  color: kWhiteColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          color: kGrey0,
                        ),
                        Text(
                          'I am a student, find jobs for me',
                          style: TextStyle(color: kGrey0),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio(
                          value: true,
                          groupValue: isStudent,
                          activeColor: kGrey0,
                          onChanged: handleRadioValueChanged,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: kWhiteColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_2_rounded,
                          color: kGrey0,
                        ),
                        Text(
                          'I am a company, find engineer for project',
                          style: TextStyle(color: kGrey0),
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio(
                          value: false,
                          groupValue: isStudent,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: handleRadioValueChanged,
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouterName.registerBy,
                      arguments: isStudent);
                },
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  backgroundColor: kGrey3,
                  elevation: 0.5,
                ),
                child: const Text(
                  'Create account',
                  style: TextStyle(
                    color: kGrey0,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
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
