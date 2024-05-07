import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'dart:convert';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/screens/switch_account_page/account_manager.dart';
import 'package:student_hub/models/account_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  User? userCurr;
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
  }

  @override
  void dispose() {
    _currentLocale = _flutterLocalization.currentLocale!.languageCode;
    _flutterLocalization.currentLocale!.languageCode;
    super.dispose();
  }

  // Phương thức để lấy thông tin user từ token
  Future<void> getUserInfoFromToken() async {
    String? token = await TokenManager.getTokenFromLocal();

    User? userInfo = await ApiManager.getUserInfo(token);
    setState(() {
      userCurr = userInfo;
    });
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

  void logout() async {
    //getToken

    // Gọi API để logout
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
        Navigator.pushReplacementNamed(context, AppRouterName.login);
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
      // backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                          '${accountList
                              .where((element) => element.isLogin == true)
                              .first
                              .getName} (${role == 1 ? 'Company' : 'Student'})',
                          style: TextStyle(
                            color:
                                Theme.of(context).textTheme.labelMedium!.color,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),

                    //khi mở rộng
                    onExpansionChanged: (bool expanded) {
                      if (expanded) {}
                    },
                    children: accountList
                              .where((element) => element.isLogin == true).map((accountCurr) {
                      return GestureDetector(
                        onTap: () {},
                        child: AccountTile(
                          accountModel: accountCurr,
                          accountManager: accountManager,
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
                    label: Text(
                        LocaleData.home.getString(context),
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
                      // print(userCurr?.companyUser?.printAll());
                      if (userCurr?.roles?[0] == 1 &&
                          userCurr?.companyUser == null) {
                        print('chưa có profile company');
                        Navigator.pushNamed(
                            context, AppRouterName.profileInput);
                      } else if (userCurr?.roles?[0] == 1 &&
                          userCurr?.companyUser != null) {
                        print("(đã có) edit profile company");
                        Navigator.pushNamed(
                            context, AppRouterName.editProfileCompany,
                            arguments: userCurr?.companyUser);
                      } else {
                        print('student');
                        Navigator.pushNamed(context, AppRouterName.profileS1);
                      }
                    },
                    icon: const Icon(Icons.person, color: kBlue400, size: 25.0),
                    label: Text(
                        LocaleData.profile.getString(context),
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
                      // Settings button pressed
                    },
                    icon:
                        const Icon(Icons.settings, color: kBlue400, size: 25.0),
                    label: Text(
                        LocaleData.settings.getString(context),
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
                          Icon(Icons.language, color: kBlue400, size: 25.0),
                          SizedBox(
                            width: 8,
                          ),
                          Text(
                            '${LocaleData.language.getString(context)}:',
                            style: TextStyle(fontSize: 16),
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
                            DropdownMenuItem(
                              value: 'vi',
                              child: Text('Vietnamese',
                                  style: TextStyle(
                                    // color: Theme.of(context).colorScheme.onBackground,
                                    color: Theme.of(context)
                                          .textTheme
                                          .labelLarge!
                                          .color
                                    ),),
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
                      logout();
                    },
                    icon: const Icon(Icons.logout, color: kBlue400, size: 25.0),
                    label: Text(
                        LocaleData.logOut.getString(context),
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
  
  int role =-1;

  Future<void> getRole() async {
    role = await RoleUser.getRole();
  }
  Future<void> setRole (int role) async {
    await RoleUser.saveRole(role);
  }

  void changeRole(){
    if(role == 1){
      setRole(0);
    }
    else if(role == 0) {
      setRole(1);
    }
  }

  void reloadScreen(BuildContext context) {
    changeRole();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SwitchAccount()),
    );
  }

  void toCreateProfileStudent(BuildContext context){
    changeRole();
    Navigator.pushNamed(context, AppRouterName.profileS1);
  }

  void toCreateProfileCompany(BuildContext context){
    changeRole();
    Navigator.pushNamed(context, AppRouterName.profileInput);
  }
}

class AccountTile extends StatelessWidget{
  AccountModel accountModel;
  AccountController accountManager;

  AccountTile({
    Key? key,
    required this.accountModel,
    required this.accountManager,
  }) : super(key: key);
  
  int role = -1;
  List<dynamic> rolesList = [];

  Future<void> getRole() async {
    role = await RoleUser.getRole();
  }

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

  Future<int> checkRole() async {
    await getRole();
    await getRoleList();
    int count = 0;
    for(var role in rolesList){
      if(role == 1){
        count +=1;
      }
      if(role == 2){
        count += 2;
      }
    }
    if(count == 1){
      print('only company');
      return 1;
    }
    if(count == 2){
      print('only student');
      return 2;
    }
    if(count == 3){
      print('both');
      return 3;
    }
    return -1;
  }

  void selectAccount(context) async {
    final int rst = await checkRole();
    if(rst == 1){
      accountManager.toCreateProfileStudent(context);
    }
    if(rst == 2){
      accountManager.toCreateProfileCompany(context);
    }
    if(rst == 3){
      accountManager.reloadScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('lib/assets/images/avatar.png'),
      ),
      title: Text('${accountModel.getName} (${role == 1 ? 'Student' : 'Company'})'),
      onTap: () async {  
        selectAccount(context);
      },
    );
  }
}

