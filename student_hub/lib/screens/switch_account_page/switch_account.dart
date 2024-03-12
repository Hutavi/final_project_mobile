import "package:flutter/material.dart";
import 'package:student_hub/screens/switch_account_page/account_list.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/screens/switch_account_page/add_account.dart';
import 'package:student_hub/screens/profile_page/profile_input_company.dart';

class SwitchAccount extends StatefulWidget {
  const SwitchAccount({super.key});

  @override
  State<SwitchAccount> createState() => _SwitchAccountState();
}

class _SwitchAccountState extends State<SwitchAccount> {
  //account đã từng đăng nhập
  String currentAccount = '';

  void reloadScreen() {
    //reload account
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const SwitchAccount()));
  }

  void updateAccountName(String name) {
    setState(() {
      currentAccount = name;
    });
  }

  void showAccountList(List<CompanyUser> accounts, BuildContext contextVar) {
    //show account list
    print('Account List');
    showModalBottomSheet(
        context: contextVar,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: AccountList(
              accounts,
              (CompanyUser companyUser) {
                for (var i = 0; i < accounts.length; i++) {
                  accounts[i].isLogin = false;
                }
                companyUser.isLogin = true;
                updateAccountName(companyUser.getFullName());
                reloadScreen();
              },
              updateAccountName,
              reloadScreen,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Column(children: <Widget>[
        accountList.isEmpty
            ? const AddAccount()
            : TextButton(
                onPressed: () {
                  showAccountList(accountList, context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image.asset('lib/assets/images/avatar.png'),
                          )
                        ]),
                    Container(
                      padding: const EdgeInsets.fromLTRB(4, 4, 8, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            accountList
                                .where((element) => element.isLogin == true)
                                .first
                                .getFullName(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Transform.rotate(
                            angle: -90 * 3.141592653589793 / 180,
                            child: const Icon(
                              Icons.arrow_back_ios,
                              color: Colors.black,
                              size: 20,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
        const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              color: Colors.black,
              thickness: 0.34,
            )),
        Container(
            child: Column(children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () {
                // Profiles button pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileInput())
                );
              },
              icon: const Icon(Icons.person, color: Colors.black, size: 28.0),
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
              icon: const Icon(Icons.settings, color: Colors.black, size: 28.0),
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
                // Log out button pressed
              },
              icon: const Icon(Icons.logout, color: Colors.black, size: 28.0),
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
        ]))
      ]),
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