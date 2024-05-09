import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/constants/colors.dart';
import 'dart:async';
import 'dart:convert';
import 'package:student_hub/screens/switch_account_page/api_manager.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/models/user.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class EditProfile extends StatefulWidget {
  final int companyID;
  const EditProfile({super.key, required this.companyID});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  String postCompanyData = ''; //lưu trữ dữ liệu post lên API

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  Timer? _timer;

  int? _selectedValue; // Giá trị được chọn trong RadioListTile
  User? userCurr;

  // TextEditingController để điều khiển nội dung của TextField
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _websiteController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  Future<void> getUserInfoFromToken() async {
    // Lấy token từ local storage
    try {
      final dioPrivate = DioClient();

      final respondData = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );
      print(respondData.data['result']['company']);
      setState(() {
        int size = (respondData.data['result']['company']['size']);
        print(size);
        _companyNameController.text =
            respondData.data['result']['company']['companyName'] ?? '';
        _websiteController.text = respondData.data['result']['company']['website'] ?? '';
        _descriptionController.text =
            respondData.data['result']['company']['description'] ?? '';
        switch (size) {
          case 0:
            _selectedValue = 0;
            break;
          case 1:
            _selectedValue = 1;
            break;
          case 2:
            _selectedValue = 2;
            break;
          case 3:
            _selectedValue = 3;
            break;
          case 4:
            _selectedValue = 4;
            break;
          default:
            _selectedValue = null;
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    getUserInfoFromToken();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
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
    // Giải phóng controller
    _companyNameController.dispose();
    _websiteController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _editProfile() async {
    String token = await TokenManager.getTokenFromLocal();
    var requestData = json.encode({
      'companyName': _companyNameController.text,
      'size': _selectedValue,
      'website': _websiteController.text,
      'description': _descriptionController.text,
    });
    print(requestData);

    try {
      // ignore: unused_local_variable
      final response = await DioClient().request(
        '/profile/company/${widget.companyID}',
        data: requestData,
        options: Options(method: 'PUT'),
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
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBarCustom(title: 'Edit Profile'),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleData.edtProfileCompanyTitle.getString(context),
                      style: const TextStyle(
                        // color: Colors.black,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          LocaleData.companyName.getString(context),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            // color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _companyNameController,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 0.5),
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
                    Row(
                      children: [
                        Text(
                          LocaleData.website.getString(context),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _websiteController,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 0.5),
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
                    Row(
                      children: [
                        Text(
                          LocaleData.description.getString(context),
                          textAlign: TextAlign.left,
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa các hàng
                    TextField(
                      controller: _descriptionController,
                      cursorColor: Theme.of(context).colorScheme.onBackground,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).cardColor,
                        filled: true,
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
                          borderSide:
                              const BorderSide(color: Colors.black, width: 0.5),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleData.howManyPeopleInYourCompany.getString(context),
                      style: const TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        RadioListTile<int>(
                          title: Text(LocaleData.itJustMe.getString(context),
                              style: const TextStyle(fontSize: 14)),
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
                          title: Text(
                              '2-9 ${LocaleData.employees.getString(context)}',
                              style: const TextStyle(fontSize: 14)),
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
                          title: Text(
                              '10-99 ${LocaleData.employees.getString(context)}',
                              style: const TextStyle(fontSize: 14)),
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
                          title: Text(
                              '100-1000 ${LocaleData.employees.getString(context)}',
                              style: const TextStyle(fontSize: 14)),
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
                          title: Text(
                              '${LocaleData.moreThan.getString(context)} 1000 ${LocaleData.employees.getString(context)}',
                              style: const TextStyle(fontSize: 14)),
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
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.5),
                          end: const Offset(0, 0),
                        ).animate(
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
                              _editProfile();
                            },
                            height: 45,
                            color: kBlue400,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              LocaleData.edit.getString(context),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10), // Khoảng cách giữa hai button
                    Expanded(
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, -0.5),
                          end: const Offset(0, 0),
                        ).animate(
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
                              Navigator.pop(context);
                            },
                            height: 45,
                            color: kRed,
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              LocaleData.cancel.getString(context),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}


// class _AppBar extends StatelessWidget implements PreferredSizeWidget {
//   const _AppBar({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       title: const Text('Student Hub',
//           style: TextStyle(
//               color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
//       backgroundColor: Colors.grey[200],
//       actions: <Widget>[
//         IconButton(
//           icon: SizedBox(
//             width: 25,
//             height: 25,
//             child: Image.asset('lib/assets/images/avatar.png'),
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
// }