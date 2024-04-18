import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';

class StundentProfileS3Resume extends StatefulWidget {
  const StundentProfileS3Resume({super.key});

  @override
  State<StundentProfileS3Resume> createState() =>
      _StundentProfileS3ResumeState();
}

class _StundentProfileS3ResumeState extends State<StundentProfileS3Resume> {
  var created = false;
  var idStudent = -1;
  var notify = '';
  String? resumeImage;
  var isLoading = true;
  late PdfViewerController pdfController;

  @override
  void initState() {
    super.initState();
    pdfController = PdfViewerController();
    getDataDefault();
  }

  void getDataIdStudent() async {
    final dioPrivate = DioClient();

    final responseProfileResume = await dioPrivate.request(
      '/profile/student/$idStudent/resume',
      options: Options(
        method: 'GET',
      ),
    );

    final resume = responseProfileResume.data['result'];

    setState(() {
      resumeImage = resume;
      isLoading = false;
    });
  }

  void getDataDefault() async {
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
  }

  Widget _buildDropZone() {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.cloud_upload,
            size: 60,
            color: Colors.blue,
          ),
          const Text(
            'Choose File Here',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          if (resumeImage == null)
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: _pickImageResume,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.all(10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text('Choose Image'),
              ),
            ),
        ],
      ),
    );
  }

  void _showSuccess() {
    showDialog(
      context: this.context,
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
      context: this.context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Center(
            child: Text(
              'Thất bại',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
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
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (pickedFile != null) {
      setState(() {
        isLoading = true;
      });
      final dioPrivate = DioClient();

      File imageFile = File(pickedFile.files.single.path!);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(imageFile.path,
            filename: pickedFile.files.single.path!.split('/').last),
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

          getDataIdStudent();
          _showSuccess();
        });
      } else {
        notify = 'Cập nhật resume thất bại.';

        _showError();
      }
    }
  }

  String? getFileNameFromUrl(String url) {
    return basename(Uri.parse(url).path);
  }

  Widget _showData(String? url) {
    if (url == null) {
      return const SizedBox();
    }

    String? fileName = getFileNameFromUrl(url);

    if (fileName != null && fileName.toLowerCase().endsWith('.pdf')) {
      return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(this.context).size.height * 0.58,
        child: SfPdfViewer.network(
          url,
          controller: pdfController,
        ),
      );
    }
    return Image.network(
      url,
      key: UniqueKey(),
    );
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
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Resume/CV (*)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (resumeImage != null)
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: _pickImageResume,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                padding: const EdgeInsets.all(6),
                                child: const Icon(Icons.edit,
                                    size: 16, color: Colors.blue),
                              ),
                            )
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
                                      color: Colors.blue,
                                      dashPattern: const [8, 4],
                                      strokeWidth: 2,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      child: Container(
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
                                : _showData(resumeImage),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        bottomNavigationBar: !isLoading
            ? Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                        context, AppRouterName.profileS3Transcript);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: const Text('Continue',
                      style: TextStyle(color: Colors.white)),
                ),
              )
            : const SizedBox());
  }
}