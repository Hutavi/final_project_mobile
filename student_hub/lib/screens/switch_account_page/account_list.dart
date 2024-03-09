import 'package:flutter/material.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/screens/switch_account_page/show_account.dart';
import 'package:student_hub/screens/switch_account_page/add_account.dart';  

class AccountList extends StatelessWidget{
  final List<CompanyUser> accountList;
  Function(CompanyUser) onAccountSelected;
  Function(String) updateAccountName;
  Function reloadScreen;

  AccountList(this.accountList, this.onAccountSelected, this.updateAccountName, this.reloadScreen, {super.key});
  
  @override 
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        height: 350,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget> [
            Row(
              children: <Widget>[const
                Padding(padding: EdgeInsets.only(left: 100.0),
                child: Text(
                  'Switch accounts',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )),
                Padding(padding: const EdgeInsets.only(left: 60.0),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(); //đóng danh sách các account
                  },
                ),
                ),
              ]
            ),
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              height:250,
              child: ShowAccount(accountList, onAccountSelected, reloadScreen ),
            ),
          ],
        ),
      )
    );
  }
}
