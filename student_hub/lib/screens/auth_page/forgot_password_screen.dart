import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/widgets/custom_dialog.dart';
import 'package:student_hub/widgets/loading.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  bool userNotFound = false;
  bool isEmailValid = false;
  bool isLoading = false;

  void sendRequestLogin() async {
    if (_formKey.currentState!.validate()) {
      var data = json.encode({
        "email": userNameController.text,
      });

      try {
        setState(() {
          isLoading = true;
        });
        final dio = DioClientWithoutToken();
        final response = await dio.request(
          '/user/forgotPassword',
          data: data,
          options: Options(
            method: 'POST',
          ),
        );

        if (response.statusCode == 201) {
          isLoading = false;
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) => DialogCustom(
              title: "Success",
              description: "New password has been sent to your email.",
              buttonText: 'Confirm',
              // buttonTextCancel: "Cancel",
              statusDialog: 1,
              onConfirmPressed: () {
                Navigator.pushReplacementNamed(context, AppRouterName.login);
              },
            ),
          );
        } else {
          print("Login failed: ${response.data}");
        }
      } catch (e) {
        if (e is DioException && e.response != null) {
          if (e.response!.data['errorDetails'] == 'User not found') {
            setState(() {
              userNotFound = true;
            });
          } else if (e.response!.data['errorDetails'] ==
              'email must be an email') {
            setState(() {
              isEmailValid = true;
            });
          }
        } else {
          print('Have Error: $e');
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarCustom(title: 'Student Hub', showBackButton: true),
        body: SingleChildScrollView(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Center(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 16),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BuildTextField(
                            controller: userNameController,
                            inputType: TextInputType.text,
                            fillColor: kWhiteColor,
                            onChange: (value) {
                              userNotFound = false;
                              // validateFields();
                            },
                            labelText: 'Email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Email is required';
                              } else if (userNotFound) {
                                return 'User not found';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          isLoading
                              ? const LoadingWidget()
                              : OutlinedButton(
                                  onPressed: () {
                                    sendRequestLogin();
                                  },
                                  style: OutlinedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    backgroundColor: kGrey3,
                                    elevation: 0.5,
                                  ),
                                  child: const Text(
                                    'Reset Password',
                                    style: TextStyle(
                                      color: kGrey0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ]),
              ),
            ),
          ),
        ));
  }
}
