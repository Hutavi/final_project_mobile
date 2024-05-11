import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/screens/profile_page/profile_input_company.dart';
import 'package:student_hub/screens/student_profile/student_profile_s1.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/screens/switch_account_page/account_manager.dart';
import 'package:student_hub/models/account_models.dart';
import 'package:student_hub/widgets/custom_dialog.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  User? userCurr;
  int companyData = -1;
  int studentData = -1;

  List<AccountModel> accountList =
      []; //danh sách tất cả tài khoản đã từng đăng nhập
  List<AccountModel> inactiveAccountList =
      []; //danh sách tài khoản đã từng đăng nhập nhưng hiện tại không đăng nhập
  // Lấy danh sách tài khoản từ SharedPreferences khi widget được tạo

  late FlutterLocalization _flutterLocalization;
  late String _currentLocale;
  int role = -1;

  void getRole() async {
    role = await RoleUser.getRole();
  }

  @override
  void initState() {
    super.initState();
    _flutterLocalization = FlutterLocalization.instance;
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    // print(_currentLocale);
    getUserInfoFromToken();
    getAccounts();
    getRole();
  }

  @override
  void dispose() {
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _flutterLocalization.currentLocale!.languageCode;
    super.dispose();
  }

  // Phương thức để lấy thông tin user từ token
  Future<void> getUserInfoFromToken() async {
    try {
      final dioPrivate = DioClient();

      final respondData = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );
      late int studentDataAPI;
      late int companyDataAPI;
      if (respondData.statusCode == 200) {
        if (respondData.data['result']['student'] != null) {
          studentDataAPI = respondData.data!['result']['student']['id'];
        } else {
          studentDataAPI = -1;
        }
        if (respondData.data['result']['company'] != null) {
          companyDataAPI = respondData.data!['result']['company']['id'];
        } else {
          companyDataAPI = -1;
        }

        // final user = (respondData.data['result']);

        setState(() {
          studentData = studentDataAPI;
          print('studentData: $studentData');
          companyData = companyDataAPI;
          print('companyData: $companyData');
        });
      }
    } catch (e) {
      print(e);
      print('error');
    }
  }

  void getAccounts() async {
    List<AccountModel> inactiveAccounts =
        await AccountManager.getInactiveAccounts();
    List<AccountModel> accounts = await AccountManager.getAccounts();
    setState(() {
      accountList = accounts;
      inactiveAccountList = inactiveAccounts;
    });
  }

  void confirmLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DialogCustom(
            title: "Đăng xuất khỏi ứng dụng?",
            description: "",
            buttonText: LocaleData.confirm.getString(context),
            buttonTextCancel: LocaleData.cancel.getString(context),
            statusDialog: 4,
            onConfirmPressed: () {
              logout();
            });
      },
    );
  }

  void logout() async {
    try {
      final dio = DioClient();
      final response = await dio.request('/auth/logout',
          options: Options(
            method: 'POST',
          ));
      if (response.statusCode == 201) {
        // Xóa token từ local storage
        await TokenManager.removeTokenFromLocal();

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, AppRouterName.homePage);
      }
    } catch (e) {
      print(e);
    }
  }

  void reloadScreen() {
    accountList = [];
    Navigator.pushReplacementNamed(context, AppRouterName.switchAccount);
  }

  AccountController accountManager = AccountController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Student Hub',
        showBackButton: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: <Widget>[
            accountList.isEmpty
                ? const SizedBox()
                : ExpansionTile(
                    title: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 50,
                              height: 50,
                              child:
                                  Image.asset('lib/assets/images/avatar.png'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${accountList.where((element) => element.isLogin == true).first.getName} (${role == 1 ? LocaleData.company.getString(context) : LocaleData.student.getString(context)})',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),

                    //khi mở rộng
                    onExpansionChanged: (bool expanded) {
                      if (expanded) {}
                    },
                    children: accountList
                        .where((element) => element.isLogin == true)
                        .map((accountCurr) {
                      return GestureDetector(
                        onTap: () {},
                        child: AccountTile(
                          accountModel: accountCurr,
                          accountManager: accountManager,
                          role: role,
                        ),
                      );
                    }).toList(),
                  ),
            Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, AppRouterName.navigation);
                    },
                    icon: const Icon(Icons.home, color: kBlue400, size: 25.0),
                    label: Text(LocaleData.home.getString(context),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal)),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(double.infinity, 0),
                      disabledBackgroundColor: Colors.white,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 0.34,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      if (role == 1 && companyData == -1) {
                        print('chưa có profile company');
                        Navigator.pushNamed(
                            context, AppRouterName.profileInput);
                      } else if (role == 1 && companyData != -1) {
                        print("(đã có) edit profile company");
                        Navigator.pushNamed(
                            context, AppRouterName.editProfileCompany,
                            arguments: companyData);
                      } else {
                        print('student');
                        Navigator.pushNamed(context, AppRouterName.profileS1);
                      }
                      // else if(role == 0 && studentData == -1){
                      //   print('student');
                      //   Navigator.pushNamed(context, AppRouterName.profileS1);
                      // }
                      // else if(role == 0 && studentData != -1){
                      //   print('edit student');
                      //   Navigator.pushNamed(context, AppRouterName.profileS1);
                      // }
                    },
                    icon: const Icon(Icons.person, color: kBlue400, size: 25.0),
                    label: Text(LocaleData.profile.getString(context),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal)),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(double.infinity, 0),
                      disabledBackgroundColor: Colors.white,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 0.34,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRouterName.changePassword);
                    },
                    icon: const Icon(Icons.change_circle,
                        color: kBlue400, size: 25.0),
                    label: Text(LocaleData.changePassBtn.getString(context),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal)),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(double.infinity, 0),
                      disabledBackgroundColor: Colors.white,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 0.34,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.language,
                              color: kBlue400, size: 25.0),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${LocaleData.language.getString(context)}:',
                            style: const TextStyle(fontSize: 16),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton(
                          elevation: 0,
                          isDense: true,
                          value: _currentLocale,
                          borderRadius: BorderRadius.circular(10),
                          items: [
                            DropdownMenuItem(
                              value: 'en',
                              child: Text('English',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .color)),
                            ),
                            const DropdownMenuItem(
                              value: 'vi',
                              child: Text(
                                'Vietnamese',
                                style: TextStyle(),
                              ),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            _setLocale(newValue);
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 0.34,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton.icon(
                    onPressed: () {
                      confirmLogout();
                    },
                    icon: const Icon(Icons.logout, color: kBlue400, size: 25.0),
                    label: Text(LocaleData.logOut.getString(context),
                        style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 16.0,
                            fontWeight: FontWeight.normal)),
                    style: TextButton.styleFrom(
                      alignment: Alignment.centerLeft,
                      minimumSize: const Size(double.infinity, 0),
                      disabledBackgroundColor: Colors.white,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 0.34,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _setLocale(String? value) {
    if (value == null) return;
    if (value == 'en') {
      _flutterLocalization.translate('en');
    } else if (value == 'vi') {
      _flutterLocalization.translate('vi');
    } else {
      return;
    }

    setState(() {
      _currentLocale = value;
    });
  }
}

class AccountController {
  void reloadScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccount()),
    );
  }

  void toCreateProfileStudent(BuildContext context) {
    print('student vào dc k?');
    // Navigator.pushReplacement(context,
    // // AppRouterName.profileS1);
    // MaterialPageRoute(builder: (context) => StudentProfileS1()));
    Navigator.pushNamed(context, AppRouterName.profileS1);
  }

  void toCreateProfileCompany(BuildContext context) {
    Navigator.pushReplacement(
        context,
        // AppRouterName.profileInput);
        MaterialPageRoute(builder: (context) => ProfileInput()));
  }
}

// ignore: must_be_immutable
class AccountTile extends StatelessWidget {
  AccountModel accountModel;
  AccountController accountManager;
  int role;
  AccountTile({
    Key? key,
    required this.accountModel,
    required this.accountManager,
    required this.role,
  }) : super(key: key);

  List<dynamic> rolesList = [];

  Future<void> getRoleList() async {
    try {
      final dio = DioClient();
      final response = await dio.request('/auth/me',
          options: Options(
            method: 'GET',
          ));
      if (response.statusCode == 200) {
        final roles = response.data['result']['roles'];
        rolesList = roles;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> setRole(int role) async {
    await RoleUser.saveRole(role);
  }

  void changeRole() async {
    if (role == 1) {
      await setRole(0);
    } else if (role == 0) {
      await setRole(1);
    }
    int x = await RoleUser.getRole();
    print('role after = $x');
  }

  void selectAccount(context) async {
    await getRoleList();
    int count = 0;
    print('roleBefore: $role');
    print('rolesList: $rolesList');
    for (int i = 0; i < rolesList.length; i++) {
      if (rolesList[i] == 1) {
        count += 1;
      }
      if (rolesList[i] == 0) {
        count += 2;
      }
    }
    changeRole();
    if (count == 1) {
      print('only company');
      accountManager.toCreateProfileStudent(context);
      return;
    }
    if (count == 2) {
      print('only student');
      accountManager.toCreateProfileCompany(context);
      return;
    }
    if (count == 3) {
      print('both student and company');
      accountManager.reloadScreen(context);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('lib/assets/images/avatar.png'),
      ),
      title: Text(
          '${accountModel.getName} (${role == 1 ? LocaleData.student.getString(context) : LocaleData.company.getString(context)})'),
      onTap: () {
        selectAccount(context);
      },
    );
  }
}
