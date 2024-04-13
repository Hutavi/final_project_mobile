import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class RegisterByScreen extends StatefulWidget {
  final bool? isStudent;
  const RegisterByScreen({Key? key, required this.isStudent}) : super(key: key);

  @override
  State<RegisterByScreen> createState() => _LoginByScreenState();
}

class _LoginByScreenState extends State<RegisterByScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mailForWorkController = TextEditingController();
  TextEditingController passworkController = TextEditingController();
  bool passworkWeak = false;
  bool passwordShort = false;
  bool isEmail = false;
  bool emailExist = false;

  final _formKey = GlobalKey<FormState>();
  bool isAllFieldsValid = false;
  bool? radioValue;
  bool isChecked = false;
  bool isFullNameValid = false;

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

  void sendRequestRegister() async {
    passworkWeak = false;
    passwordShort = false;
    isEmail = false;
    emailExist = false;

    if (_formKey.currentState!.validate()) {
      var data = json.encode({
        "email": mailForWorkController.text,
        "password": passworkController.text,
        "fullname": fullNameController.text,
        "role": widget.isStudent == false ? 1 : 0,
      });

      try {
        final dio = DioClientWithoutToken();
        final response = await dio.request(
          '/auth/sign-up',
          data: data,
          options: Options(
            method: 'POST',
          ),
        );

        if (response.statusCode == 201) {
          _showSuccessDialog();
          // ignore: use_build_context_synchronously
          // Navigator.pushReplacementNamed(context, AppRouterName.login);
          print("Ok");
        } else {
          print("Sign failed: ${response.data}");
        }
      } catch (e) {
        // print(e);
        if (e is DioException && e.response != null) {
          final errorDetails = e.response!.data['errorDetails'];
          if (errorDetails != null && errorDetails is List) {
            if (errorDetails.contains('email must be an email')) {
              setState(() {
                isEmail = true;
              });
              print("Email invalid");
            } else if (errorDetails.contains(
                'password is too weak, password must be longer than or equal to 8 characters')) {
              setState(() {
                passworkWeak = true;
              });
              print("Weak");
            } else if (errorDetails.contains(
                'password must be longer than or equal to 8 characters')) {
              setState(() {
                passwordShort = true;
              });
              print("Short");
            } else if (errorDetails.contains('Email already exists')) {
              setState(() {
                emailExist = true;
              });
              print("Email exist");
            }
          }
        } else {
          print('Have Error: $e');
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Đăng ký thành công"),
          content: const Text("Hãy thực hiện xác nhận email"),
          actions: <Widget>[
            TextButton(
              child: Text("Đóng"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacementNamed(context, AppRouterName.login);
              },
            ),
          ],
        );
      },
    );
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
                    widget.isStudent == false
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
                    isEmail = false;
                    emailExist = false;
                  },
                  labelText: 'Work email address',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Work email address is required';
                    } else if (isEmail) {
                      return 'Email is invalid';
                    } else if (emailExist) {
                      return 'Email already exists';
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
                    passworkWeak = false;
                    passwordShort = false;
                  },
                  labelText: 'Password (8 or more characters)',
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else if (passworkWeak) {
                      return 'Password is too weak';
                    } else if (passwordShort) {
                      return 'Password is too short';
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
                  onPressed: isChecked
                      ? () {
                          sendRequestRegister();
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
