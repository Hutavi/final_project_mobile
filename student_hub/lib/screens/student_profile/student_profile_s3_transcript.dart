import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/assets/localization/locales.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/widgets/loading.dart';
import 'package:student_hub/widgets/navigation_menu.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:file_picker/file_picker.dart';

class StundentProfileS3Transcript extends StatefulWidget {
  const StundentProfileS3Transcript({super.key});

  @override
  State<StundentProfileS3Transcript> createState() =>
      _StundentProfileS3TranscriptState();
}

class _StundentProfileS3TranscriptState
    extends State<StundentProfileS3Transcript> {
  var created = false;
  var idStudent = -1;
  var notify = '';
  String? trancriptImage;
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

    final responseProfileTranscript = await dioPrivate.request(
      '/profile/student/$idStudent/transcript',
      options: Options(
        method: 'GET',
      ),
    );

    final trancript = responseProfileTranscript.data['result'];

    setState(() {
      trancriptImage = trancript;
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
          Text(
            LocaleData.chooseFile.getString(context as BuildContext),
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          if (trancriptImage == null)
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: _pickImageTranscript,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.blue,
                    padding: const EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(
                    LocaleData.chooseImage.getString(context as BuildContext),
                  )),
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
          title: Center(
            child: Text(
              LocaleData.success.getString(context),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
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
          title: Center(
            child: Text(
              LocaleData.failed.getString(context),
              style: const TextStyle(
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
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    child: Text(
                      LocaleData.cancel.getString(context),
                      style: const TextStyle(
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

  void _pickImageTranscript() async {
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

      final responseProfileTranscript = await dioPrivate.request(
        '/profile/student/$idStudent/transcript',
        data: formData,
        options: Options(
          method: 'PUT',
        ),
      );

      if (responseProfileTranscript.statusCode == 200) {
        setState(() {
          notify = LocaleData.updatedTranscriptSuccess
              .getString(context as BuildContext);

          getDataIdStudent();
          _showSuccess();
        });
      } else {
        notify = LocaleData.updatedTranscriptFailed
            .getString(context as BuildContext);

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
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 16.0),
                        child: Text(
                          LocaleData.tellUs.getString(context),
                          style: const TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Transcript (*)',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          if (trancriptImage != null)
                            InkWell(
                              borderRadius: BorderRadius.circular(50),
                              onTap: _pickImageTranscript,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground
                                          .withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 4,
                                      offset: const Offset(0, 0),
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
                            trancriptImage == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Theme.of(context).cardColor,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: DottedBorder(
                                        color: Colors.blue,
                                        dashPattern: const [8, 4],
                                        strokeWidth: 2,
                                        borderType: BorderType.RRect,
                                        radius: const Radius.circular(12),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0,
                                            vertical: 30.0,
                                          ),
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
                                    ),
                                  )
                                : _showData(trancriptImage),
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
                  color: Theme.of(context).colorScheme.background,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NavigationMenu(),
                      ),
                    );
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Center(
                            child: Text(
                              LocaleData.welcome.getString(context),
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                LocaleData.welcomeDescription
                                    .getString(context),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
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
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      LocaleData.next.getString(context),
                                      style: const TextStyle(
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
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: Text(LocaleData.continu.getString(context),
                      style: const TextStyle(color: Colors.white)),
                ),
              )
            : const SizedBox());
  }
}
