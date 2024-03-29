import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';

class StundentProfileS3 extends StatefulWidget {
  const StundentProfileS3({super.key});

  @override
  State<StundentProfileS3> createState() => _StundentProfileS3State();
}

class _StundentProfileS3State extends State<StundentProfileS3> {
  File? _imageFile;
  File? _imageFile1;

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

  void _pickImage() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  void _pickImage1() async {
    final pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile1 = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarCustom(title: "Student Hub"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Welcome message
            const Padding(
              padding: EdgeInsets.only(top: 30.0, bottom: 12.0),
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
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 16.0, left: 16.0, right: 16.0),
              child: Text(
                'Tell us about yourself and you will be on your way to connect with real-world projects.',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
            ),

            // Skillset
            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Resume/CV (*)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _imageFile == null
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
                                onAccept: (File imageFile) {
                                  setState(() {
                                    _imageFile = imageFile;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Image.file(_imageFile!),
                  const SizedBox(height: 10),
                  Container(
                    // Đặt padding cho Container để căn chỉnh nút
                    alignment: Alignment
                        .bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        child: const Text('Choose Image'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  child: Text(
                    'Transcript (*)',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )),
              ],
            ),

            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _imageFile1 == null
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
                                onAccept: (File imageFile) {
                                  setState(() {
                                    _imageFile1 = imageFile;
                                  });
                                },
                              ),
                            ),
                          ),
                        )
                      : Image.file(_imageFile1!),
                  const SizedBox(height: 10),
                  Container(
                    // Đặt padding cho Container để căn chỉnh nút
                    alignment: Alignment
                        .bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
                    child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ElevatedButton(
                        onPressed: _pickImage1,
                        child: const Text('Choose Image'),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Next button
            Container(
              padding: const EdgeInsets.only(
                  top: 16.0,
                  right: 16.0), // Đặt padding cho Container để căn chỉnh nút
              alignment:
                  Alignment.bottomRight, // Căn chỉnh nút ở dưới cùng bên phải
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // Trả về một Dialog
                        return AlertDialog(
                          title: const Text(
                            'Welcome',
                            textAlign: TextAlign.center,
                          ),
                          content: const Text(
                            'Welcome to StudentHub, a marketplace to connect Student <> Real-world projects Next',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            // Nút "Next"
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Next'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: const Text('Continue'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
