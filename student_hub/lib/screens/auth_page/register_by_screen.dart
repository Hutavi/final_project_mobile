import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
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
  TextEditingController confirmPasswordController = TextEditingController();
  bool passworkWeak = false;
  bool passwordShort = false;
  bool isEmail = false;
  bool emailExist = false;
  bool isPasswordMatch = true;

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
          title: Text(LocaleData.regisSuccess.getString(context)),
          content: Text(LocaleData.verifyEmail.getString(context)),
          actions: <Widget>[
            TextButton(
              child: Text(LocaleData.close.getString(context)),
              onPressed: () {
                // Navigator.of(context).pop();
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
      // backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Student Hub',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(AppRouterName.login));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
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
                          ? LocaleData.registerByCompanyTitle.getString(context)
                          : LocaleData.registerByStudentTitle
                              .getString(context),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(LocaleData.registerFullname.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  BuildTextField(
                    controller: fullNameController,
                    inputType: TextInputType.text,
                    fillColor: kWhiteColor,
                    onChange: (value) {
                      // validateFields();
                    },
                    hint: LocaleData.fullNamePlaholder.getString(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleData.fullNameRequired.getString(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleData.email.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
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
                    hint: LocaleData.emailPlaholder.getString(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleData.userRequiered.getString(context);
                      } else if (isEmail) {
                        return LocaleData.userNotFound.getString(context);
                      } else if (emailExist) {
                        return LocaleData.emailExist.getString(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(LocaleData.password.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
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
                    hint: LocaleData.validPassword.getString(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleData.passwordRequiered.getString(context);
                      } else if (passworkWeak) {
                        return LocaleData.passworkWeak.getString(context);
                      } else if (passwordShort) {
                        return LocaleData.passwordShort.getString(context);
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(LocaleData.registerConfirmPass.getString(context),
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  const SizedBox(
                    height: 5,
                  ),
                  BuildTextField(
                    controller: confirmPasswordController,
                    inputType: TextInputType.text,
                    fillColor: kWhiteColor,
                    onChange: (value) {
                      isPasswordMatch = true;
                    },
                    hint: LocaleData.validPassword.getString(context),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return LocaleData.requiredConfirmPassword
                            .getString(context);
                      } else if (value != passworkController.text) {
                        isPasswordMatch = false;
                        return LocaleData.passwordNotMatch.getString(context);
                      }
                      return null;
                    },
                  ),
                  if (!isPasswordMatch)
                    Text(
                      LocaleData.passwordNotMatch.getString(context),
                      style: const TextStyle(color: kRed),
                    ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            fillColor:
                                MaterialStateProperty.resolveWith<Color?>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.green;
                                }
                                return Colors.transparent;
                              },
                            ),
                            onChanged: (value) {
                              setState(() {
                                isChecked = value ?? false;
                              });
                            },
                            side: BorderSide(
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(LocaleData.sayYes.getString(context),
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                )),
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
                    child: Text(
                      LocaleData.createButton.getString(context),
                      style: const TextStyle(
                          color: kGrey0,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
