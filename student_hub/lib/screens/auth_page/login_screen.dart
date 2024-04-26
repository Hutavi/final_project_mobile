import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/browser_page/project_list.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/build_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool userNotFound = false;
  bool passwordWrong = false;

  @override
  void initState() {
    super.initState();
  }

  void sendRequestLogin() async {
    if (_formKey.currentState!.validate()) {
      var data = json.encode({
        "email": userNameController.text,
        "password": passwordController.text
      });
      try {
        final dio = DioClientWithoutToken();
        final response = await dio.request(
          '/auth/sign-in',
          data: data,
          options: Options(
            method: 'POST',
          ),
        );

        if (response.statusCode == 201) {
          final token = response.data['result']['token'];
          await saveTokenToLocal(token);
          // ignore: use_build_context_synchronously
          Navigator.pushReplacementNamed(context, AppRouterName.navigation);
        } else {
          print("Login failed: ${response.data}");
        }
      } catch (e) {
        if (e is DioException && e.response != null) {
          if (e.response!.data['errorDetails'] == 'Not found user') {
            setState(() {
              userNotFound = true;
            });
          } else if (e.response!.data['errorDetails'] == 'Incorrect password') {
            setState(() {
              passwordWrong = true;
            });
          }
        } else {
          print('Have Error: $e');
        }
      }
    }
  }

  Future<void> saveTokenToLocal(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        title: 'Student Hub',
        showBackButton: false,
      ),
      body: GestureDetector(
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
                        'Login with StudentHub',
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
                      labelText: 'Username or email',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username or email is required';
                        } else if (userNotFound) {
                          return 'User not found';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BuildTextField(
                      controller: passwordController,
                      inputType: TextInputType.text,
                      obscureText: true,
                      fillColor: kWhiteColor,
                      onChange: (value) {
                        // validateFields();
                        passwordWrong = false;
                      },
                      labelText: 'Password',
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (passwordWrong) {
                          return 'Password is wrong';
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
                            'Sign In',
                            style: TextStyle(
                              color: kGrey0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Center(
                      child: Text("Don't have an Student Hub account?"),
                    ),
                    Column(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, AppRouterName.register);
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
                            'Sign Up',
                            style: TextStyle(
                              color: kGrey0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
