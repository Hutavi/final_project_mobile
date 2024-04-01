import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class RegisterByScreen extends StatefulWidget {
  final bool? radioValue;
  const RegisterByScreen({Key? key, required this.radioValue})
      : super(key: key);

  @override
  State<RegisterByScreen> createState() => _LoginByScreenState();
}

class _LoginByScreenState extends State<RegisterByScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mailForWorkController = TextEditingController();
  TextEditingController passworkController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isAllFieldsValid = false;
  bool? radioValue;
  bool isChecked = false;

  bool isFullNameValid = false;
  bool isMailForWorkValid = false;
  bool isPasswordValid = false;

  void validateFields() {
    setState(() {
      isAllFieldsValid = _formKey.currentState!.validate();
    });
  }

  @override
  void initState() {
    super.initState();
    radioValue = false; // Đặt giá trị mặc định cho Radio
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Student Hub',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[200],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(context, AppRouterName.switchAccount);
            },
          ),
        ],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Text(
                    widget.radioValue == false
                        ? 'Sign up as Company'
                        : 'Sign up as Student',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                BuildTextField(
                  controller: fullNameController,
                  inputType: TextInputType.text,
                  fillColor: kWhiteColor,
                  onChange: (value) {
                    // validateFields();
                  },
                  labelText: 'Full name',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Full name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: mailForWorkController,
                  inputType: TextInputType.text,
                  fillColor: kWhiteColor,
                  onChange: (value) {
                    // validateFields();
                  },
                  labelText: 'Work email address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Work email address is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                BuildTextField(
                  controller: passworkController,
                  inputType: TextInputType.text,
                  fillColor: kWhiteColor,
                  onChange: (value) {
                    // validateFields();
                  },
                  labelText: 'Password (8 or more characters)',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isChecked = !isChecked;
                        });
                      },
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value ?? false;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Yes, I understand and agree to StudentHub')
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: isAllFieldsValid && isChecked == true
                      ? () {
                          print("Create account");
                        }
                      : null,
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
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
