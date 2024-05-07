import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/switch_account_page/account_manager.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> setRoleCurr(int value) async{
    await RoleUser.clearRole();
    // SharedPreferences prefs = await SharedPreferences.getInstance();
    await RoleUser.saveRole(value);
    int a = await RoleUser.getRole();
    // print('roleUser: $value');
    // print('curr: ' + a.toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: "Student Hub",
        showBackButton: false,
        showAction: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Content
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  // Text
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text(
                          LocaleData.homeTitle.getString(context),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Text(
                          LocaleData.homeDescribeItem.getString(context),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),

                  // Buttons
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () async {
                            await setRoleCurr(1);
                            Navigator.pushReplacementNamed(
                                context, AppRouterName.login);
                          },
                          child: Container(
                            width: double
                                .infinity, // Chiều rộng tối đa của container
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: kBlue600, // Màu nền của container
                              borderRadius: BorderRadius.circular(
                                  8.0), // Đường viền cong của container
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleData.company.getString(context),
                              style: const TextStyle(color: kWhiteColor),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () async {
                            await setRoleCurr(0);
                            Navigator.pushReplacementNamed(
                                context, AppRouterName.login);
                          },
                          child: Container(
                            width: double
                                .infinity, // Chiều rộng tối đa của container
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            decoration: BoxDecoration(
                              color: kBlue600, // Màu nền của container
                              borderRadius: BorderRadius.circular(
                                  8.0), // Đường viền cong của container
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              LocaleData.student.getString(context),
                              style: const TextStyle(color: kWhiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // List
                  Text(
                    LocaleData.homeTitle.getString(context),
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
