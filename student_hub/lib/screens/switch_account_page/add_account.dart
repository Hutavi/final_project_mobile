import 'package:flutter/material.dart';

class AddAccount extends StatelessWidget {
  const AddAccount({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 380,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: () {
            //add account
            //chưa cập nhật tính năng
          },
          child: const Text('Add Account'),
        ),
      )
    );
  }
}