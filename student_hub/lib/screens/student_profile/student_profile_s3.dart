import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/navigation_menu.dart';

class StundentProfileS3 extends StatefulWidget {
  const StundentProfileS3({super.key});

  @override
  State<StundentProfileS3> createState() => _StundentProfileS3State();
}

class _StundentProfileS3State extends State<StundentProfileS3> {
  var created = false;
  var idStudent = -1;
  var notify = '';
  String? trancriptImage;
  String? resumeImage;

  @override
  void initState() {
    super.initState();
    getDataDefault();
  }

  void getDataIdStudent() async {
    final dioPrivate = DioClient();

    final responseProfileTranscript = await dioPrivate.request(
      '/profile/student/$idStudent/transcript',
      options: Options(
        method: 'GET',
      ),
    );

    final responseProfileResume = await dioPrivate.request(
      '/profile/student/$idStudent/resume',
      options: Options(
        method: 'GET',
      ),
    );

    final trancript = responseProfileTranscript.data['result'];
    final resume = responseProfileResume.data['result'];

    setState(() {
      trancriptImage = trancript;
      resumeImage = resume;
    });
  }

  void getDataDefault() async {
    try {
      final dioPrivate = DioClient();

      final responseUser = await dioPrivate.request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );

      final user = responseUser.data['result'];

      setState(() {
        if (user['student'] == null) {
          created = false;
        } else {
          created = true;
          final student = user['student'];
          idStudent = student['id'];
          getDataIdStudent();
        }
      });
    } catch (e) {
      if (e is DioException && e.response != null) {
        print(e);
      } else {
        print('Have Error: $e');
      }
    }
  }

  Widget _buildDropZone() {
    return const Center(
      child: Column(
        children: [
          Icon(
            Icons.cloud_upload,
            size: 40,
          ),
          Text(
            'Drop and Drag Image Here',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thành công'),
        content: Text(notify),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Thất bại'),
        content: Text(notify),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _pickImageResume() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final dioPrivate = DioClient();

      File imageFile = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: pickedFile.path.split('/').last),
      });

      final responseProfileResume = await dioPrivate.request(
        '/profile/student/$idStudent/resume',
        data: formData,
        options: Options(
          method: 'PUT',
        ),
      );

      if (responseProfileResume.statusCode == 200) {
        setState(() {
          notify = 'Cập nhật resume thành công.';

          _showSuccess();
          getDataIdStudent();
        });
      } else {
        notify = 'Cập nhật resume thất bại.';

        _showError();
      }
    }
  }

  void _pickImageTranscript() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final dioPrivate = DioClient();

      File imageFile = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: pickedFile.path.split('/').last),
      });

      final responseProfileTranscript = await dioPrivate.request(
        '/profile/student/$idStudent/transcript',
        data: formData,
        options: Options(
          method: 'PUT',
        ),
      );

      if (responseProfileTranscript.statusCode == 200) {
        setState(() {
          notify = 'Cập nhật transcript thành công.';

          _showSuccess();
          getDataIdStudent();
        });
      } else {
        notify = 'Cập nhật transcript thất bại.';

        _showError();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              // Welcome message
              const Padding(
                padding: EdgeInsets.only(bottom: 12.0),
                child: Text(
                  'CV & Transcript',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                child: Text(
                  'Tell us about yourself and you will be on your way to connect with real-world projects.',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ),

              // Skillset
              const Row(
                children: [
                  Expanded(
                      child: Text(
                    'Resume/CV (*)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  )),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    resumeImage == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: DottedBorder(
                              color: Colors.black,
                              dashPattern: const [8, 4],
                              strokeWidth: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 30.0),
                                child: DragTarget(
                                  builder: (
                                    BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected,
                                  ) {
                                    return _buildDropZone();
                                  },
                                ),
                              ),
                            ),
                          )
                        : Image.network(resumeImage!),
                    const SizedBox(height: 10),
                    Container(
                      // Đặt padding cho Container để căn chỉnh nút
                      alignment: Alignment
                          .bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          onPressed: _pickImageResume,
                          child: Text(
                              resumeImage == null ? 'Choose Image' : 'Change'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Transcript (*)',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    trancriptImage == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: DottedBorder(
                              color: Colors.black,
                              dashPattern: const [8, 4],
                              strokeWidth: 2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 30.0),
                                child: DragTarget(
                                  builder: (
                                    BuildContext context,
                                    List<dynamic> accepted,
                                    List<dynamic> rejected,
                                  ) {
                                    return _buildDropZone();
                                  },
                                ),
                              ),
                            ),
                          )
                        : Image.network(trancriptImage!),
                    const SizedBox(height: 10),
                    Container(
                      // Đặt padding cho Container để căn chỉnh nút
                      alignment: Alignment
                          .bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: ElevatedButton(
                          onPressed: _pickImageTranscript,
                          child: Text(trancriptImage == null
                              ? 'Choose Image'
                              : 'Change'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Next button
              Container(
                alignment: Alignment.bottomRight,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                    ),
                    onPressed: () {
                      if (resumeImage == null || trancriptImage == null) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Lỗi'),
                              content: const Text('Hãy chọn đủ ảnh.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        // Nếu cả hai hình ảnh đều đã được chọn, chuyển đến màn hình tiếp theo
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NavigationMenu(
                              companyUser: accountList[0],
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Continue',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
