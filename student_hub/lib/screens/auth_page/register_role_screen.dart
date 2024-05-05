import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
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
              Center(
                child: Text(
                  LocaleData.titleRegister.getString(context),
                  style: const TextStyle(
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_2_rounded,
                          color: kGrey0,
                        ),
                        Text(
                          LocaleData.studentRegister.getString(context),
                          style: const TextStyle(color: kGrey0),
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.person_2_rounded,
                          color: kGrey0,
                        ),
                        Text(
                          LocaleData.companyRegister.getString(context),
                          style: const TextStyle(color: kGrey0),
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
                child: Text(
                  LocaleData.registerAcc.getString(context),
                  style: const TextStyle(
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
