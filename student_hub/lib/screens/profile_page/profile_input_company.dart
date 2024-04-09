import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:student_hub/constants/colors.dart';
import 'package:student_hub/routers/route.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/models/user.dart';

class ProfileInput extends StatefulWidget {
  const ProfileInput({super.key});

  @override
  State<ProfileInput> createState() => _NewLoginPageState();
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Student Hub',
          style: TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.grey[200],
      actions: <Widget>[
        IconButton(
          icon: SizedBox(
            width: 25,
            height: 25,
            child: Image.asset('lib/assets/images/avatar.png'),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NewLoginPageState extends State<ProfileInput> with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  int? _selectedValue;

  // TextEditingController để điều khiển nội dung của TextField
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {
          activeIndex++;

          if (activeIndex == 4) {
            activeIndex = 0;
          }
        });
      }
    });

    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.8, curve: Curves.easeIn),
      ),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _createProfile() async {
    String token = await TokenManager.getTokenFromLocal();
    var requestData = json.encode({
      'companyName': _companyNameController.text,
      'size': _selectedValue,
      'website': _websiteController.text,
      'description': _descriptionController.text,
    });
    print(requestData);

    try {
      // Gửi yêu cầu PUT lên API
      // ignore: unused_local_variable
      final response = await DioClient().request(
        '/profile/company/',
        data: requestData,
        options: Options(
          method: 'POST'
          ),
      );

      User? userInfo = await ApiManager.getUserInfo(token);
      print(userInfo?.companyUser?.companyName);
    } catch (e) {
      print(e.toString());
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const _AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to Student Hub',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tell us about your company and you will be on',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'your way connect with high-skilled students',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How many people are in your company?',
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        RadioListTile<int>(
                          title: const Text('It\'s just me',
                              style: TextStyle(fontSize: 14)),
                          dense: true,
                          value: 0,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          activeColor: kBlue400,
                        ),
                        RadioListTile<int>(
                          title: const Text('2-9 employees',
                              style: TextStyle(fontSize: 14)),
                          dense: true,
                          value: 1,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          activeColor: kBlue400,
                        ),
                        RadioListTile<int>(
                          title: const Text('10-99 employees',
                              style: TextStyle(fontSize: 14)),
                          dense: true,
                          value: 2,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          activeColor: kBlue400,
                        ),
                        RadioListTile<int>(
                          title: const Text('100-1000 employees',
                              style: TextStyle(fontSize: 14)),
                          dense: true,
                          value: 3,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          activeColor: kBlue400,
                        ),
                        RadioListTile<int>(
                          title: const Text('More than 1000 employees',
                              style: TextStyle(fontSize: 14)),
                          dense: true,
                          value: 4,
                          groupValue: _selectedValue,
                          onChanged: (value) {
                            setState(() {
                              _selectedValue = value;
                            });
                          },
                          activeColor: kBlue400,
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Company Name',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _companyNameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: '',
                        hintText: 'Your Company Name!',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Website',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _websiteController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: '',
                        hintText: 'Your Company Website!',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          'Description',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _descriptionController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: '',
                        hintText: 'Desciption about your company!',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        labelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        floatingLabelStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18.0,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Đặt nút ở phía bên phải
                  children: [
                    SlideTransition(
                      position: Tween<Offset>(
                              begin: const Offset(0, -0.5),
                              end: const Offset(0, 0))
                          .animate(
                        CurvedAnimation(
                          parent: _animationController,
                          curve: const Interval(
                            0.6,
                            1,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                      ),
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: MaterialButton(
                          onPressed: () {
                            _createProfile();
                            Navigator.pushNamed(context, AppRouterName.welcomeScreen);
                          },
                          height: 45,
                          color: kBlue400,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: const Text(
                            "Continue",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ));
  }
}
