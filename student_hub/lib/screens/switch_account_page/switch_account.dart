import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/switch_account_page/account_list.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/screens/switch_account_page/add_account.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  User? userCurr;

  @override
  void initState() {
    super.initState();
    // Gọi phương thức để lấy thông tin user từ token khi widget được tạo
    getUserInfoFromToken();
  }

  // Phương thức để lấy thông tin user từ token
  Future<void> getUserInfoFromToken() async {
    // Lấy token từ local storage
    String? token = await TokenManager.getTokenFromLocal();
    print(token);
    if (token != null) {
      // Gọi API để lấy thông tin user
      User? userInfo = await ApiManager.getUserInfo(token);
      setState(() {
        print(userInfo);
        // Cập nhật userCurr với thông tin user được trả về từ API
        userCurr = userInfo;
      });
    }
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
        // String? token = await TokenManager.getTokenFromLocal();
        // print(token);
        // ignore: use_build_context_synchronously
        // Navigator.pushReplacementNamed(context, AppRouterName.login);
        // ignore: use_build_context_synchronously
        // Navigator.pushNamed(context, AppRouterName.login);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, AppRouterName.login);
      }
    } catch (e) {
      print(e);
    }
  }

  void reloadScreen() {
    //reload account
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SwitchAccount()));
  }

  AccountManager accountManager = AccountManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(
        title: 'Student Hub',
        showBackButton: true,
      ),
      body: Column(
        children: <Widget>[
          accountList.isEmpty
              ? const AddAccount()
              : ExpansionTile(
                  title: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('lib/assets/images/avatar.png'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        // accountList
                        //     .where((element) => element.isLogin == true)
                        //     .first
                        //     .getFullName(),
                        userCurr?.fullname ?? '',

                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  //khi mở rộng
                  onExpansionChanged: (bool expanded) {
                    if (expanded) {
                      // showAccountList(context);
                    }
                  },

                  children: accountList
                      .where((account) => account.signedIn && !account.isLogin)
                      .map((account) {
                    return GestureDetector(
                      onTap: () {
                        for (var i = 0; i < accountList.length; i++) {
                          accountList[i].isLogin = false;
                          if (accountList[i].userId == account.userId) {
                            accountList[i].isLogin = true;
                          }
                        }
                        reloadScreen();
                      },
                      child: AccountTile(
                        account: account,
                        accountManager: accountManager,
                      ),
                    );
                  }).toList(),
                ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              color: Colors.black,
              thickness: 0.34,
            ),
          ),
          Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    print(userCurr?.printAll());
                    print(userCurr?.companyUser?.printAll());
                    if (userCurr?.role?[0] == 1 &&
                        userCurr?.companyUser == null) {
                      print('chưa có profile company');
                      Navigator.pushNamed(context, AppRouterName.profileInput);
                    } else if (userCurr?.role?[0] == 1 &&
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
                  icon:
                      const Icon(Icons.person, color: Colors.black, size: 28.0),
                  label: const Text('Profiles',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Chiều rộng là 80% của chiều rộng màn hình
                    child: const Divider(
                      color: Colors.black,
                      thickness: 0.34,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    // Settings button pressed
                  },
                  icon: const Icon(Icons.settings,
                      color: Colors.black, size: 28.0),
                  label: const Text('Settings',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Chiều rộng là 80% của chiều rộng màn hình
                    child: const Divider(
                      color: Colors.black,
                      thickness: 0.34,
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    logout();
                  },
                  icon:
                      const Icon(Icons.logout, color: Colors.black, size: 28.0),
                  label: const Text('Log out',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.8, // Chiều rộng là 80% của chiều rộng màn hình
                    child: const Divider(
                      color: Colors.black,
                      thickness: 0.34,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
          icon: const Icon(Icons.add),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => const AddAccount()),
            // );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AccountManager {
  String currentAccountName = '';

  void updateAccountName(String name) {
    currentAccountName = name;
  }

  void reloadScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const SwitchAccount()),
    );
  }
}

class AccountTile extends StatelessWidget {
  final CompanyUser account;
  final AccountManager accountManager;

  const AccountTile({
    Key? key,
    required this.account,
    required this.accountManager,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        // backgroundImage: AssetImage('lib/assets/images/avatar_${account.userId}.png'),
        backgroundImage: const AssetImage('lib/assets/images/avatar.png'),
      ),
      title: Text(account.getFullName()),
      onTap: () {
        for (var i = 0; i < accountList.length; i++) {
          accountList[i].isLogin = false;
        }
        account.isLogin = true;
        accountManager.updateAccountName(account.getFullName());
        accountManager.reloadScreen(context);
      },
    );
  }
}
