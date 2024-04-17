import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/data/company_user.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/widgets/navigation_menu.dart';

class StundentProfileS3 extends StatefulWidget {
  const StundentProfileS3({super.key});

  @override
  State<StundentProfileS3> createState() => _StundentProfileS3State();
}

class _StundentProfileS3State extends State<StundentProfileS3> {
  File? imageFileResume;
  File? imageFileTranscript;
  var created = false;
  var idStudent = -1;
  var notify = '';
  String? trancriptImage;
  String? resumeImage;
  var isLoading = true;

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
      isLoading = false;
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
            size: 60,
            color: Colors.blue,
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
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Thành công',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue, // Màu của tiêu đề
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notify,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showError() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Thất bại',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red, // Màu của tiêu đề
              ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                notify,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      'Cancle',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _pickImageResume() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final dioPrivate = DioClient();

      imageFileResume = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFileResume!.path,
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
          if (resumeImage != null) {
            getDataIdStudent();
          }
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

      imageFileTranscript = File(pickedFile.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFileTranscript!.path,
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
          if (trancriptImage != null) {
            getDataIdStudent();
          }
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
        body: isLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
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
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Resume/CV (*)',
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
                            resumeImage == null
                                ? imageFileResume == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: DottedBorder(
                                          color: Colors.black,
                                          dashPattern: const [8, 4],
                                          strokeWidth: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 30.0),
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
                                    : Image.file(imageFileResume!)
                                : Image.network(resumeImage!),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ElevatedButton(
                                  onPressed: _pickImageResume,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    padding: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  child: Text(resumeImage == null
                                      ? 'Choose Image'
                                      : 'Change'),
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
                                ? imageFileTranscript == null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: DottedBorder(
                                          color: Colors.black,
                                          dashPattern: const [8, 4],
                                          strokeWidth: 2,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20.0,
                                                vertical: 30.0),
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
                                    : Image.file(imageFileTranscript!)
                                : Image.network(trancriptImage!),
                            const SizedBox(height: 10),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: ElevatedButton(
                                  onPressed: _pickImageTranscript,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.blue,
                                    padding: const EdgeInsets.all(
                                        10), // Padding của nút
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          6), // Bo tròn cho nút
                                    ),
                                  ),
                                  child: Text(trancriptImage == null
                                      ? 'Choose Image'
                                      : 'Change'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: !isLoading
            ? Container(
                padding:
                    const EdgeInsets.all(10), // Padding của bottomNavigationBar
                decoration: BoxDecoration(
                  color: Colors.white, // Màu nền của bottomNavigationBar
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Màu của đổ bóng
                      spreadRadius: 2, // Bán kính lan rộng của đổ bóng
                      blurRadius: 4, // Độ mờ của đổ bóng
                      offset: const Offset(0, 2), // Độ dịch chuyển của đổ bóng
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NavigationMenu(
                          companyUser: accountList[0],
                        ),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Center(
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue, // Màu của tiêu đề
                              ),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Welcome to StudentHub, a marketplace to connect Student <> Real-world projects',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6)),
                                    ),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      'Next',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.blue, // Màu nền của nút
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // Bo tròn cho nút
                    ),
                  ),
                  child: const Text('Continue',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            : const SizedBox());
  }
}
