import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
