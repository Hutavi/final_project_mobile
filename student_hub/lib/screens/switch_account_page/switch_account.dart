import 'package:dio/dio.dart';
import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
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
  
  List<AccountModel> accountList = []; //danh sách tất cả tài khoản đã từng đăng nhập
  List<AccountModel> inactiveAccountList = []; //danh sách tài khoản đã từng đăng nhập nhưng hiện tại không đăng nhập 

  // Lấy danh sách tài khoản từ SharedPreferences khi widget được tạo
  void initState() {
    super.initState();

    getUserInfoFromToken();
    getAccounts();
  }
  void dispose() {
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
    List<AccountModel> inactiveAccounts = await AccountManager.getInactiveAccounts();
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
        String? token = await TokenManager.getTokenFromLocal();
        print(token);
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
      appBar: const AppBarCustom(
        title: 'Student Hub',
        showBackButton: false,
      ),
      body: Column(
        children: <Widget>[
          accountList.isEmpty
              ? const SizedBox()
              : 
              ExpansionTile(
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
                      accountList
                          .where((element) => element.isLogin == true)
                          .first
                          .getName,
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
                  }
                },
                children: inactiveAccountList.map((inactiveAccount) {
                  return GestureDetector(
                    onTap: () {},
                    child: AccountTile(
                      accountModel: inactiveAccount,
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
                    Navigator.pushReplacementNamed(context, AppRouterName.navigation);
                  },
                  icon:
                      const Icon(Icons.home, color: Colors.black, size: 28.0),
                  label: const Text('Home',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal)),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft, // Căn chỉnh nút về phía trái
                    minimumSize: Size(double.infinity, 0),
                    disabledBackgroundColor: Colors.white,
                  ),
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
                    // print(userCurr?.companyUser?.printAll());
                    if (userCurr?.roles?[0] == 1 &&
                        userCurr?.companyUser == null) {
                      print('chưa có profile company');
                      Navigator.pushNamed(context, AppRouterName.profileInput);
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
                  icon:
                      const Icon(Icons.person, color: Colors.black, size: 28.0),
                  label: const Text('Profiles',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.normal)),
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft, // Căn chỉnh nút về phía trái
                    minimumSize: Size(double.infinity, 0),
                    disabledBackgroundColor: Colors.white,
                  ),
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
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft, // Căn chỉnh nút về phía trái
                    minimumSize: Size(double.infinity, 0),
                    disabledBackgroundColor: Colors.white,
                  ),
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
                  style: TextButton.styleFrom(
                    alignment: Alignment.centerLeft, // Căn chỉnh nút về phía trái
                    minimumSize: Size(double.infinity, 0),
                    disabledBackgroundColor: Colors.white,
                  ),
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

class AccountController { 
  void reloadScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SwitchAccount()),
    );
  }
}

class AccountTile extends StatelessWidget {
  AccountModel accountModel;
  AccountController accountManager;

  AccountTile({
    Key? key,
    required this.accountModel,
    required this.accountManager,
  }) : super(key: key);

  Future<void> sendRequestToLogIn(String username, String password) async{
    try {
      final dio = DioClientWithoutToken();
      final response = await dio.request(
        '/auth/sign-in',
        data: jsonEncode({
          "email": username,
          "password": password,
        }),
        options: Options(
          method: 'POST',
        ),
      );
      if (response.statusCode == 201) {
        final token = response.data['result']['token'];

        print('Login success: $token');
        
        await saveTokenToLocal(token);
        
        String fullname = await ApiManager.getFullname(token);
        // print('fullname');
        // print(fullname);

        await AccountManager.saveAccountToLocal(username, password, fullname);
        // List<AccountModel> ss = await AccountManager.getAccounts();
        // for(var i = 0; i<ss.length; i++){
        //   if(ss[i].getIsLogin==true){
        //     print('sendRequestToLogIn:');
        //     print(ss[i].getName);
        //   }
        // }
      } else {
        print("Login failed: ${response.data}");
      }
    } catch (e) {
      if (e is DioException && e.response != null) {
        if (e.response!.data['errorDetails'] == 'Not found user') {
          print('User not found');
        } else if (e.response!.data['errorDetails'] == 'Incorrect password') {
          print('Incorrect password');
        }
      }
    }
  }

  Future<void> saveTokenToLocal(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', token);
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
        String? token = await TokenManager.getTokenFromLocal();
        if(token == ''){
          print('Logout success');
        }
        else{
          print(token);
          print('Logout failed');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  List<AccountModel> accountList = []; //danh sách tất cả tài khoản đã từng đăng nhập
  List<AccountModel> inactiveAccountList = []; //danh sách tài khoản đã từng đăng nhập nhưng hiện tại không đăng nhập 
  
  void getAccounts() async {
    List<AccountModel> inactiveAccounts = await AccountManager.getInactiveAccounts();
    List<AccountModel> accounts = await AccountManager.getAccounts();  
  
    accountList = accounts;
    inactiveAccountList = inactiveAccounts;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        // backgroundImage: AssetImage('lib/assets/images/avatar_${account.userId}.png'),
        backgroundImage: AssetImage('lib/assets/images/avatar.png'),
      ),
      title: Text(accountModel.getName),
      onTap: () {
        logout();
        sendRequestToLogIn(accountModel.getEmail, accountModel.getPassword).then((_) {
          accountManager.reloadScreen(context);}
        );
      },
    );
  }
}
