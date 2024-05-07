import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/build_text_field.dart';
import 'package:student_hub/screens/switch_account_page/account_manager.dart';
import 'package:student_hub/widgets/custom_dialog.dart';

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

          // await AccountManager.clearSharedPreferences();
          List<dynamic> roles = await ApiManager.getRoles(token);
          print(roles);
          
          //get role from local
          final roleLocal = await RoleUser.getRole();
          print('roleLocal: $roleLocal');
          
          for(int i = 0; i < roles.length; i++){
            print(roles[i]);
            if(roles[i] == roleLocal){
              
              String fullname = await ApiManager.getFullname(token);
              print(fullname);
              await AccountManager.saveAccountToLocal(userNameController.text, passwordController.text, fullname);

              // ignore: use_build_context_synchronously
              Navigator.pushReplacementNamed(context, AppRouterName.navigation); 
              return;
            }
            
          }
          //loop through roles to check if role isn't mapped with local role, then show dialog
          showDialog(
            context: context, 
            builder: (context) => DialogCustom(
              title: LocaleData.error.getString(context),
              description: 'Account is not map with your choosen role. Please choose another role.',
              buttonText: LocaleData.confirm.getString(context),
              onConfirmPressed: () {
                Navigator.pushReplacementNamed(context, AppRouterName.homePage);
              },
              statusDialog: 0,
          ));
          
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
    // Lấy chiều cao của màn hình
    final screenHeight = MediaQuery.of(context).size.height;

    // Tính toán khoảng cách 40% chiều cao của màn hình
    final spacingHeight = screenHeight * 0.3;
    return Scaffold(
      // backgroundColor: Colors.white,
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
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          LocaleData.loginTitle.getString(context),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(LocaleData.email.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      BuildTextField(
                        controller: userNameController,
                        inputType: TextInputType.text,
                        fillColor: Theme.of(context).canvasColor,
                        onChange: (value) {
                          userNotFound = false;
                          // validateFields();
                        },
                        hint: LocaleData.emailPlaholder.getString(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleData.userRequiered.getString(context);
                          } else if (userNotFound) {
                            return LocaleData.userNotFound.getString(context);
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(LocaleData.password.getString(context),
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 5,
                      ),
                      BuildTextField(
                        controller: passwordController,
                        inputType: TextInputType.text,
                        obscureText: true,
                        fillColor: Theme.of(context).canvasColor,
                        onChange: (value) {
                          // validateFields();
                          passwordWrong = false;
                        },
                        hint: LocaleData.passwordPlaceholder.getString(context),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return LocaleData.passwordRequiered
                                .getString(context);
                          } else if (passwordWrong) {
                            return LocaleData.passwordWrong.getString(context);
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
                            child: Text(
                              LocaleData.loginButton.getString(context),
                              style: const TextStyle(
                                color: kGrey0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (passwordWrong)
                        GestureDetector(
                          onTap: () => Navigator.pushNamed(
                              context, AppRouterName.forgotPassword),
                          child: Center(
                            child: Text.rich(
                              TextSpan(
                                text: LocaleData.forgotPassword
                                    .getString(context),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        LocaleData.clickHere.getString(context),
                                    style: const TextStyle(
                                      color: kRed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  SizedBox(
                    height: spacingHeight,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                          child: Text(
                        LocaleData.dontHaveAccount.getString(context),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )),
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
                            child: Text(
                              LocaleData.registerButton.getString(context),
                              style: const TextStyle(
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
      ),
    );
  }
}
