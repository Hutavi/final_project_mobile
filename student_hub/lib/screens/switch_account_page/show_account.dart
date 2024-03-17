import 'package:flutter/material.dart';
import 'package:student_hub/screens/switch_account_page/add_account.dart';
import 'package:student_hub/data/company_user.dart';

class ShowAccount extends StatefulWidget {
  final List<CompanyUser> _accountList;
  final List<ValueNotifier<bool>> _isLoginList;
  final Function(CompanyUser) onAccountSelected;
  final Function reloadScreen;

  ShowAccount(
    this._accountList, this.onAccountSelected, this.reloadScreen, {super.key})
    : _isLoginList = List.generate(
      _accountList.length, (index) => ValueNotifier<bool>(_accountList[index].isLogin)
      );
      @override
      _ShowAccountState createState() => _ShowAccountState();
}

class _ShowAccountState extends State<ShowAccount> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget._accountList.length + 1,
      itemBuilder: (ctx, index) {
        if (index == widget._accountList.length) {
          return const AddAccount();
        } 
        else {
          return InkWell(
            onTap: () {
              primaryFocus?.unfocus();
              setState(() {
                for (var account in widget._accountList) {
                  account.isLogin = false;
                }
                widget._accountList[index].isLogin = true;
              });
              widget.onAccountSelected(widget._accountList[index]);
              Navigator.of(context).pop();
              widget.reloadScreen();
            },
            highlightColor: Colors.grey,
            child: ListTile(
              leading: Image.asset('lib/assets/images/avatar.png'),
              title: Text(
                widget._accountList[index].fullName,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                widget._accountList[index].typeUser,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              trailing: widget._accountList[index].isLogin
                  ? const Icon(Icons.check, color: Colors.black)
                  : null,
            ),
          );
        }
      },
    );
  }
}