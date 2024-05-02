import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:student_hub/models/project_models/project_model_for_list.dart';
import 'package:student_hub/services/dio_client.dart';
import 'package:flutter/material.dart';
import 'package:student_hub/widgets/app_bar_custom.dart';
import 'package:student_hub/routers/route_name.dart';
import 'package:student_hub/constants/colors.dart';

class SubmitProposal extends StatefulWidget {
  final ProjectForListModel projectId;
  const SubmitProposal({super.key, required this.projectId});

  @override
  State<SubmitProposal> createState() => SubmitProposalState();
}

class SubmitProposalState extends State<SubmitProposal> {
  int idStudent = -1;
  TextEditingController coverLetterController = TextEditingController();

  Future<void> getStudentId() async {
    try {
      final response = await DioClient().request(
        '/auth/me',
        options: Options(
          method: 'GET',
        ),
      );
      final user = response.data['result'];
      setState(() {
        if (user['student'] == null) {
          print('Student not found');
        } else {
          final student = user['student'];
          idStudent = student['id'];
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

  void submitProposal() async {
    try {
      print('bắt đầu chạy hàm submitProposal()');
      // print(idStudent);
      final response = await DioClient().request(
        '/proposal',
        data: jsonEncode({
          'projectId': widget.projectId.id,
          'studentId': idStudent,
          'coverLetter': (coverLetterController.text),
          'statusFlag':
              0, // {0: waiting -> submitted}, {1: offer(chat with company) -> activity}, {2: hired (accept offer from company) -> working flow}
          'disableFlag': 1, // {0: disable}, {1: enable} |||
        }),
        options: Options(method: 'POST'),
      );
      print(response.data['result']);

      if (response.statusCode == 201) {
        print('Proposal submitted');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarCustom(
        title: 'Student Hub',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Cover letter',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Describe why do you fit to this project',
                  style: TextStyle(
                      fontSize: 13,
                      // fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: coverLetterController,
              maxLines: 6,
              decoration: const InputDecoration(
                  hintText: '',
                  enabledBorder: OutlineInputBorder(
                    // borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(10.0),
                      bottom: Radius.circular(10.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10.0),
                          bottom: Radius.circular(10.0)))),
              onChanged: (value) {
                coverLetterController.text;
              },
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: kWhiteColor,
                        foregroundColor: kRed),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      getStudentId().then((_) {
                        // Sau khi getStudentId() hoàn thành, gọi submitProposal()
                        submitProposal();
                      });
                      Navigator.pushNamed(context, AppRouterName.navigation);
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: kWhiteColor,
                        foregroundColor: kBlue700),
                    child: const Text('Submit proposal'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
