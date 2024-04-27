import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:student_hub/services/dio_public.dart';
import 'package:student_hub/models/account_models.dart';

class AccountManager {
  static const String _key = 'accounts';

  // Lấy danh sách tài khoản từ SharedPreferences
  static Future<List<AccountModel>> getAccounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accountsJson = prefs.getString(_key);
    if (accountsJson != null) {
      List<dynamic> accountsList = jsonDecode(accountsJson);
      return accountsList.map((json) => AccountModel.fromJson(json)).toList();
    }
    return [];
  }

  //lấy danh sách tài khoản với islogin = false
  static Future<List<AccountModel>> getInactiveAccounts() async {
    List<AccountModel> accounts = await getAccounts();
    return accounts.where((account) => !account.isLogin).toList();
  }

  // Lưu danh sách tài khoản vào SharedPreferences
  static Future<void> saveAccounts(List<AccountModel> accounts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accountsJson = jsonEncode(accounts.map((account) => account.toJson()).toList());
    prefs.setString(_key, accountsJson);
  }

  static Future<void> saveAccountToLocal(String username, String password, String fullname) async {
    List<AccountModel> accounts = await getAccounts();

    // Set all account isLogin = false
    for (int i = 0; i < accounts.length; i++) {
      accounts[i] = accounts[i].copyWith(isLogin: false);
    }
  
    // Check if account is exist
    for (int i = 0; i < accounts.length; i++) {
      if (accounts[i].email == username) {
        accounts[i] = accounts[i].copyWith(isLogin: true);
        await saveAccounts(accounts);
        return;
      }
    }
    //if account is not exist, create new account
  
    AccountModel account = AccountModel(
      name: fullname,
      email: username,
      password: password,
      isLogin: true,
      // token: token,
    );

    accounts.add(account);
    await saveAccounts(accounts);
  }
  //clear shared preferences
  static Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}