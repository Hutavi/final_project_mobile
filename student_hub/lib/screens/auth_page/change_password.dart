import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/widgets/custom_dialog.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  bool newPasswordWeak = false;
  bool oldPasswordWrong = false;

  void sendRequestChangePassword() async {
    if (_formKey.currentState!.validate()) {
      var data = json.encode(
          {"oldPassword": oldPassword.text, "newPassword": newPassword.text});
      print(data);
      try {
        final dio = DioClient();
        final response = await dio.request(
          '/user/changePassword',
          data: data,
          options: Options(
            method: 'PUT',
          ),
        );

        if (response.statusCode == 200) {
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => DialogCustom(
              title: LocaleData.success.getString(context),
              description: LocaleData.changePassSuccess.getString(context),
              buttonText: LocaleData.confirm.getString(context),
              // buttonTextCancel: "Cancel",
              statusDialog: 1,
              onConfirmPressed: () {
                Navigator.pushReplacementNamed(
                    context, AppRouterName.switchAccount);
              },
            ),
          );
        } else {
          print("Login failed: ${response.data}");
        }
      } catch (e) {
        if (e is DioException && e.response != null) {
          if (e.response!.data['errorDetails'] == 'Invalid password') {
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => DialogCustom(
                title: LocaleData.error.getString(context),
                description: LocaleData.changePassFailed.getString(context),
                buttonText: LocaleData.confirm.getString(context),
                // buttonTextCancel: "Cancel",
                statusDialog: 2,
                onConfirmPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
            setState(() {
              oldPasswordWrong = true;
            });
          } else {
            print(e.response!.data['errorDetails']);
            showDialog(
              // ignore: use_build_context_synchronously
              context: context,
              builder: (context) => DialogCustom(
                title: LocaleData.error.getString(context),
                description: LocaleData.changePassFailed.getString(context),
                buttonText: LocaleData.confirm.getString(context),
                // buttonTextCancel: "Cancel",
                statusDialog: 2,
                onConfirmPressed: () {
                  Navigator.pop(context);
                },
              ),
            );
            setState(() {
              newPasswordWeak = true;
            });
          }
        } else {
          print('Have Error: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Student Hub',
        showBackButton: false,
        showAction: true,
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          LocaleData.changePassTitle.getString(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(LocaleData.oldPassword.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      BuildTextField(
                        controller: oldPassword,
                        inputType: TextInputType.text,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          oldPasswordWrong = false;
                          // validateFields();
                        },
                        hint:
                            LocaleData.oldPasswordPlaholder.getString(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleData.passwordRequiered
                                .getString(context);
                          } else if (oldPasswordWrong) {
                            return LocaleData.passwordWrong.getString(context);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(LocaleData.newPassword.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      BuildTextField(
                        controller: newPassword,
                        inputType: TextInputType.text,
                        obscureText: false,
                        fillColor: kWhiteColor,
                        onChange: (value) {
                          // validateFields();
                          newPasswordWeak = false;
                        },
                        hint:
                            LocaleData.newPasswordPlaholder.getString(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleData.newPasswordRequired
                                .getString(context);
                          } else if (newPasswordWeak) {
                            return LocaleData.newPasswordWeak
                                .getString(context);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              sendRequestChangePassword();
                            },
                            style: OutlinedButton.styleFrom(
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              backgroundColor: kGrey3,
                              elevation: 0.5,
                            ),
                            child: Text(
                              LocaleData.changePassBtn.getString(context),
                              style: const TextStyle(
                                color: kGrey0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
